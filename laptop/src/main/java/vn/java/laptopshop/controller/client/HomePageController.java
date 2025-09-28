package vn.java.laptopshop.controller.client;

import java.util.List;

import javax.naming.Binding;

import vn.java.laptopshop.domain.dto.RegisterDTO;

import org.springframework.boot.actuate.autoconfigure.observation.ObservationProperties.Http;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.service.ProductService;
import vn.java.laptopshop.service.UserService;

@Controller
public class HomePageController {
    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public HomePageController(ProductService productService, UserService userService, PasswordEncoder passwordEncoder) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
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

    @GetMapping("/access-denied")
    public String accessDenied() {
        return "client/auth/error";
    }

}
