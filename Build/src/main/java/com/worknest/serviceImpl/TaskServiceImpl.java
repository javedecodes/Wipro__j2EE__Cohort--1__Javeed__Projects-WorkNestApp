package com.worknest.serviceImpl;

import com.worknest.dao.TaskDao;
import com.worknest.model.Task;
import com.worknest.model.TaskStatus;
import com.worknest.service.TaskService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class TaskServiceImpl implements TaskService {

    @Autowired
    private TaskDao taskDao;

    @Override
    public void create(Task task) {
        taskDao.save(task);
    }

    @Override
    public void update(Task task) {
        taskDao.save(task);
    }

    @Override
    public Task get(Long id) {
        return taskDao.findById(id);
    }

    @Override
    public List<Task> getAll() {
        return taskDao.findAll();
    }

    @Override
    public List<Task> getByUser(Long userId) {
        return taskDao.findByUserId(userId);
    }

    @Override
    public List<Task> getAllWithComments() {
        return taskDao.findAllWithComments();
    }

    @Override
    public List<Task> getByUserWithComments(Long userId) {
        return taskDao.findByUserIdWithComments(userId);
    }

    @Override
    public void updateStatus(Long taskId, String statusStr) {
        Task task = taskDao.findById(taskId);
        if (task != null) {
            try {
                TaskStatus status = TaskStatus.valueOf(statusStr);
                task.setStatus(status);
                taskDao.save(task);
            } catch (IllegalArgumentException e) {
                System.err.println("Invalid Task Status: " + statusStr);
            }
        }
    }
}
