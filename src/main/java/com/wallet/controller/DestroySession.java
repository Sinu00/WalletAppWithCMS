package com.wallet.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DestroySession extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	        // Invalidate the current session
	        HttpSession session = req.getSession(false); // Fetch session if it exists
	        if (session != null) {
	            session.invalidate();
	        }
	        // Redirect to the login page
	        resp.sendRedirect("UserAuth.jsp");
	
	}
}
