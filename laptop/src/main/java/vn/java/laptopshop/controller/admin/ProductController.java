package vn.java.laptopshop.controller.admin;

import java.util.List;

import javax.naming.Binding;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.service.ProductService;
import vn.java.laptopshop.service.UploadService;

@Controller
public class ProductController {

    private final ProductService productService;
    private final UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("admin/product")
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

    @GetMapping("admin/product/add")
    public String showAddProductForm(Model model) {
        model.addAttribute("product", new Product());
        return "admin/product/addProduct";
    }

    @PostMapping("admin/product/add")
    public String addProduct(Model model, @ModelAttribute("product") Product product,
            BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile) {

        if (bindingResult.hasErrors()) {
            return "admin/product/addProduct";
        }
        try {
            String filename = uploadService.handleSaveUploadFile(imageFile, "products");
            if (filename == null) {
                return "error";
            }

            product.setImage(filename);
            productService.saveProduct(product);
            return "redirect:/admin/product";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error saving product: " + e.getMessage());
            return "admin/product/addProduct";
        }

    }

    @GetMapping("admin/product/{id}")
    public String viewProductDetails(Model model, @PathVariable("id") Long id) {
        Product product = productService.getProductById(id);
        if (product == null) {
            return "error";
        }
        model.addAttribute("product", product);
        return "admin/product/detailProduct";
    }

    @GetMapping("admin/product/edit/{id}")
    public String showEditProductForm(Model model, @PathVariable("id") Long id) {
        Product product = productService.getProductById(id);
        if (product == null) {
            return "error";
        }
        model.addAttribute("product", product);
        return "admin/product/editProduct";
    }

    @PostMapping("admin/product/edit/{id}")
    public String editProduct(Model model, @PathVariable("id") Long id,
            @ModelAttribute("product") Product updatedProduct,
            BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile) {

        if (bindingResult.hasErrors()) {
            return "admin/product/editProduct";
        }

        try {
            Product existingProduct = productService.getProductById(id);
            if (existingProduct == null) {
                return "error";
            }

            if (!imageFile.isEmpty()) {
                String filename = uploadService.handleSaveUploadFile(imageFile, "products");
                if (filename == null) {
                    return "error";
                }
                existingProduct.setImage(filename);
            }

            existingProduct.setName(updatedProduct.getName());
            existingProduct.setPrice(updatedProduct.getPrice());
            existingProduct.setDetailDesc(updatedProduct.getDetailDesc());
            existingProduct.setShortDesc(updatedProduct.getShortDesc());
            existingProduct.setTarget(updatedProduct.getTarget());
            existingProduct.setQuantity(updatedProduct.getQuantity());
            existingProduct.setFactory(updatedProduct.getFactory());

            productService.saveProduct(existingProduct);
            return "redirect:/admin/product";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating product: " + e.getMessage());
            return "admin/product/editProduct";
        }
    }

    @GetMapping("admin/product/delete/{id}")
    public String showDeleteProduct(@PathVariable("id") Long id, Model model) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "admin/product/deleteProduct";
    }

    @PostMapping("admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long id) {
        productService.deleteProductById(id);
        return "redirect:/admin/product";
    }
}
