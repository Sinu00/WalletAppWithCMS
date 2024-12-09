package com.wallet.dao;

import com.wallet.model.Admin;
import java.util.List;

public interface AdminDao {
    // CRUD operations
    boolean addAdmin(Admin admin); // Add a new admin
    Admin getAdminById(int adminId); // Fetch an admin by ID
    List<Admin> getAllAdmins(); // Fetch all admins
    boolean updateAdmin(Admin admin); // Update admin details
    boolean deleteAdmin(int adminId); // Delete admin by ID
    Admin getAdminByUsernameAndPassword(String username, String password);

    // Custom method
    Admin login(String username, String password); // Validate admin login
}
