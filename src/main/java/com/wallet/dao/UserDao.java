package com.wallet.dao;

import com.wallet.model.User;
import java.util.List;

public interface UserDao {
    // CRUD operations
    boolean addUser(User user); // Add a new user
    User getUserById(int userId); // Fetch a user by ID
    List<User> getAllUsers(); // Fetch all users
    boolean updateUser(User user); // Update user details
    boolean deleteUser(int userId); // Delete user by ID
    User getUserByUsernameAndPassword(String username, String password);
}
