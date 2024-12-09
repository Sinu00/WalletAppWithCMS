<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.wallet.model.User" %>
<%@ page import="com.wallet.model.Investment" %>
<%@ page import="com.wallet.model.Cryptocurrency" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crypto Wallet Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #0a0a0a;
            color: #ffffff;
            min-height: 100vh;
            line-height: 1.6;
            background-image: 
                radial-gradient(at 27% 37%, hsla(215, 98%, 21%, 0.3) 0px, transparent 0%),
                radial-gradient(at 97% 21%, hsla(227, 100%, 24%, 0.25) 0px, transparent 50%),
                radial-gradient(at 52% 99%, hsla(210, 89%, 24%, 0.2) 0px, transparent 50%),
                radial-gradient(at 10% 29%, hsla(256, 96%, 24%, 0.15) 0px, transparent 50%),
                radial-gradient(at 97% 96%, hsla(38, 60%, 74%, 0.1) 0px, transparent 50%),
                radial-gradient(at 33% 50%, hsla(222, 67%, 73%, 0.1) 0px, transparent 50%);
            padding: 10px;
        }

        .dashboard-container {
            background-color: rgba(17, 24, 39, 0.8);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            padding: 20px;
            backdrop-filter: blur(16px);
        }

        .dashboard-header {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            gap: 15px;
        }

        .user-profile {
            display: flex;
            align-items: center;
            flex-grow: 1;
        }

        .user-profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
            background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.05));
        }

        .user-profile-text {
            flex-grow: 1;
        }

        .user-profile-text h1 {
            font-size: 1.2rem;
        }

        .portfolio-summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 30px;
        }

        .summary-card {
            background-color: rgba(31, 41, 55, 0.8);
            border-radius: 12px;
            padding: 15px;
            text-align: center;
        }

        .summary-card h3 {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.8rem;
            margin-bottom: 8px;
        }

        .summary-card .value {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .summary-card .change {
            font-size: 0.8rem;
            margin-top: 5px;
        }

        .positive {
            color: #4caf50;
        }

        .negative {
            color: #ff4d4d;
        }

        .coin-holdings {
            background-color: rgba(31, 41, 55, 0.8);
            border-radius: 12px;
            padding: 20px;
            overflow-x: auto;
        }

        .coin-holdings h2 {
            margin-bottom: 20px;
            color: #ffffff;
            font-size: 1.2rem;
        }

        .coin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            min-width: 600px;
        }

        .coin-table th {
            text-align: left;
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.8rem;
            padding: 0 10px;
        }

        .coin-table tr {
            background-color: rgba(17, 24, 39, 0.6);
            border-radius: 8px;
        }

        .coin-table td {
            padding: 15px 10px;
            white-space: nowrap;
        }

        .coin-table .coin-info {
            display: flex;
            align-items: center;
        }

        .coin-table .coin-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .logout-button {
            background: linear-gradient(to right, rgba(59, 130, 246, 0.8), rgba(79, 70, 229, 0.8));
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .logout-button:hover {
            background: linear-gradient(to right, rgba(59, 130, 246, 0.9), rgba(79, 70, 229, 0.9));
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Mobile Specific Adjustments */
        @media screen and (max-width: 768px) {
            .dashboard-container {
                padding: 15px;
            }

            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .user-profile {
                width: 100%;
            }

            .portfolio-summary {
                grid-template-columns: 1fr 1fr;
            }

            .summary-card {
                padding: 12px;
            }

            .summary-card .value {
                font-size: 1rem;
            }

            .coin-holdings {
                padding: 15px;
            }

            .coin-table {
                min-width: 500px;
            }
        }

        @media screen and (max-width: 480px) {
            .portfolio-summary {
                grid-template-columns: 1fr;
            }

            .coin-table {
                min-width: 400px;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <div class="user-profile">
                <img src="/api/placeholder/50/50" alt="User Profile">
                <div class="user-profile-text">
                    <% 
                        User user = (User) session.getAttribute("user"); 
                        if (user != null) {
                    %>
                        <h1><%= user.getFullname() %></h1>
                        <p style="color: rgba(255, 255, 255, 0.6); font-size: 0.8rem;">Verified Account</p>
                    <% } else { 
                        response.sendRedirect("UserAuth.jsp"); 
                        return;
                    } %>
                </div>
            </div>
            <button class="logout-button" onclick="window.location.href='DestroySession';">Logout</button>
        </div>

        <!-- Portfolio Summary -->
        <div class="portfolio-summary">
            <% 
                // Calculate dynamic totals
                double totalInvestment = 0.0;
                double totalPortfolioValue = 0.0;
                double availableBalance = 2345.67; // Example static value, replace with dynamic logic
                double totalProfitLoss = 0.0;

                List<Investment> userInvestments = (List<Investment>) session.getAttribute("userInvestments");
                List<Cryptocurrency> userCoins = (List<Cryptocurrency>) session.getAttribute("userCoins");

                if (userInvestments != null && userCoins != null && userInvestments.size() == userCoins.size()) {
                    for (int i = 0; i < userInvestments.size(); i++) {
                        Investment investment = userInvestments.get(i);
                        Cryptocurrency coin = userCoins.get(i);

                        totalInvestment += investment.getInvestmentAmount();
                        totalPortfolioValue += investment.getQuantity() * coin.getCurrentPrice();
                        totalProfitLoss += (investment.getQuantity() * coin.getCurrentPrice()) - investment.getInvestmentAmount();
                    }
                }
            %>
            <div class="summary-card">
                <h3>Total Portfolio Value</h3>
                <div class="value">₹<%= String.format("%.2f", totalPortfolioValue) %></div>
                <div class="change positive">+12.3% (24h)</div> <!-- Replace static change with dynamic logic if available -->
            </div>
            <div class="summary-card">
                <h3>Total Investment</h3>
                <div class="value">₹<%= String.format("%.2f", totalInvestment) %></div>
            </div>
            <div class="summary-card">
                <h3>Total Profit/Loss</h3>
                <div class="value <%= totalProfitLoss > 0 ? "positive" : "negative" %>">
                    ₹<%= String.format("%.2f", totalProfitLoss) %>
                </div>
            </div>
            <div class="summary-card">
                <h3>Available Balance</h3>
                <div class="value">₹<%= String.format("%.2f", availableBalance) %></div>
            </div>
        </div>

        <!-- Coin Holdings Section -->
        <div class="coin-holdings">
            <h2>Your Coin Holdings</h2>
            <div class="table-container">
                <table class="coin-table">
                    <thead>
                        <tr>
                            <th>Coin</th>
                            <th>Amount Invested</th>
                            <th>Current Price</th>
                            <th>Total Value</th>
                            <th>24h Change</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            if (userInvestments != null && userCoins != null && userInvestments.size() == userCoins.size()) {
                                for (int i = 0; i < userInvestments.size(); i++) {
                                    Investment investment = userInvestments.get(i);
                                    Cryptocurrency coin = userCoins.get(i);
                        %>
                        <tr>
                            <td>
                                <div class="coin-info">
                                    <img src="" class="coin-icon" alt="<%= coin.getCoinName() %>">
                                    <%= coin.getCoinName() %> (<%= coin.getShortName() %>)
                                </div>
                            </td>
                            <td>₹<%= String.format("%.2f", investment.getInvestmentAmount()) %></td>
                            <td>₹<%= String.format("%.2f", coin.getCurrentPrice()) %></td>
                            <td>₹<%= String.format("%.2f", investment.getQuantity() * coin.getCurrentPrice()) %></td>
                            <td class="<%= investment.getProfitLoss() > 0 ? "positive" : "negative" %>">
                                <%= String.format("%.2f", investment.getProfitLoss()) %>%
                            </td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="5" style="text-align: center; color: rgba(255, 255, 255, 0.6);">
                                No investments found. <a href="invest.jsp" style="color: #4caf50;">Start Investing Now!</a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>