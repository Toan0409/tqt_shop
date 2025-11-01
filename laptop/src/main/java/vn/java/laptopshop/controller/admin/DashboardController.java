package vn.java.laptopshop.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.java.laptopshop.domain.Order;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.domain.dto.BestSellingProductDTO;
import vn.java.laptopshop.domain.dto.ProductRevenueDTO;
import vn.java.laptopshop.service.OrderService;
import vn.java.laptopshop.service.UserService;

@Controller
public class DashboardController {

    private final OrderService orderService;
    private final UserService userService;

    public DashboardController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/admin")
    public String getHomePage(Model model, HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long id = (long) session.getAttribute("id");
        User currentUser = new User();
        currentUser.setId(id);

        List<BestSellingProductDTO> bestSellers = orderService.getTopBestSellingProducts(10);
        model.addAttribute("bestSellers", bestSellers);

        Pageable pageable = PageRequest.of(0, 10);
        Page<Order> orderPage = orderService.getAllOrders(pageable);
        model.addAttribute("orders", orderPage.getContent());

        model.addAttribute("countUsers", userService.countUsers());
        model.addAttribute("countRevenues", userService.calculateTotalRevenue());
        model.addAttribute("countOrders", userService.countOrders()); //

        return "admin/dashboard/index";
    }
}
