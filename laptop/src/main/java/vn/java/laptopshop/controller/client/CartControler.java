package vn.java.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.actuate.autoconfigure.observation.ObservationProperties.Http;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.java.laptopshop.domain.Cart;
import vn.java.laptopshop.domain.CartDetail;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.service.CartService;
import vn.java.laptopshop.service.ProductService;

@Controller
public class CartControler {

    private final CartService cartService;

    public CartControler(CartService cartService) {
        this.cartService = cartService;

    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.cartService.addProductToCart(email, productId);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User currentUser = new User();
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.cartService.fetchbyUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0.0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getProduct().getPrice() * cartDetail.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);

        return "client/cart/cart";
    }

    @PostMapping("/delete-product-from-cart/{id}")
    public String deleteProductFromCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Long productId = id;
        this.cartService.removeProductFromCart(session, productId);
        return "redirect:/cart";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new java.util.ArrayList<CartDetail>() : cart.getCartDetails();
        this.cartService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @GetMapping("/checkout")
    public String checkout(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        User currentUser = new User();
        Long id = (Long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.cartService.fetchbyUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalPrice = 0.0;
        for (CartDetail cartDetail : cartDetails) {
            totalPrice += cartDetail.getProduct().getPrice() * cartDetail.getQuantity();
        }
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/checkout";
    }

    @PostMapping("/checkout")
    public String processCheckout(HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("totalPrice") double totalPrice,
            @RequestParam("paymentMethod") String paymentMethod) {
        HttpSession session = request.getSession();
        session.setAttribute("receiverName", receiverName);
        session.setAttribute("receiverPhone", receiverPhone);
        session.setAttribute("receiverAddress", receiverAddress);
        session.setAttribute("totalPrice", totalPrice);
        session.setAttribute("paymentMethod", paymentMethod);
        switch (paymentMethod) {
            case "vnpay":
                return "redirect:/payment/vnpay";
            case "cod":
                return "redirect:/payment/COD";

            default:
                return "redirect:/checkout-failed";
        }
    }

    @GetMapping("/payment/COD")
    public String processCODPayment(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User currentUser = new User();
        Long id = (Long) session.getAttribute("id");
        currentUser.setId(id);

        String receiverName = (String) session.getAttribute("receiverName");
        String receiverPhone = (String) session.getAttribute("receiverPhone");
        String receiverAddress = (String) session.getAttribute("receiverAddress");
        String paymentMethod = (String) session.getAttribute("paymentMethod");
        this.cartService.handleOrder(
                currentUser, session,
                receiverName, receiverAddress, receiverPhone, paymentMethod);
        return "redirect:/order-success";
    }

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "client/cart/thanks";
    }
}
