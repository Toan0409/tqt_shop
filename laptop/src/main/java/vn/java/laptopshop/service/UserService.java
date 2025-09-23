package vn.java.laptopshop.service;

import java.util.List;

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
}
