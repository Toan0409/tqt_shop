package vn.java.laptopshop.controller.admin;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.java.laptopshop.domain.Order;
import vn.java.laptopshop.service.OrderService;

import org.springframework.ui.Model;

@Controller
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String showOrderList(Model model,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "keyword", required = false) String keyword) {
        if (page < 1)
            page = 1;

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Order> ordersPage;
        ordersPage = orderService.getAllOrders(pageable);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", ordersPage.getTotalPages());
        model.addAttribute("orders", ordersPage.getContent());

        return "admin/order/manageOrder";
    }

    @GetMapping("/admin/order/detail/{orderId}")
    public String showOrderDetail(Model model, @PathVariable("orderId") Long orderId) {
        Optional<Order> order = orderService.getOrderById(orderId);
        model.addAttribute("order", order.get());
        model.addAttribute("orderDetails", order.get().getOrderDetails());
        return "admin/order/detailOrder";
    }

    @GetMapping("/admin/order/update/{orderId}")
    public String getOrderUpdate(Model model, @PathVariable("orderId") Long orderId) {
        Optional<Order> order = orderService.getOrderById(orderId);
        model.addAttribute("newOrder", order.get());
        return "admin/order/updateOrder";
    }

    @PostMapping("/admin/order/update")
    public String handleOrderUpdate(Model model, @ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

}
