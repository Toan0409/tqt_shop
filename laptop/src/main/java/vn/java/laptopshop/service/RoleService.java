package vn.java.laptopshop.service;

import org.springframework.stereotype.Service;

import vn.java.laptopshop.domain.Role;
import vn.java.laptopshop.repository.RoleRepository;

@Service
public class RoleService {
    private final RoleRepository roleRepository;

    public RoleService(RoleRepository roleRepository) {
        this.roleRepository = roleRepository;
    }

    public Role findByName(String name) {
        return roleRepository.findByName(name);
    }
}
