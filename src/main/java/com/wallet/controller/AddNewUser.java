package com.wallet.controller;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.wallet.dao.UserDao;
import com.wallet.daoImpl.UserDaoImpl;
import com.wallet.model.User;


public class AddNewUser extends HttpServlet  {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fullName = req.getParameter("fullname");
		String userName = req.getParameter("username");
		String email = req.getParameter("email");
		String password = req.getParameter("password");
		Double amount = Double.parseDouble(req.getParameter("amount"));
		
		User user = new User(userName,fullName,email,password,amount);
		UserDao userdao = new UserDaoImpl();
		userdao.addUser(user);
		System.out.println("New User Added: "+ user);
		resp.sendRedirect("AdminSessionData");
	}
	
}
