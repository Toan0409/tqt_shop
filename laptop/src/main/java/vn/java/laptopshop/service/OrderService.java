package vn.java.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import vn.java.laptopshop.domain.Order;
import vn.java.laptopshop.domain.OrderDetail;
import vn.java.laptopshop.domain.Product;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.domain.dto.BestSellingProductDTO;
import vn.java.laptopshop.domain.dto.ProductRevenueDTO;
import vn.java.laptopshop.repository.OrderDetailRepository;
import vn.java.laptopshop.repository.OrderRepository;

@Service
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Page<Order> getAllOrders(Pageable pageable) {
        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(),
                org.springframework.data.domain.Sort.by(org.springframework.data.domain.Sort.Direction.DESC,
                        "orderId"));
        return orderRepository.findAll(sortedPageable);
    }

    public Optional<Order> getOrderById(Long orderId) {
        return orderRepository.findById(orderId);

    }

    public void updateOrder(Order order) {
        Optional<Order> orderOpt = getOrderById(order.getOrderId());
        if (orderOpt.isPresent()) {
            Order currentOrder = orderOpt.get();
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    @Transactional
    public void deleteOrderById(Long orderId) {
        Optional<Order> orderOpt = orderRepository.findById(orderId);
        if (orderOpt.isPresent()) {
            Order currentOrder = orderOpt.get();

            List<OrderDetail> orderDetails = currentOrder.getOrderDetails();
            for (OrderDetail od : orderDetails) {
                orderDetailRepository.deleteById(od.getId());
            }

            orderRepository.deleteById(orderId);
        }
    }

    public List<Order> fetchOrdersByUser(User user) {
        return orderRepository.findByUserOrderByOrderIdDesc(user);
    }

    public List<BestSellingProductDTO> getTopBestSellingProducts(int topN) {
        PageRequest pageable = PageRequest.of(0, topN);
        return orderDetailRepository.findBestSellingProducts(pageable);
    }

    public List<ProductRevenueDTO> getRevenueByProduct() {
        return orderDetailRepository.getRevenueByProduct();
    }

}
