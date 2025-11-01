package vn.java.laptopshop.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import vn.java.laptopshop.domain.OrderDetail;
import vn.java.laptopshop.domain.dto.BestSellingProductDTO;
import vn.java.laptopshop.domain.dto.ProductRevenueDTO;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    @Query("SELECT new vn.java.laptopshop.domain.dto.ProductRevenueDTO(od.product.name, SUM(od.quantity * od.price)) "
            +
            "FROM OrderDetail od GROUP BY od.product.name")
    List<ProductRevenueDTO> getRevenueByProduct();

    @Query("""
            SELECT new vn.java.laptopshop.domain.dto.BestSellingProductDTO(
                od.product.name,
                SUM(od.quantity)
            )
            FROM OrderDetail od
            WHERE od.order.status IN ('Đã thanh toán', 'Chờ thanh toán', 'Chờ xác nhận')
            GROUP BY od.product.name
            ORDER BY SUM(od.quantity) DESC
            """)
    List<BestSellingProductDTO> findBestSellingProducts(Pageable pageable);
}
