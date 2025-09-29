package vn.java.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    // phân trang và tìm kiếm
    public Page<Product> getAllProducts(Pageable pageable) {
        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(),
                Sort.by(Sort.Direction.DESC, "id"));
        return productRepository.findAll(sortedPageable);
    }

    public Page<Product> searchProductsByName(String keyword, Pageable pageable) {
        return productRepository.findByNameContainingIgnoreCase(keyword, pageable);
    }

    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    // Xoá sản phẩm theo ID
    public void deleteProductById(Long id) {
        productRepository.deleteById(id);
    }

    public Optional<Product> getProductsById(Long id) {
        return productRepository.findById(id);
    }
}
