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
        return "user-dashboard";
    }

    @PostMapping("/update-profile")
    public String updateProfile(@RequestParam String name, @RequestParam String email, 
                               HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        try {
            User updatedUser = userService.updateUser(user.getId(), name, email);
            session.setAttribute("user", updatedUser);
            model.addAttribute("message", "Profile updated successfully");
            model.addAttribute("currentUser", updatedUser);
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("currentUser", user);
        }

        return "user-dashboard";
    }
}
