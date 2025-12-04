package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

        User targetUser = userService.getUserById(id)
            .orElseThrow(() -> new IllegalArgumentException("User not found"));
        targetUser.setRole(User.UserRole.ADMIN);
        userService.updateUser(id, targetUser.getName(), targetUser.getEmail());

        return "redirect:/admin/dashboard";
    }
}
