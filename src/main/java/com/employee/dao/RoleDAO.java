package com.employee.dao;

import com.employee.model.Role;
import java.util.List;

public interface RoleDAO extends BaseDAO<Role, Long> {
    Role findByName(String name);
    List<Role> findByNameContaining(String name);
}