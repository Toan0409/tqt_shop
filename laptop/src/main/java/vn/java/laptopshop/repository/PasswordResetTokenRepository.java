package vn.java.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.java.laptopshop.domain.PasswordResetToken;
import vn.java.laptopshop.domain.User;

@Repository
public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Integer> {
    PasswordResetToken findByToken(String token);

    void deleteByUser(User user);

    java.util.Optional<PasswordResetToken> findByUser(vn.java.laptopshop.domain.User user);
}
