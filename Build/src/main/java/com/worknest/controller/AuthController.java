package com.worknest.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.worknest.model.User;
import com.worknest.service.UserService;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserService userService;

    /** Health check */
    @GetMapping("/ping")
    public String ping() {
        return "auth/login";
    }

    /** Show Login Page */
    @GetMapping("/login")
    public String loginPage(Model model) {
        model.addAttribute("user", new User());
        return "auth/login";
    }

    /** Handle Login */
  
    @PostMapping("/login")
    public String login(@RequestParam String usernameOrEmail,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {
        User user = userService.login(usernameOrEmail, password);

        if (user == null) {
            model.addAttribute("error", "Invalid username/email or password");
            return "auth/login";  // go back to login.jsp
        }

        // store logged-in user in session
        session.setAttribute("loggedInUser", user);

        if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            return "redirect:/admin/dashboard";
        } else {
            return "redirect:/user/dashboard";
        }
    }
    


    /** Show Registration Page */
    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute User user,
                           @RequestParam(required = false) String role,
                           Model model) {
        try {
            user.setRole(role != null ? role.toUpperCase() : "USER");
            userService.register(user);
            return "redirect:/auth/login";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("user", user);
            return "auth/register";  // stay on register page
        }
    }


    /** Handle Logout */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/auth/login";
    }
}
