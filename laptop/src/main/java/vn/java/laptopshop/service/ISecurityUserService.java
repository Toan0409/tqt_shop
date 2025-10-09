package vn.java.laptopshop.service;

import org.springframework.stereotype.Service;

@Service
public interface ISecurityUserService {
    String validatePasswordResetToken(long id, String token);
}
