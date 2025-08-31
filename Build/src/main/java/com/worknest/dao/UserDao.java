package com.worknest.dao;

import java.util.List;
import com.worknest.model.User;

public interface UserDao {
    void save(User user);
    User findById(Long id);
    List<User> findAll();
    User findByEmail(String email);
    User findByUsername(String username);

    void delete(User user);  // Added delete method
}
