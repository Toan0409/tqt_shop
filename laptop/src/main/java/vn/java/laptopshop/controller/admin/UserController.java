package vn.java.laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.repository.RoleRepository;

@Controller
public class UserController {

    private final RoleRepository roleRepository;

    public UserController(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    @GetMapping("/admin/user")
    public String showUserList() {
        return "admin/user/manageUser";
    }

    @GetMapping("/admin/user/add")
    public String getRegisterPage(Model model) {
        model.addAttribute("newUser", new User());
        model.addAttribute("roles", roleRepository.findAll());
        return "admin/user/addUser";
    }
}
