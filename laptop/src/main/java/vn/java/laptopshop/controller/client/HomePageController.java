package vn.java.laptopshop.controller.client;

import java.util.List;
import java.util.UUID;

import vn.java.laptopshop.domain.dto.RegisterDTO;
import vn.java.laptopshop.repository.PasswordResetTokenRepository;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.service.ISecurityUserService;
import vn.java.laptopshop.service.ProductService;
import vn.java.laptopshop.service.UserService;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final ISecurityUserService securityUserService;
    private final PasswordResetTokenRepository passwordResetTokenRepository;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder,
            ISecurityUserService securityUserService, PasswordResetTokenRepository passwordResetTokenRepository) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.securityUserService = securityUserService;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
    }

    @GetMapping({ "/", "/home" })
    public String home(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("newProducts", products);

        return "client/dashboard/index";
    }

    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/registerAccount";
    }

    @PostMapping("/register")
    public String registerAccount(
            @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            // Quay lại form và hiển thị lỗi
            return "client/auth/registerAccount";
        }

        if (userService.isEmailExists(registerDTO.getEmail())) {
            model.addAttribute("emailError", "Email đã được sử dụng");
            return "client/auth/registerAccount";
        }

        User user = userService.convertToUser(registerDTO);
        user.setRole(userService.findRoleByName("USER"));
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userService.handleSaveUser(user);

        return "redirect:/login";
    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        model.addAttribute("loginUser", new User());
        return "client/auth/login";
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm() {
        return "client/auth/forgotPassword";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(HttpServletRequest request, @RequestParam("email") String email, Model model) {
        User user = userService.findUserByEmail(email);
        if (user == null) {
            model.addAttribute("message", "Email không tồn tại trong hệ thống!");
            return "client/auth/forgotPassword";
        }

        String token = UUID.randomUUID().toString();
        userService.createPasswordResetToken(user, token);

        String appUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
        userService.sendPasswordResetEmail(user, appUrl, token);

        model.addAttribute("message", "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!");
        return "client/auth/forgotPassword";
    }

    // Kiểm tra token từ email
    @GetMapping("/update-password")
    public String validateToken(@RequestParam("id") long id,
            @RequestParam("token") String token,
            HttpSession session,
            Model model) {
        String result = securityUserService.validatePasswordResetToken(id, token);
        if (result != null) {
            return "redirect:/login?error=" + result;
        }

        // Lưu user tạm vào session
        User user = passwordResetTokenRepository.findByToken(token).getUser();
        session.setAttribute("resetUser", user);

        return "client/auth/updatePassword";
    }

    // Cập nhật mật khẩu mới
    @PostMapping("/update-password")
    public String saveNewPassword(@RequestParam("password") String password, HttpSession session) {
        User user = (User) session.getAttribute("resetUser");
        if (user == null) {
            return "redirect:/login";
        }

        userService.updatePassword(user, password);
        passwordResetTokenRepository.deleteByUser(user);
        session.removeAttribute("resetUser");

        return "redirect:/login?resetSuccess";
    }

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "client/auth/error";
    }

}
