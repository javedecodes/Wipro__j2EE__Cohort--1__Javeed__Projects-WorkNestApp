package com.worknest.service;



import java.util.List;

import com.worknest.model.Comment;

public interface CommentService {
    void addComment(Comment c);
    List<Comment> listAll();
    List<Comment> getCommentsByTask(Long taskId);
}
