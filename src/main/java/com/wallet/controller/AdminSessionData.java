package com.wallet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.wallet.dao.CryptocurrencyDao;
import com.wallet.dao.UserDao;
import com.wallet.daoImpl.CryptocurrencyDaoImpl;
import com.wallet.daoImpl.UserDaoImpl;
import com.wallet.model.Cryptocurrency;
import com.wallet.model.User;

public class AdminSessionData extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDao userDAO = new UserDaoImpl();
    CryptocurrencyDao coinDAO = new CryptocurrencyDaoImpl();
       
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
//        session.setAttribute("admin", admin);
//        System.out.println(admin);

        List<User> allUsers = userDAO.getAllUsers();
        session.setAttribute("allUsers", allUsers);
        System.out.println(allUsers);
        
        List<Cryptocurrency> allCoins= coinDAO.getAllCryptocurrencies();
        System.out.println(allCoins);
        session.setAttribute("allCoins", allCoins);
        
        resp.sendRedirect("AdminDashboard.jsp");
	}

}
