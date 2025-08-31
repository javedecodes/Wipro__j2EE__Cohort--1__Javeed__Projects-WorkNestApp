package com.worknest.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.worknest.model.Task;
import com.worknest.model.User;
import com.worknest.service.TaskService;
import com.worknest.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private TaskService taskService;

    @Autowired
    private UserService userService;

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            return "redirect:/auth/login";
        }

        List<Task> tasks = taskService.getAllWithComments();
        List<User> users = userService.listAll();

        model.addAttribute("tasks", tasks);
        model.addAttribute("users", users);
        return "admin/dashboard";
    }

    @PostMapping("/assignTask")
    public String assignTask(@RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam("startDate") String startDate,
                             @RequestParam("dueDate") String dueDate,
                             @RequestParam("assignedUserId") Long userId) {

        Task task = new Task();
        task.setTitle(title);
        task.setDescription(description);
        task.setStartDate(java.time.LocalDate.parse(startDate));
        task.setDueDate(java.time.LocalDate.parse(dueDate));

        User user = userService.get(userId);
        if (user != null) {
            task.setAssignedUser(user);
        }

        taskService.create(task);
        return "redirect:/admin/dashboard";
    }

    // New method to delete user
    @PostMapping("/deleteUser")
    public String deleteUser(@RequestParam("userId") Long userId, HttpSession session) {
        User admin = (User) session.getAttribute("loggedInUser");
        if (admin == null || !"ADMIN".equalsIgnoreCase(admin.getRole())) {
            return "redirect:/auth/login";
        }
        userService.delete(userId);
        return "redirect:/admin/dashboard";
    }
}
