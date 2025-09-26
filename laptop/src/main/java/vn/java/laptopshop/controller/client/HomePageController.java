package vn.java.laptopshop.controller.client;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.service.ProductService;

@Controller
public class HomePageController {
    private final ProductService productService;

    public HomePageController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping({ "/", "/home" })
    public String home(Model model) {
        List<Product> products = productService.getAllProducts();
        model.addAttribute("newProducts", products);
        return "client/dashboard/index";
    }

}
