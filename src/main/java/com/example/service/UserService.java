package com.example.service;

import com.example.model.User;
import com.example.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User addUser(String name, String email) {
        if (name == null || name.trim().isEmpty()) throw new IllegalArgumentException("Name required");
        if (!email.contains("@")) throw new IllegalArgumentException("Invalid email");
        User user = new User(null, name.trim(), email.trim());
        return userRepository.save(user);
    }

    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }
}
