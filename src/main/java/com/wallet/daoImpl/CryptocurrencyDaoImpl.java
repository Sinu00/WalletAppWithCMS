package com.wallet.daoImpl;

import com.wallet.dao.CryptocurrencyDao;
import com.wallet.model.Cryptocurrency;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CryptocurrencyDaoImpl implements CryptocurrencyDao {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/walletinvestmentwebapp";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "root";

    // SQL Queries
    private static final String INSERT_COIN = "INSERT INTO Cryptocurrencies (coin_name, current_price,coin_logo, coin_shortname) VALUES (?, ?,?,?)";
    private static final String SELECT_COIN_BY_ID = "SELECT * FROM Cryptocurrencies WHERE coin_id = ?";
    private static final String SELECT_ALL_COINS = "SELECT * FROM Cryptocurrencies";
    private static final String UPDATE_COIN = "UPDATE Cryptocurrencies SET coin_name = ?, current_price = ? coin_logo = ?, coin_shortname=? WHERE coin_id = ?";
    private static final String DELETE_COIN = "DELETE FROM Cryptocurrencies WHERE coin_id = ?";

    @Override
    public boolean addCryptocurrency(Cryptocurrency cryptocurrency) {
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(INSERT_COIN)) {
            statement.setString(1, cryptocurrency.getCoinName());
            statement.setDouble(2, cryptocurrency.getCurrentPrice());
            statement.setBytes(3, cryptocurrency.getCoinLogo());
            statement.setString(4, cryptocurrency.getShortName());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Cryptocurrency getCryptocurrencyById(int coinId) {
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(SELECT_COIN_BY_ID)) {
            statement.setInt(1, coinId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Cryptocurrency(
                        resultSet.getInt("coin_id"),
                        resultSet.getString("coin_name"),
                        resultSet.getDouble("current_price"),
                        resultSet.getBytes("coin_logo"),
                        resultSet.getString("coin_shortname")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Cryptocurrency> getAllCryptocurrencies() {
        List<Cryptocurrency> cryptocurrencies = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_COINS)) {
            while (resultSet.next()) {
                cryptocurrencies.add(new Cryptocurrency(
                        resultSet.getInt("coin_id"),
                        resultSet.getString("coin_name"),
                        resultSet.getDouble("current_price"),
                        resultSet.getBytes("coin_logo"),
                        resultSet.getString("coin_shortname")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cryptocurrencies;
    }

    @Override
    public boolean updateCryptocurrency(Cryptocurrency cryptocurrency) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(UPDATE_COIN)) {
            statement.setString(1, cryptocurrency.getCoinName());
            statement.setDouble(2, cryptocurrency.getCurrentPrice());
            statement.setInt(3, cryptocurrency.getCoinId());
            statement.setBytes(4, cryptocurrency.getCoinLogo());
            statement.setString(5, cryptocurrency.getShortName());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteCryptocurrency(int coinId) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement(DELETE_COIN)) {
            statement.setInt(1, coinId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

