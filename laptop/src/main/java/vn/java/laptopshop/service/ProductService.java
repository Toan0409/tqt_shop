package vn.java.laptopshop.service;

import java.util.List;

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
}
