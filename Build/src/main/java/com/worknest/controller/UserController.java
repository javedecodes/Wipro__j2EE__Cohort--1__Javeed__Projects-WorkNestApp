package com.worknest.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.worknest.model.Comment;
import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.model.User;
import com.worknest.service.CommentService;
import com.worknest.service.TaskService;
import com.worknest.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private TaskService taskService;

    @Autowired
    private UserService userService;

    @Autowired
    private CommentService commentService;

    /** User Dashboard */
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/auth/login";
        }

        // Fetch tasks with comments eagerly loaded to avoid LazyInitializationException
        List<Task> tasks = taskService.getByUserWithComments(user.getId());
        model.addAttribute("user", user);
        model.addAttribute("tasks", tasks);

        return "user/dashboard";
    }

    /** Update Task Status */
    @PostMapping("/updateStatus")
    public String updateStatus(@RequestParam Long taskId,
                               @RequestParam String status,
                               HttpSession session) {

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/auth/login";
        }

        Task task = taskService.get(taskId);

        if (task != null && task.getAssignedUser() != null
                && task.getAssignedUser().getId().equals(user.getId())) {

            try {
                TaskStatus newStatus = TaskStatus.valueOf(status.toUpperCase());
                task.setStatus(newStatus);
                taskService.update(task);
            } catch (IllegalArgumentException e) {
                System.out.println("Invalid task status: " + status);
            }
        }

        return "redirect:/user/dashboard";
    }

    /** Add Comment */
    @PostMapping("/addComment")
    public String addComment(@RequestParam Long taskId,
                             @RequestParam String content,
                             HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/auth/login";
        }

        Task task = taskService.get(taskId);

        if (task != null && task.getAssignedUser() != null && task.getAssignedUser().getId().equals(user.getId())) {
            Comment comment = new Comment();
            comment.setContent(content);
            comment.setTask(task);
            comment.setUser(user);
            commentService.addComment(comment);
        }

        return "redirect:/user/dashboard";
    }
}
