package vn.java.laptopshop.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ProductRevenueDTO {
    private String productName;
    private Double totalRevenue;
}
