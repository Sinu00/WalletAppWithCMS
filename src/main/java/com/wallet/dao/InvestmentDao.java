package com.wallet.dao;

import com.wallet.model.Investment;
import java.util.List;

public interface InvestmentDao {
    // CRUD operations
    boolean addInvestment(Investment investment); // Add a new investment
    Investment getInvestmentById(int investmentId); // Fetch investment by ID
    List<Investment> getInvestmentsByUserId(int userId); // Fetch all investments for a user
    List<Investment> getAllInvestments(); // Fetch all investments
    boolean updateInvestment(Investment investment); // Update investment details
    boolean deleteInvestment(int investmentId); // Delete an investment by ID
}
