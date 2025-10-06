package vn.java.laptopshop.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.java.laptopshop.domain.CartDetail;
import vn.java.laptopshop.repository.CartDetailRepository;

@Service
public class CartDetailService {

    private final CartDetailRepository cartDetailRepository;

    public CartDetailService(CartDetailRepository cartDetailRepository) {
        this.cartDetailRepository = cartDetailRepository;
    }

//    public List<CartDetail> findByIds(List<Long> ids) {
//
//        return this.cartDetailRepository.findByIds(ids);
//    }

}
