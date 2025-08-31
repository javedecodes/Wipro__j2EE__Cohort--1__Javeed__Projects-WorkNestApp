package com.worknest.service;

import com.worknest.model.User;
import java.util.List;

public interface UserService {
    void register(User user);
    User login(String usernameOrEmail, String password);
    List<User> listAll();
    User get(Long id);
    User getByEmail(String email);
    User getByUsername(String username);

    void delete(Long id);  // Added delete method
}
