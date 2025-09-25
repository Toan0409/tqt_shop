package vn.java.laptopshop.controller.admin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.java.laptopshop.domain.Role;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.domain.dto.RegisterDTO;
import vn.java.laptopshop.repository.RoleRepository;
import vn.java.laptopshop.service.AiCustomerService;
import vn.java.laptopshop.service.UploadService;
import vn.java.laptopshop.service.UserService;

@Controller
public class UserController {

    private final RoleRepository roleRepository;
    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;
    private final AiCustomerService aiCustomerService;

    public UserController(RoleRepository roleRepository, UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder, AiCustomerService aiCustomerService) {
        this.roleRepository = roleRepository;
        this.aiCustomerService = aiCustomerService;
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String showUserList(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "keyword", required = false) String keyword) {
        if (page < 1)
            page = 1;

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<User> usersPage;
        if (keyword != null && !keyword.isEmpty()) {
            usersPage = userService.searchUsersByKeyword(keyword, pageable);
            model.addAttribute("keyword", keyword);
        } else
            usersPage = userService.getAllUsersPaged(pageable);

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

    @PostMapping("/admin/user/add-by-upload-csv")
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

    @PostMapping("admin/user/add-random-ai")
    public String addRandomCustomer() {
        RegisterDTO dto = aiCustomerService.generateRandomCustomer();

        User user = new User();
        user.setFullName(dto.getFullName());
        user.setEmail(dto.getEmail());
        user.setPhoneNumber(dto.getPhoneNumber());
        user.setAddress(dto.getAddress());
        user.setAvatar(dto.getAvatar());
        user.setPassword(passwordEncoder.encode("123456")); // mật khẩu mặc định

        Role customerRole = roleRepository.findByName("USER");
        if (customerRole == null) {
            throw new RuntimeException("Role CUSTOMER chưa có");
        }
        user.setRole(customerRole);

        userService.handleSaveUser(user);

        return "redirect:/admin/user";
    }

    @GetMapping("admin/user/{id}")
    public String viewUserDetail(Model model, @PathVariable("id") Long id) {
        User user = userService.findUserById(id);

        if (user == null) {
            model.addAttribute("errorMessage", "Không tìm thấy khách hàng với ID = " + id);
            return "admin/user/not-found"; // bạn có thể tạo 1 trang thông báo lỗi riêng
        }

        model.addAttribute("user", user);
        return "admin/user/viewUserDetail";
    }

    @GetMapping("admin/user/delete/{id}")
    public String deleteUserByID(Model model, @PathVariable("id") Long id) {
        User user = userService.findUserById(id);
        model.addAttribute("user", user);
        return "admin/user/deleteUser";
    }

    @PostMapping("admin/user/delete/{id}")
    public String deleteUserByIDConfirm(@PathVariable("id") Long id) {
        userService.deleteUserById(id);
        return "redirect:/admin/user";
    }

    @GetMapping("admin/user/edit/{id}")
    public String editUserByID(Model model, @PathVariable("id") Long id) {
        User user = userService.findUserById(id);
        model.addAttribute("editUser", user);
        model.addAttribute("roles", roleRepository.findAll());
        return "admin/user/editUser";
    }

    @PostMapping("admin/user/edit/{id}")
    public String editUserByIDConfirm(Model model, @ModelAttribute("editUser") User user,
            @RequestParam("image") MultipartFile imageFile) {
        User currentUser = this.userService.findUserById(user.getId());
        if (!imageFile.isEmpty()) {
            String avatarUrl = uploadService.handleSaveUploadFile(imageFile, "avatar");
            currentUser.setAvatar(avatarUrl);
        }
        if (currentUser != null) {
            currentUser.setFullName(user.getFullName());
            currentUser.setPhoneNumber(user.getPhoneNumber());
            currentUser.setAddress(user.getAddress());
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";

    }

}
