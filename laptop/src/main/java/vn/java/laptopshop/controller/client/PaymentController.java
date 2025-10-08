package vn.java.laptopshop.controller.client;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.java.laptopshop.domain.Cart;
import vn.java.laptopshop.domain.CartDetail;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.service.CartService;
import vn.java.laptopshop.service.VnpayService;

@Controller
public class PaymentController {

    private final CartService cartService;
    private final VnpayService vnpayService;

    public PaymentController(CartService cartService, VnpayService vnpayService) {
        this.cartService = cartService;
        this.vnpayService = vnpayService;
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
                return "redirect:/payment/vnpay-checkout?totalPrice=" + totalPrice;
            case "cod":
                return "redirect:/payment/COD";
            case "qrcode":
                String bankBin = "970436"; // Vietcombank (ví dụ)
                String accountNumber = "0123456789"; // Tài khoản nhận
                String accountName = "CTY TNHH TSHOP";
                String orderId = "HD" + System.currentTimeMillis();
                String amount = String.format("%.0f", totalPrice);
                String addInfo = "ThanhToanDonHang" + orderId;

                // URL tạo mã QR từ VietQR.io
                String qrUrl = "https://img.vietqr.io/image/"
                        + bankBin + "-" + accountNumber
                        + "-compact2.jpg?amount=" + amount
                        + "&addInfo=" + addInfo
                        + "&accountName=" + accountName;

                // Lưu dữ liệu vào session hoặc model
                session.setAttribute("qrUrl", qrUrl);
                session.setAttribute("orderId", orderId);

                // 👉 Chuyển hướng sang trang hiển thị QR
                return "redirect:/payment/qr";
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

    @GetMapping("/payment/vnpay-checkout")
    public String vnpayCheckout(HttpServletRequest request, @RequestParam("totalPrice") double totalPrice) {
        HttpSession session = request.getSession();
        User currentUser = new User();
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        String paymentUrl = "redirect:/checkout-failed";

        try {

            paymentUrl = vnpayService.createURLPayment(totalPrice, request);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();

        }

        return "redirect:" + paymentUrl;
    }

    @GetMapping("/vnpay-return")
    public String vnpayReturn(HttpServletRequest request) {
        Map<String, String> vnpParams = vnpayService.getVnpayResponseParams(request);

        String responseCode = vnpParams.get("vnp_ResponseCode");
        System.out.println(">>>>>>>>>>Mã phản hồi từ VNPAY: " + responseCode);

        if (responseCode.equals("00")) {
            HttpSession session = request.getSession();
            long userId = (long) session.getAttribute("id");

            User user = new User();
            user.setId(userId);

            String receiverName = (String) session.getAttribute("receiverName");
            String receiverPhone = (String) session.getAttribute("receiverPhone");
            String receiverAddress = (String) session.getAttribute("receiverAddress");
            String paymentMethod = (String) session.getAttribute("paymentMethod");
            this.cartService.handleOrder(user, session, receiverName, receiverAddress, receiverPhone, paymentMethod);

            return "redirect:/order-success";
        }

        return "redirect:/checkout-failed";

    }

    @GetMapping("/payment/qr")
    public String showQrPage(HttpSession session, Model model) {
        String qrUrl = (String) session.getAttribute("qrUrl");
        String orderId = (String) session.getAttribute("orderId");
        Double totalPrice = (Double) session.getAttribute("totalPrice");

        if (qrUrl == null || totalPrice == null) {
            return "redirect:/checkout-failed";
        }

        model.addAttribute("qrUrl", qrUrl);
        model.addAttribute("orderId", orderId);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/payment_qr_confirm"; // JSP hiển thị mã QR
    }

    @GetMapping("/order-success")
    public String orderSuccess() {
        return "client/cart/thanks";
    }

    @GetMapping("/checkout-failed")
    public String checkoutFailed() {
        return "client/cart/checkoutfailed";
    }
}
