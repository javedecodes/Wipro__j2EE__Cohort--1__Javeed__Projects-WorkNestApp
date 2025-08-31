package com.worknest.daoImpl;

import com.worknest.dao.CommentDao;
import com.worknest.model.Comment;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class CommentDaoImpl implements CommentDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void save(Comment comment) {
        sessionFactory.getCurrentSession().saveOrUpdate(comment);
    }

    @Override
    public Comment findById(Long id) {
        return sessionFactory.getCurrentSession().get(Comment.class, id);
    }

    @Override
    public List<Comment> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Comment", Comment.class)
                .list();
    }

    @Override
    public List<Comment> findByTaskId(Long taskId) {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Comment c WHERE c.task.id = :taskId", Comment.class)
                .setParameter("taskId", taskId)
                .list();
    }
}
