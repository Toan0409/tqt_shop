package vn.java.laptopshop.service;

import java.lang.StackWalker.Option;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.java.laptopshop.domain.Cart;
import vn.java.laptopshop.domain.CartDetail;
import vn.java.laptopshop.domain.Order;
import vn.java.laptopshop.domain.OrderDetail;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.repository.CartDetailRepository;
import vn.java.laptopshop.repository.CartRepository;
import vn.java.laptopshop.repository.OrderDetailRepository;
import vn.java.laptopshop.repository.OrderRepository;
import vn.java.laptopshop.repository.ProductRepository;

@Service
public class CartService {
    private final UserService userService;
    private final CartRepository cartRepository;
    private final ProductService productService;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final ProductRepository productRepository;

    public CartService(UserService userService, CartRepository cartRepository, ProductService productService,
            CartDetailRepository cartDetailRepository, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            ProductRepository productRepository) {
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.productService = productService;
        this.cartRepository = cartRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.productRepository = productRepository;

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

    public void removeProductFromCart(HttpSession session, Long cartDetailID) {
        Optional<CartDetail> cartDetailOpt = this.cartDetailRepository.findById(cartDetailID);
        if (cartDetailOpt.isPresent()) {
            Cart cart = cartDetailOpt.get().getCart();
            cart.getCartDetails().remove(cartDetailOpt.get());
            // lấy sống lượng sản phẩm cartdetail trong giỏ hàng và xoá toàn bộ và cập nhật
            // lại số lượng trong cart
            int updatedSum = cart.getSum() - (int) cartDetailOpt.get().getQuantity();

            if (updatedSum > 0) {
                cart.setSum(updatedSum);
                this.cartRepository.save(cart);
            } else {
                this.cartRepository.delete(cart);

            }
        }

    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cd = this.cartDetailRepository.findById(cartDetail.getId());
            if (cd.isPresent()) {
                cd.get().setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(cd.get());
            }
        }
    }

    public void handleOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone, String paymentMethod) {

        Cart cart = this.cartRepository.findByUser(user);

        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null && !cartDetails.isEmpty()) {

                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                switch (paymentMethod) {
                    case "COD":
                        order.setStatus("Chờ xác nhận");
                        break;
                    case "vnpay":
                        order.setStatus("Đã thanh toán");
                        break;
                    default:
                        break;
                }

                double sum = 0;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice() * cd.getQuantity();
                }
                order.setTotalPrice(sum);

                // Lưu order
                order = this.orderRepository.save(order);

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);

                    Product product = cd.getProduct();
                    product = this.productRepository.findById(product.getId())
                            .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm với ID"));

                    orderDetail.setProduct(product);
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);
                    // Giảm số lượng tồn kho sản phẩm
                    long quantityOrdered = cd.getQuantity();
                    long currentStock = product.getQuantity();

                    if (currentStock < quantityOrdered) {
                        throw new RuntimeException("Không đủ số lượng sản phẩm trong kho: " + product.getName());
                    }

                    product.setQuantity(currentStock - quantityOrdered);
                    this.productRepository.save(product);

                }

                cart.getCartDetails().clear();
                cart.setSum(0);
                this.cartRepository.save(cart);

                session.setAttribute("sum", 0);

            } else {
                throw new RuntimeException("Giỏ hàng trống, khong thể đặt hàng.");

            }
        }
    }

}
