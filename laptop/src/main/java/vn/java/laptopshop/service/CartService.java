package vn.java.laptopshop.service;

import java.lang.StackWalker.Option;
import java.util.Optional;

import org.springframework.stereotype.Service;

import vn.java.laptopshop.domain.Cart;
import vn.java.laptopshop.domain.CartDetail;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.repository.CartDetailRepository;
import vn.java.laptopshop.repository.CartRepository;

@Service
public class CartService {
    private final UserService userService;
    private final CartRepository cartRepository;
    private final ProductService productService;
    private final CartDetailRepository cartDetailRepository;

    public CartService(UserService userService, CartRepository cartRepository, ProductService productService,
            CartDetailRepository cartDetailRepository) {
        this.userService = userService;
        this.cartDetailRepository = cartDetailRepository;
        this.productService = productService;
        this.cartRepository = cartRepository;
    }

    public void addProductToCart(String email, Long productId) {
        User user = userService.findUserByEmail(email);
        if (user == null) {
            throw new IllegalArgumentException("Không tìm thấy người dùng có email: " + email);
        }

        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null) {
            cart = new Cart();
            cart.setSum(0);
            cart.setUser(user);
            this.cartRepository.save(cart);
        }

        Optional<Product> productOpt = productService.getProductsById(productId);
        if (productOpt.isEmpty()) {
            throw new IllegalArgumentException("Không tìm thấy sản phẩm có ID: " + productId);
        }

        CartDetail cartDetail = this.cartDetailRepository.findByCartAndProduct(cart, productOpt.get());
        if (cartDetail == null) {
            cartDetail = new CartDetail();
            cartDetail.setCart(cart);
            cartDetail.setProduct(productOpt.get());
            cartDetail.setQuantity(1);
            cartDetail.setPrice(productOpt.get().getPrice());
        } else {
            cartDetail.setQuantity(cartDetail.getQuantity() + 1);
        }

        this.cartDetailRepository.save(cartDetail);
        cart.setSum(cart.getSum() + 1);
        this.cartRepository.save(cart);
        return;
    }

    public Cart fetchbyUser(User user) {
        return this.cartRepository.findByUser(user);
    }
}
