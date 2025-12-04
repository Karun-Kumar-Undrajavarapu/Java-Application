package com.example.service;

import com.example.model.User;
import com.example.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public User registerUser(String name, String email, String password) {
        if (name == null || name.trim().isEmpty()) 
            throw new IllegalArgumentException("Name required");
        if (email == null || !email.contains("@")) 
            throw new IllegalArgumentException("Invalid email");
        if (password == null || password.length() < 6) 
            throw new IllegalArgumentException("Password must be at least 6 characters");
        
        if (userRepository.findByEmail(email).isPresent()) 
            throw new IllegalArgumentException("Email already registered");

        User user = new User(name.trim(), email.trim(), passwordEncoder.encode(password), User.UserRole.USER);
        return userRepository.save(user);
    }

    public User authenticateUser(String email, String password) {
        Optional<User> user = userRepository.findByEmail(email);
        if (user.isEmpty()) 
            throw new IllegalArgumentException("Invalid email or password");
        
        if (!passwordEncoder.matches(password, user.get().getPassword())) 
            throw new IllegalArgumentException("Invalid email or password");
        
        return user.get();
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    public User updateUser(Long id, String name, String email) {
        User user = userRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("User not found"));
        
        if (name != null && !name.isEmpty()) user.setName(name.trim());
        if (email != null && !email.isEmpty()) user.setEmail(email.trim());
        
        return userRepository.save(user);
    }
}

