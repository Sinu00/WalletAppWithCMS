package com.wallet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.wallet.dao.UserDao;
import com.wallet.dao.CryptocurrencyDao;
import com.wallet.daoImpl.UserDaoImpl;
import com.wallet.daoImpl.CryptocurrencyDaoImpl;


public class DeleteWithId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if(req.getParameter("CoinId") == null) {
			int userId = Integer.parseInt(req.getParameter("UserId"));
			UserDao udao = new UserDaoImpl();
			udao.deleteUser(userId);
			System.out.println("User Deleted With id " + userId);
			resp.sendRedirect("AdminSessionData");
		}else {
			int coinId = Integer.parseInt(req.getParameter("CoinId"));
			CryptocurrencyDao cdao = new CryptocurrencyDaoImpl();
			cdao.deleteCryptocurrency(coinId);
			System.out.println("Coin Deleted With id " + coinId);
			resp.sendRedirect("AdminSessionData");
		}

		
	}

}
