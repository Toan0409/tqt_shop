package vn.java.laptopshop.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BestSellingProductDTO {
    private String productName;
    private Long totalSold;
}
