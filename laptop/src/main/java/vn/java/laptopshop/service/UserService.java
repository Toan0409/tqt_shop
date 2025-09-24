package vn.java.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User handleSaveUser(User user) {
        User user1 = this.userRepository.save(user);
        return user1;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public boolean isEmailExists(String email) {
        return userRepository.findByEmail(email).isPresent();
    }

    // Lấy toàn bộ danh sách người dùng có phân trang
    public Page<User> getAllUsersPaged(Pageable pageable) {
        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(),
                Sort.by(Sort.Direction.DESC, "id"));
        return userRepository.findAll(sortedPageable);
    }

    // Tìm người dùng theo ID
    public User findUserById(Long id) {
        Optional<User> optionalUser = userRepository.findById(id);
        return optionalUser.orElse(null);
    }

    // Xoá người dùng theo ID
    public void deleteUserById(Long id) {
        userRepository.deleteById(id);
    }
}
