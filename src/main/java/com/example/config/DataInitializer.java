package com.example.config;

import com.example.model.User;
import com.example.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
public class DataInitializer {

    @Bean
    public CommandLineRunner initializeData(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        return args -> {
            // Create default admin if not exists
            if (userRepository.findByEmail("admin@localhost.com").isEmpty()) {
                User admin = new User(
                    "Administrator",
                    "admin@localhost.com",
                    passwordEncoder.encode("admin123"),
                    User.UserRole.ADMIN
                );
                userRepository.save(admin);
                System.out.println("✓ Default Admin created: admin@localhost.com / admin123");
            }

            // Create default user if not exists
            if (userRepository.findByEmail("user@localhost.com").isEmpty()) {
                User user = new User(
                    "Demo User",
                    "user@localhost.com",
                    passwordEncoder.encode("user123"),
                    User.UserRole.USER
                );
                userRepository.save(user);
                System.out.println("✓ Default User created: user@localhost.com / user123");
            }
        };
    }
}
