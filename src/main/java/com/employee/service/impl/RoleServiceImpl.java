package com.employee.service.impl;

import com.employee.dao.RoleDAO;
import com.employee.model.Role;
import com.employee.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {
    
    @Autowired
    private RoleDAO roleDAO;
    
    @Override
    public Role save(Role role) {
        return roleDAO.save(role);
    }
    
    @Override
    public Role findById(Long id) {
        return roleDAO.findById(id).orElse(null);
    }
    
    @Override
    public List<Role> findAll() {
        return roleDAO.findAll();
    }
    
    @Override
    public Role update(Role role) {
        return roleDAO.update(role);
    }
    
    @Override
    public void deleteById(Long id) {
        roleDAO.deleteById(id);
    }
    
    @Override
    public Role findByName(String name) {
        return roleDAO.findByName(name);
    }
    
    @Override
    public List<Role> searchByName(String name) {
        return roleDAO.findByNameContaining(name);
    }
    
    @Override
    public boolean existsByName(String name) {
        return findByName(name) != null;
    }
}