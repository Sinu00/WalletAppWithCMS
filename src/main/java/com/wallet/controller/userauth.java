package com.wallet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.wallet.model.Cryptocurrency;
import com.wallet.model.Investment;
import com.wallet.dao.InvestmentDao;
import com.wallet.daoImpl.InvestmentDaoImpl;
import com.wallet.dao.CryptocurrencyDao;
import com.wallet.daoImpl.CryptocurrencyDaoImpl;
import com.wallet.dao.UserDao;
import com.wallet.daoImpl.UserDaoImpl;
import com.wallet.model.User;


public class userauth extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.print(username+ " "+ password);
        UserDao userDAO = new UserDaoImpl();
        InvestmentDao investmentDAO = new InvestmentDaoImpl();
        CryptocurrencyDao cryptocurrencyDAO = new CryptocurrencyDaoImpl();

        try {
            // Validate user credentials
            User user = userDAO.getUserByUsernameAndPassword(username, password);

            if (user != null) {
                // Valid user: create a session and store user data
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                System.out.println(user);

                // Fetch user investments and add to the session
                List<Investment> userInvestments = investmentDAO.getInvestmentsByUserId(user.getUserId());
                System.out.println(userInvestments);
                session.setAttribute("userInvestments", userInvestments);
                
                List<Cryptocurrency> userCoins = new ArrayList<>();
                // Fetch coin details for each investment
                for (Investment investment : userInvestments) {
                    // Get coin details by coinId (associated with the investment)
                    Cryptocurrency coin = cryptocurrencyDAO.getCryptocurrencyById(investment.getCoinId());
                    if (coin != null) {
                        // Add the coin to the userCoins list
                        userCoins.add(coin);
                    }
                }
                session.setAttribute("userCoins", userCoins);
                System.out.println(userCoins);

                resp.sendRedirect("UserDashboard.jsp");
            } else {
                // Invalid credentials: redirect back to the login page with an error message
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("UserAuth.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred during login. Please try again.");
            req.getRequestDispatcher("UserAuth.jsp").forward(req, resp);
        }
    }
}
