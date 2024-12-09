package com.wallet.daoImpl;

import com.wallet.dao.AdminDao;
import com.wallet.model.Admin;
import com.wallet.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDaoImpl implements AdminDao {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/walletinvestmentwebapp";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "root";

    // SQL Queries
    private static final String INSERT_ADMIN = "INSERT INTO Admins (username, email, password) VALUES (?, ?, ?)";
    private static final String SELECT_ADMIN_BY_ID = "SELECT * FROM Admins WHERE admin_id = ?";
    private static final String SELECT_ALL_ADMINS = "SELECT * FROM Admins";
    private static final String UPDATE_ADMIN = "UPDATE Admins SET username = ?, email = ?, password = ? WHERE admin_id = ?";
    private static final String DELETE_ADMIN = "DELETE FROM Admins WHERE admin_id = ?";
    private static final String LOGIN_ADMIN = "SELECT * FROM Admins WHERE username = ? AND password = ?";

    @Override
    public boolean addAdmin(Admin admin) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(INSERT_ADMIN)) {
            statement.setString(1, admin.getUsername());
            statement.setString(2, admin.getEmail());
            statement.setString(3, admin.getPassword());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Admin getAdminById(int adminId) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(SELECT_ADMIN_BY_ID)) {
            statement.setInt(1, adminId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Admin(
                        resultSet.getInt("admin_id"),
                        resultSet.getString("username"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Admin> getAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_ADMINS)) {
            while (resultSet.next()) {
                admins.add(new Admin(
                        resultSet.getInt("admin_id"),
                        resultSet.getString("username"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }

    @Override
    public boolean updateAdmin(Admin admin) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(UPDATE_ADMIN)) {
            statement.setString(1, admin.getUsername());
            statement.setString(2, admin.getEmail());
            statement.setString(3, admin.getPassword());
            statement.setInt(4, admin.getAdminId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteAdmin(int adminId) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(DELETE_ADMIN)) {
            statement.setInt(1, adminId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Admin login(String username, String password) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(LOGIN_ADMIN)) {
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Admin(
                        resultSet.getInt("admin_id"),
                        resultSet.getString("username"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public Admin getAdminByUsernameAndPassword(String username, String password) {
        Admin admin = null;
        
        String query = "SELECT * FROM admins WHERE username = ? AND password = ?";
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD); 
             PreparedStatement stmt = conn.prepareStatement(query)) {
            // Set the parameters
            stmt.setString(1, username);
            stmt.setString(2, password); 
            
            // Execute the query
            ResultSet rs = stmt.executeQuery();
            
            // If user is found, map the result to a User object
            if (rs.next()) {
                admin = new Admin();
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password")); 
                admin.setEmail(rs.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return admin;
    }
}
