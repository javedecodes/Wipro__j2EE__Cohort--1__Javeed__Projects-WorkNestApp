package com.worknest.serviceImpl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.worknest.dao.CommentDao;
import com.worknest.model.Comment;
import com.worknest.service.CommentService;

@Service
@Transactional
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentDao commentDao;

    @Override
    public void addComment(Comment comment) {
        commentDao.save(comment);  // Uses DAO save method
    }

    @Override
    public List<Comment> listAll() {
        return commentDao.findAll();  // Uses DAO findAll
    }

    @Override
    public List<Comment> getCommentsByTask(Long taskId) {
        return commentDao.findByTaskId(taskId); // Uses DAO findByTaskId
    }
}
