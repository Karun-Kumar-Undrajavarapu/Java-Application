package com.example.controller;

import com.example.model.User;
import com.example.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/user")
public class UserProfileController {

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String userDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("currentUser", user);
        model.addAttribute("employees", userService.getAllUsers());
        return "user-dashboard";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam(required = false) String name, @RequestParam(required = false) String email,
                               @RequestParam(required = false) String designation,
                               @RequestParam(required = false) String department,
                               @RequestParam(required = false) String workLocation,
                               @RequestParam(required = false) String domain,
                               @RequestParam(required = false) String joiningDate,
                               @RequestParam(required = false) String managerName,
                               HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            java.time.LocalDate jd = null;
            if (joiningDate != null && !joiningDate.isBlank()) {
                jd = java.time.LocalDate.parse(joiningDate);
            }

            // If name/email not provided (e.g. HR-only form), keep existing values
            if (name == null || name.isBlank()) name = user.getName();
            if (email == null || email.isBlank()) email = user.getEmail();

            // Call service with correct parameter order: id, name, email, joiningDate, workLocation,
            // domain, department, designation, phone, managerName, status
            User updatedUser = userService.updateUser(user.getId(), name, email, jd, workLocation, domain, department, designation, null, managerName, null);
            session.setAttribute("user", updatedUser);
            model.addAttribute("message", "Profile updated successfully");
            model.addAttribute("currentUser", updatedUser);
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("currentUser", user);
        }

        model.addAttribute("employees", userService.getAllUsers());
        return "user-dashboard";
    }
}
