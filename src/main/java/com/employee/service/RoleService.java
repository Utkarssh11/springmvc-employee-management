package com.employee.service;

import com.employee.model.Role;
import java.util.List;

public interface RoleService {
    Role save(Role role);
    Role findById(Long id);
    List<Role> findAll();
    Role update(Role role);
    void deleteById(Long id);
    Role findByName(String name);
    List<Role> searchByName(String name);
    boolean existsByName(String name);
}