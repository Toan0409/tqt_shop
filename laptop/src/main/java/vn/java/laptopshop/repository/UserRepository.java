package vn.java.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import vn.java.laptopshop.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    java.util.Optional<User> findByEmail(String email);

    @Query("SELECT p from User p where p.fullName like %?1%")
    Page<User> findByFullNameContainingIgnoreCase(String keyword, Pageable pageable);

}
