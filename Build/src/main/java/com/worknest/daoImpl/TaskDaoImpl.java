package com.worknest.daoImpl;

import com.worknest.dao.TaskDao;
import com.worknest.model.Task;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

@Repository
public class TaskDaoImpl implements TaskDao {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(Task task) {
        if (task.getId() == null) {
            entityManager.persist(task);
        } else {
            entityManager.merge(task);
        }
    }

    @Override
    public Task findById(Long id) {
        return entityManager.find(Task.class, id);
    }

    @Override
    public List<Task> findAll() {
        String hql = "FROM Task";
        return entityManager.createQuery(hql, Task.class).getResultList();
    }

    @Override
    public List<Task> findByUserId(Long userId) {
        String hql = "FROM Task t WHERE t.assignedUser.id = :userId";
        return entityManager.createQuery(hql, Task.class)
                            .setParameter("userId", userId)
                            .getResultList();
    }

    // Eager fetch all tasks with comments
    @Override
    public List<Task> findAllWithComments() {
        String hql = "SELECT DISTINCT t FROM Task t LEFT JOIN FETCH t.comments";
        return entityManager.createQuery(hql, Task.class).getResultList();
    }

    // Eager fetch tasks for a user with comments
    @Override
    public List<Task> findByUserIdWithComments(Long userId) {
        String hql = "SELECT DISTINCT t FROM Task t LEFT JOIN FETCH t.comments WHERE t.assignedUser.id = :userId";
        return entityManager.createQuery(hql, Task.class)
                            .setParameter("userId", userId)
                            .getResultList();
    }
}
