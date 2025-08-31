package com.worknest.dao;

import com.worknest.model.Comment;
import java.util.List;

public interface CommentDao {
    void save(Comment comment);               // Save or update
    Comment findById(Long id);                // Optional, for single comment
    List<Comment> findAll();                  // List all comments
    List<Comment> findByTaskId(Long taskId);  // Comments for a specific task
}
