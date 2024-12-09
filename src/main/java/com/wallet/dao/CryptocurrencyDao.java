package com.wallet.dao;

import com.wallet.model.Cryptocurrency;
import java.util.List;

public interface CryptocurrencyDao {
    // CRUD operations
    boolean addCryptocurrency(Cryptocurrency cryptocurrency); // Add a new cryptocurrency
    Cryptocurrency getCryptocurrencyById(int coinId); // Fetch cryptocurrency by ID
    List<Cryptocurrency> getAllCryptocurrencies(); // Fetch all cryptocurrencies
    boolean updateCryptocurrency(Cryptocurrency cryptocurrency); // Update cryptocurrency details
    boolean deleteCryptocurrency(int coinId); // Delete cryptocurrency by ID
}
