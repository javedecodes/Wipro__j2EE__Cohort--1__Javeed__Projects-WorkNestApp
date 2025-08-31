package com.worknest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    // Root URL serving welcome page
    @GetMapping("/")
    public String welcome() {
        // return welcome.jsp view name (without .jsp extension)
        return "welcome";
    }
}
