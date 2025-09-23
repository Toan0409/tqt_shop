package vn.java.laptopshop.controller.admin;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.java.laptopshop.domain.Role;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.repository.RoleRepository;
import vn.java.laptopshop.service.UploadService;
import vn.java.laptopshop.service.UserService;

@Controller
public class UserController {

    private final RoleRepository roleRepository;
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(RoleRepository roleRepository, UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.roleRepository = roleRepository;
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String showUserList(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page) {
        if (page < 1)
            page = 1;

        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<User> usersPage = userService.getAllUsersPaged(pageable);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", usersPage.getTotalPages());
        model.addAttribute("users1", usersPage.getContent());
        return "admin/user/manageUser";
    }

    @GetMapping("/admin/user/add")
    public String getRegisterPage(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("roles", roleRepository.findAll());
        return "admin/user/addUser";
    }

    @PostMapping("/admin/user/add")
    public String createUserPage(Model model,
            @ModelAttribute("newUser") @Valid User user,
            BindingResult bindingResult,
            @RequestParam("image") MultipartFile imageFile) {

        // Log lỗi nếu có
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getObjectName() + " - " + error.getDefaultMessage());
        }

        // Lấy roleId từ user
        Long roleId = user.getRole() != null ? user.getRole().getId() : null;

        if (roleId == null) {
            model.addAttribute("error", "Vui lòng chọn vai trò!");
            model.addAttribute("roles", roleRepository.findAll());
            return "admin/user/pages-register";
        }

        Optional<Role> role = roleRepository.findById(roleId);
        if (role.isEmpty()) {
            model.addAttribute("error", "Vai trò không hợp lệ!");
            model.addAttribute("roles", roleRepository.findAll());
            return "admin/user/pages-register";
        }

        user.setRole(role.get());

        String avatarUrl = uploadService.handleSaveUploadFile(imageFile, "avatar");
        if (avatarUrl == null) {
            return "error";
        }

        user.setAvatar(avatarUrl);

        // Mã hóa mật khẩu
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @PostMapping("/admin/user/upload-csv")
    public String uploadCsvFile(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return "redirect:/admin/user?error=File trống";
        }

        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8))) {

            String line;
            boolean firstLine = true; // bỏ header
            while ((line = br.readLine()) != null) {
                if (firstLine) {
                    firstLine = false;
                    continue;
                }

                try {
                    String[] data = line.split(",");
                    if (data.length >= 6) {
                        User user = new User();
                        user.setEmail(data[0].trim());

                        // Mã hoá mật khẩu
                        user.setPassword(passwordEncoder.encode(data[1].trim()));

                        user.setFullName(data[2].trim());

                        try {
                            user.setPhoneNumber(Long.parseLong(data[3].trim()));
                        } catch (NumberFormatException e) {
                            user.setPhoneNumber(null);
                        }

                        user.setAddress(data[4].trim());

                        // role: tìm theo tên trong DB
                        Role role = roleRepository.findByName(data[5].trim().toUpperCase());
                        if (role == null) {
                            System.err.println("Role không tồn tại: " + data[5]);
                            continue; // bỏ qua user này
                        }
                        user.setRole(role);

                        userService.handleSaveUser(user);
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    System.err.println("Lỗi khi xử lý dòng: " + line);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/admin/user?error=Không đọc được file";
        }

        return "redirect:/admin/user";
    }

}
