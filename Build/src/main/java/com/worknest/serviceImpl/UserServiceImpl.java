package com.worknest.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.worknest.dao.UserDao;
import com.worknest.model.User;
import com.worknest.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public void register(User user) {
        if (userDao.findByUsername(user.getUsername()) != null) {
            throw new RuntimeException("Username already exists!");
        }
        if (userDao.findByEmail(user.getEmail()) != null) {
            throw new RuntimeException("Email already exists!");
        }
        if (user.getRole() == null) {
            user.setRole("USER");
        } else {
            user.setRole(user.getRole().toUpperCase());
        }
        userDao.save(user);
    }

    @Override
    public User login(String usernameOrEmail, String password) {
        User user = userDao.findByUsername(usernameOrEmail);
        if (user == null) {
            user = userDao.findByEmail(usernameOrEmail);
        }
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    @Override
    public List<User> listAll() {
        return userDao.findAll();
    }

    @Override
    public User get(Long id) {
        return userDao.findById(id);
    }

    @Override
    public User getByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public User getByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public void delete(Long id) {
        User user = userDao.findById(id);
        if (user != null) {
            userDao.delete(user);
        }
    }
}
