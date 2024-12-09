package com.wallet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import com.wallet.model.Admin;
import com.wallet.dao.AdminDao;
import com.wallet.daoImpl.AdminDaoImpl;

public class adminauth extends HttpServlet  {
	private static final long serialVersionUID = 1L;

	@Override
		protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.print(username+ " "+ password);
        
        AdminDao adminDAO = new AdminDaoImpl();


        try {
            Admin admin = adminDAO.getAdminByUsernameAndPassword(username, password);

            if (admin != null) {
                resp.sendRedirect("AdminSessionData");
            } else {
                // Invalid credentials: redirect back to the login page with an error message
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("AdminAuth.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred during login. Please try again.");
            req.getRequestDispatcher("AdminAuth.jsp").forward(req, resp);
        }
    }
}
