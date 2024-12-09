package com.wallet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import com.wallet.dao.CryptocurrencyDao;
import com.wallet.daoImpl.CryptocurrencyDaoImpl;
import com.wallet.model.Cryptocurrency;

@MultipartConfig
public class AddNewCoin extends HttpServlet  {
	private static final long serialVersionUID = 1L;
      
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String coinName = req.getParameter("coinName");
        double coinPrice = Double.parseDouble(req.getParameter("coinPrice")); 
        String coinShortName = req.getParameter("coinShortName");
        Part filePart = req.getPart("coinLogo");
        
        byte[] coinLogo = null;

        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                coinLogo = inputStreamToByteArray(inputStream);
            }
        }
        
        Cryptocurrency coin = new Cryptocurrency(coinName,coinPrice,coinLogo,coinShortName);
        CryptocurrencyDao cdao = new CryptocurrencyDaoImpl();
        cdao.addCryptocurrency(coin);
        resp.sendRedirect("AdminSessionData");
	}
	
	
	//method to convert from part to byte[]
    private byte[] inputStreamToByteArray(InputStream inputStream) throws IOException {
        try (ByteArrayOutputStream buffer = new ByteArrayOutputStream()) {
            int nRead;
            byte[] data = new byte[1024];
            while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }
            return buffer.toByteArray();
        }
    }

}
