package com.employee.controller;

import com.employee.model.Role;
import com.employee.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/roles")
public class RoleController {
    
    @Autowired
    private RoleService roleService;
    
    @GetMapping
    public String listRoles(Model model) {
        List<Role> roles = roleService.findAll();
        model.addAttribute("roles", roles);
        return "roles/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        Role role = new Role();
        model.addAttribute("role", role);
        return "roles/form";
    }
    
    @PostMapping
    public String createRole(@Valid @ModelAttribute Role role, 
                           BindingResult result, 
                           Model model, 
                           RedirectAttributes redirectAttributes) {
        
        // Check for duplicate name
        if (roleService.existsByName(role.getName())) {
            result.rejectValue("name", "error.role", "Role name already exists");
        }
        
        if (result.hasErrors()) {
            return "roles/form";
        }
        
        roleService.save(role);
        redirectAttributes.addFlashAttribute("successMessage", "Role created successfully!");
        return "redirect:/roles";
    }
    
    @GetMapping("/{id}")
    public String viewRole(@PathVariable Long id, Model model) {
        Role role = roleService.findById(id);
        if (role == null) {
            return "redirect:/roles";
        }
        model.addAttribute("role", role);
        return "roles/view";
    }
    
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Role role = roleService.findById(id);
        if (role == null) {
            return "redirect:/roles";
        }
        model.addAttribute("role", role);
        return "roles/form";
    }
    
    @PostMapping("/{id}")
    public String updateRole(@PathVariable Long id, 
                           @Valid @ModelAttribute Role role, 
                           BindingResult result, 
                           Model model, 
                           RedirectAttributes redirectAttributes) {
        
        Role existingRole = roleService.findById(id);
        if (existingRole == null) {
            return "redirect:/roles";
        }
        
        // Check for duplicate name (excluding current role)
        Role nameCheck = roleService.findByName(role.getName());
        if (nameCheck != null && !nameCheck.getId().equals(id)) {
            result.rejectValue("name", "error.role", "Role name already exists");
        }
        
        if (result.hasErrors()) {
            return "roles/form";
        }
        
        existingRole.setName(role.getName());
        existingRole.setDescription(role.getDescription());
        
        roleService.update(existingRole);
        redirectAttributes.addFlashAttribute("successMessage", "Role updated successfully!");
        return "redirect:/roles";
    }
    
    @PostMapping("/{id}/delete")
    public String deleteRole(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Role role = roleService.findById(id);
        if (role != null) {
            // Check if role has employees
            if (!role.getEmployees().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Cannot delete role. It has associated employees.");
            } else {
                roleService.deleteById(id);
                redirectAttributes.addFlashAttribute("successMessage", "Role deleted successfully!");
            }
        }
        return "redirect:/roles";
    }
    
    @GetMapping("/search")
    public String searchRoles(@RequestParam(required = false) String name, Model model) {
        List<Role> roles;
        if (name != null && !name.trim().isEmpty()) {
            roles = roleService.searchByName(name.trim());
        } else {
            roles = roleService.findAll();
        }
        
        model.addAttribute("roles", roles);
        model.addAttribute("searchName", name);
        return "roles/list";
    }
}