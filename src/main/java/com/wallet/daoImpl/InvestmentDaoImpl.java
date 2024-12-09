package com.wallet.daoImpl;

import com.wallet.dao.InvestmentDao;
import com.wallet.model.Investment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InvestmentDaoImpl implements InvestmentDao {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/walletinvestmentwebapp";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "root";

    // SQL Queries
    private static final String INSERT_INVESTMENT = "INSERT INTO Investments (user_id, coin_id, amount_invested, profit_loss) VALUES (?, ?, ?, ?)";
    private static final String SELECT_INVESTMENT_BY_ID = "SELECT * FROM Investments WHERE investment_id = ?";
    private static final String SELECT_INVESTMENTS_BY_USER_ID = "SELECT * FROM Investments WHERE user_id = ?";
    private static final String SELECT_ALL_INVESTMENTS = "SELECT * FROM Investments";
    private static final String UPDATE_INVESTMENT = "UPDATE Investments SET user_id = ?, coin_id = ?, amount_invested = ?, profit_loss = ? WHERE investment_id = ?";
    private static final String DELETE_INVESTMENT = "DELETE FROM Investments WHERE investment_id = ?";

    @Override
    public boolean addInvestment(Investment investment) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(INSERT_INVESTMENT)) {
            statement.setInt(1, investment.getUserId());
            statement.setInt(2, investment.getCoinId());
            statement.setDouble(3, investment.getInvestmentAmount());
            statement.setDouble(4, investment.getProfitLoss());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Investment getInvestmentById(int investmentId) {
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(SELECT_INVESTMENT_BY_ID)) {
            statement.setInt(1, investmentId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Investment(
                        resultSet.getInt("investment_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("coin_id"),
                        resultSet.getDouble("amount_invested"),
                        resultSet.getDouble("quantity"),
                        resultSet.getDouble("profit_loss")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Investment> getInvestmentsByUserId(int userId) {
        List<Investment> investments = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(SELECT_INVESTMENTS_BY_USER_ID)) {
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                investments.add(new Investment(
                        resultSet.getInt("investment_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("coin_id"),
                        resultSet.getDouble("amount_invested"),
                        resultSet.getDouble("quantity"),
                        resultSet.getDouble("profit_loss")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return investments;
    }

    @Override
    public List<Investment> getAllInvestments() {
        List<Investment> investments = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_INVESTMENTS)) {
            while (resultSet.next()) {
                investments.add(new Investment(
                        resultSet.getInt("investment_id"),
                        resultSet.getInt("user_id"),
                        resultSet.getInt("coin_id"),
                        resultSet.getDouble("amount_invested"),
                        resultSet.getDouble("quantity"),
                        resultSet.getDouble("profit_loss")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return investments;
    }

    @Override
    public boolean updateInvestment(Investment investment) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(UPDATE_INVESTMENT)) {
            statement.setInt(1, investment.getUserId());
            statement.setInt(2, investment.getCoinId());
            statement.setDouble(3, investment.getInvestmentAmount());
            statement.setDouble(4, investment.getProfitLoss());
            statement.setInt(5, investment.getInvestmentId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteInvestment(int investmentId) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(DELETE_INVESTMENT)) {
            statement.setInt(1, investmentId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
