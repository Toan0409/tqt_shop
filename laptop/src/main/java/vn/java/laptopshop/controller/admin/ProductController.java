package vn.java.laptopshop.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.service.ProductService;

@Controller
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String showProductList(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "keyword", required = false) String keyword) {
        if (page < 1)
            page = 1;

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Product> productsPage;

        if (keyword != null && !keyword.isEmpty()) {
            productsPage = productService.searchProductsByName(keyword, pageable);
        } else {
            productsPage = productService.getAllProducts(pageable);
        }
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productsPage.getTotalPages());
        model.addAttribute("products", productsPage.getContent());
        return "admin/product/manageProduct";
    }
}
