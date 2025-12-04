package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/login";
        }

        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("currentUser", user);
        return "admin-dashboard";
    }

    @PostMapping("/update-user/{id}")
    public String updateUser(@PathVariable Long id, @RequestParam String name, 
                            @RequestParam String email, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/login";
        }

        try {
            userService.updateUser(id, name, email);
            model.addAttribute("message", "User updated successfully");
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
        }

        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("currentUser", user);
        return "admin-dashboard";
    }

    @GetMapping("/delete-user/{id}")
    public String deleteUser(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/login";
        }

        userService.deleteUser(id);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/make-admin/{id}")
    public String makeAdmin(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/login";
        }

        userService.setRole(id, User.UserRole.ADMIN);
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/edit-user/{id}")
    public String editUserForm(@PathVariable Long id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/login";
        }

        User target = userService.getUserById(id)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        model.addAttribute("target", target);
        model.addAttribute("currentUser", user);
        return "admin-edit-user";
    }

    @PostMapping("/edit-user/{id}")
    public String editUser(@PathVariable Long id,
                           @RequestParam(required = false) String name,
                           @RequestParam(required = false) String email,
                           @RequestParam(required = false) String joiningDate,
                           @RequestParam(required = false) String workLocation,
                           @RequestParam(required = false) String domain,
                           @RequestParam(required = false) String department,
                           @RequestParam(required = false) String designation,
                           @RequestParam(required = false) String phone,
                           @RequestParam(required = false) String managerName,
                           @RequestParam(required = false) String status,
                           HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || user.getRole() != User.UserRole.ADMIN) {
            return "redirect:/login";
        }

        try {
            LocalDate jd = null;
            if (joiningDate != null && !joiningDate.isBlank()) {
                jd = LocalDate.parse(joiningDate);
            }

            User.EmploymentStatus empStatus = null;
            if (status != null && !status.isBlank()) {
                empStatus = User.EmploymentStatus.valueOf(status);
            }

            userService.updateUser(id, name, email, jd, workLocation, domain, department, designation, phone, managerName, empStatus);
            model.addAttribute("message", "User updated successfully");
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
        }

        model.addAttribute("users", userService.getAllUsers());
        model.addAttribute("currentUser", user);
        return "admin-dashboard";
    }
}
