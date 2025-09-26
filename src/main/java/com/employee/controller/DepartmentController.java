package com.employee.controller;

import com.employee.model.Department;
import com.employee.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/departments")
public class DepartmentController {
    
    @Autowired
    private DepartmentService departmentService;
    
    @GetMapping
    public String listDepartments(Model model) {
        List<Department> departments = departmentService.findAll();
        model.addAttribute("departments", departments);
        return "departments/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        Department department = new Department();
        model.addAttribute("department", department);
        return "departments/form";
    }
    
    @PostMapping
    public String createDepartment(@Valid @ModelAttribute Department department, 
                                 BindingResult result, 
                                 Model model, 
                                 RedirectAttributes redirectAttributes) {
        
        // Check for duplicate name
        if (departmentService.existsByName(department.getName())) {
            result.rejectValue("name", "error.department", "Department name already exists");
        }
        
        if (result.hasErrors()) {
            return "departments/form";
        }
        
        departmentService.save(department);
        redirectAttributes.addFlashAttribute("successMessage", "Department created successfully!");
        return "redirect:/departments";
    }
    
    @GetMapping("/{id}")
    public String viewDepartment(@PathVariable Long id, Model model) {
        Department department = departmentService.findById(id);
        if (department == null) {
            return "redirect:/departments";
        }
        model.addAttribute("department", department);
        return "departments/view";
    }
    
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Department department = departmentService.findById(id);
        if (department == null) {
            return "redirect:/departments";
        }
        model.addAttribute("department", department);
        return "departments/form";
    }
    
    @PostMapping("/{id}")
    public String updateDepartment(@PathVariable Long id, 
                                 @Valid @ModelAttribute Department department, 
                                 BindingResult result, 
                                 Model model, 
                                 RedirectAttributes redirectAttributes) {
        
        Department existingDepartment = departmentService.findById(id);
        if (existingDepartment == null) {
            return "redirect:/departments";
        }
        
        // Check for duplicate name (excluding current department)
        Department nameCheck = departmentService.findByName(department.getName());
        if (nameCheck != null && !nameCheck.getId().equals(id)) {
            result.rejectValue("name", "error.department", "Department name already exists");
        }
        
        if (result.hasErrors()) {
            return "departments/form";
        }
        
        existingDepartment.setName(department.getName());
        existingDepartment.setDescription(department.getDescription());
        
        departmentService.update(existingDepartment);
        redirectAttributes.addFlashAttribute("successMessage", "Department updated successfully!");
        return "redirect:/departments";
    }
    
    @PostMapping("/{id}/delete")
    public String deleteDepartment(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Department department = departmentService.findById(id);
        if (department != null) {
            // Check if department has employees
            if (!department.getEmployees().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Cannot delete department. It has associated employees.");
            } else {
                departmentService.deleteById(id);
                redirectAttributes.addFlashAttribute("successMessage", "Department deleted successfully!");
            }
        }
        return "redirect:/departments";
    }
    
    @GetMapping("/search")
    public String searchDepartments(@RequestParam(required = false) String name, Model model) {
        List<Department> departments;
        if (name != null && !name.trim().isEmpty()) {
            departments = departmentService.searchByName(name.trim());
        } else {
            departments = departmentService.findAll();
        }
        
        model.addAttribute("departments", departments);
        model.addAttribute("searchName", name);
        return "departments/list";
    }
}