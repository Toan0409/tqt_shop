package vn.java.laptopshop.controller.client;

import java.util.List;

import javax.naming.Binding;

import vn.java.laptopshop.domain.dto.RegisterDTO;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

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
    public String registerAccount(RegisterDTO registerDTO,
            Model model,
            BindingResult bindingResult) {
        User user = userService.convertToUser(registerDTO);
        user.setRole(userService.findRoleByName("USER")); // Mặc định vai trò là USER
        user.setPassword(passwordEncoder.encode(user.getPassword())); // Mã hoá mật khẩu
        userService.handleSaveUser(user);
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String login() {
        return "client/auth/login";
    }

}
