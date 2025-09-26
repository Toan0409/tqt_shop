package vn.java.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import vn.java.laptopshop.domain.Role;
import vn.java.laptopshop.domain.User;
import vn.java.laptopshop.domain.dto.RegisterDTO;
import vn.java.laptopshop.repository.RoleRepository;
import vn.java.laptopshop.repository.UserRepository;

@Service
public class UserService {

    private final RoleRepository roleRepository;
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
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

    // Tìm kiếm người dùng theo từ khoá (tên hoặc email) có phân trang
    public Page<User> searchUsersByKeyword(String keyword, Pageable pageable) {
        Pageable sortedPageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(),
                Sort.by(Sort.Direction.DESC, "id"));
        return userRepository.findByFullNameContainingIgnoreCase(keyword, sortedPageable);
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

    // convert RegisterDTO to User
    public User convertToUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFullName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        user.setPhoneNumber(registerDTO.getPhoneNumber());
        user.setAddress(registerDTO.getAddress());

        return user;
    }

    // Tìm vai trò theo tên
    public Role findRoleByName(String roleName) {
        return roleRepository.findByName(roleName);
    }
}
