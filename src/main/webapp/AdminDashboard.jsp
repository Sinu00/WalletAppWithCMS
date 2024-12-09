<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<%@ page import="com.wallet.model.User" %>
<%@ page import="com.wallet.model.Cryptocurrency" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Admin Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            scrollbar-width: thin;
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
            overflow-x: hidden;
        }

        .admin-dashboard-container {
            background-color: rgba(17, 24, 39, 0.8);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            max-width: 1400px;
            margin: 0 auto;
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

        .admin-profile {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
        }

        .admin-profile img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
            background: linear-gradient(135deg, rgba(255,255,255,0.1), rgba(255,255,255,0.05));
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background-color: rgba(31, 41, 55, 0.8);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card h3 {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            margin-bottom: 10px;
        }

        .stat-card .value {
            font-size: 24px;
            font-weight: 600;
        }

        .stat-card .change {
            font-size: 14px;
            margin-top: 5px;
        }

        .positive { color: #4caf50; }
        .negative { color: #ff4d4d; }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 20px;
        }

        .user-activity, .recent-transactions, .coins-section {
            background-color: rgba(31, 41, 55, 0.8);
            border-radius: 12px;
            padding: 20px;
            overflow-x: auto;
        }
        
        .coins-section {
            margin-top: 20px;
        }

        .table-container {
            overflow-x: auto;
            width: 100%;
        }

        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            min-width: 600px;
        }

        .admin-table th {
            text-align: left;
            color: rgba(255, 255, 255, 0.6);
            font-size: 12px;
            padding: 0 10px;
            white-space: nowrap;
        }

        .admin-table tr {
            background-color: rgba(17, 24, 39, 0.6);
            border-radius: 8px;
        }

        .admin-table td {
            padding: 15px 10px;
            color: #ffffff;
            white-space: nowrap;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
        }

        .btn-view {
            background-color: rgba(59, 130, 246, 0.7);
            color: white;
        }

        .btn-edit {
            background-color: rgba(16, 185, 129, 0.7);
            color: white;
        }

        .btn-add {
            background-color: rgba(255, 193, 7, 0.7);
            color: white;
        }

        .btn-delete {
            background-color: rgba(244, 67, 54, 0.7);
            color: white;
        }

        .logout-button {
            background: linear-gradient(to right, rgba(59, 130, 246, 0.8), rgba(79, 70, 229, 0.8));
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        /* Enhanced Mobile Responsiveness */
        @media screen and (max-width: 1024px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            .admin-dashboard-container {
                padding: 10px;
            }
        }

        @media screen and (max-width: 768px) {
            .dashboard-header {
                flex-direction: column;
                text-align: center;
            }

            .admin-profile {
                flex-direction: column;
                text-align: center;
                margin-bottom: 15px;
            }

            .admin-profile img {
                margin-right: 0;
                margin-bottom: 10px;
            }

            .quick-stats {
                grid-template-columns: repeat(2, 1fr);
            }

            .logout-button {
                width: 100%;
                margin-top: 10px;
            }

            .admin-table {
                font-size: 12px;
            }

            .btn {
                padding: 4px 8px;
                font-size: 10px;
            }
        }

        @media screen and (max-width: 480px) {
            .quick-stats {
                grid-template-columns: 1fr;
            }

            .admin-profile h1 {
                font-size: 1.5rem;
            }

            .stat-card .value {
                font-size: 20px;
            }

            .stat-card .change {
                font-size: 12px;
            }
        }
        
           .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.7);
            backdrop-filter: blur(10px);
            justify-content: center;
            align-items: center;
            padding: 15px;
        }

        .modal-content {
            background-color: rgba(31, 41, 55, 0.9);
            border-radius: 16px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            width: 100%;
            max-width: 450px;
            max-height: 90vh;
            overflow-y: auto;
            padding: 25px;
            color: #ffffff;
            font-family: 'Inter', sans-serif;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding-bottom: 15px;
        }

        .modal-header h2 {
            margin: 0;
            font-size: 20px;
            color: #ffffff;
        }

        .modal-close {
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.6);
            font-size: 24px;
            cursor: pointer;
            transition: color 0.3s ease;
            padding: 0;
            line-height: 1;
        }

        .modal-close:hover {
            color: #ffffff;
        }

        .modal-form {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
        }

        .modal-form label {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            margin-bottom: 5px;
            display: block;
        }

        .modal-form input, 
        .modal-form select {
            width: 100%;
            padding: 10px;
            background-color: rgba(17, 24, 39, 0.8);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: #ffffff;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
        }

        .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .modal-btn {
            padding: 10px 15px;
            border-radius: 8px;
            border: none;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .modal-btn-cancel {
            background-color: rgba(244, 67, 54, 0.7);
            color: white;
        }

        .modal-btn-submit {
            background-color: rgba(16, 185, 129, 0.7);
            color: white;
        }

        @media screen and (max-width: 480px) {
            .modal-content {
                padding: 15px;
                max-width: 100%;
                margin: 0;
            }

            .modal-header h2 {
                font-size: 18px;
            }

            .modal-actions {
                flex-direction: column;
                gap: 10px;
            }

            .modal-btn {
                width: 100%;
            }
        }
        
        /* Custom Scrollbar */
/* Custom Scrollbar */
*::-webkit-scrollbar {
    width: 12px; /* Slightly wider for more visibility */
}

*::-webkit-scrollbar-track {
    background: rgba(17, 24, 39, 0.8); /* Darker track background */
    border-radius: 10px;
}

*::-webkit-scrollbar-thumb {
    background: rgba(59, 130, 246, 0.7); /* More saturated blue */
    border-radius: 10px;
    border: 3px solid transparent;
    background-clip: content-box;
}

*::-webkit-scrollbar-thumb:hover {
    background: rgba(59, 130, 246, 0.9); /* Even more saturated on hover */
    
    
}
    </style>
</head>
<body>
    <div class="admin-dashboard-container">
        <div class="dashboard-header">
            <div class="admin-profile">
                <img src="/api/placeholder/50/50" alt="Admin Profile">
                <div>
                    <h1>Admin Dashboard</h1>
                    <p style="color: rgba(255, 255, 255, 0.6);">Welcome, System Administrator</p>
                </div>
            </div>
            <button class="logout-button" onclick="window.location.href='DestroySession';">Logout</button>
        </div>

        <div class="quick-stats">
            <div class="stat-card">
                <h3>Total Users</h3>
                <div class="value">
                    <% 
                        List<User> allUsers = (List<User>) session.getAttribute("allUsers");
                        out.print(allUsers != null ? allUsers.size() : 0); 
                    %>
                </div>
                <div class="change positive">+3.2% (30d)</div>
            </div>
            <div class="stat-card">
                <h3>Total Transactions</h3>
                <div class="value">12,456</div>
                <div class="change positive">+5.7% (30d)</div>
            </div>
            <div class="stat-card">
                <h3>Total Volume</h3>
                <div class="value">$4.3M</div>
                <div class="change positive">+8.1% (30d)</div>
            </div>
            <div class="stat-card">
                <h3>Active Users</h3>
                <div class="value">1,876</div>
                <div class="change negative">-1.2% (30d)</div>
            </div>
        </div>

        <div class="dashboard-grid">
            <div class="user-activity">
                <div class="section-header">
                    <h2 style="color: #ffffff;">User Activity</h2>
                    <button class="btn btn-add">Add User</button>
                </div>
                <div class="table-container">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Email</th>
                                <th>Registration Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                if (allUsers != null) {
                                    for (User user : allUsers) {
                            %>
                            <tr>
                                <td><%= user.getFullname() %></td>
                                <td><%= user.getEmail() %></td>
                                <%-- <td><%= user.getRegistrationDate() %></td> --%>
<%--                                 <td style="color: <%= user.getStatus().equals("Active") ? "#4caf50" : "#ff4d4d" %>;">
                                    <%= user.getStatus() %>
                                </td> --%>
                                <td>24/12/2024</td>
                                <td style="color:"#4caf50">Active</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-view">View</button>
                                        <button class="btn btn-edit">Edit</button>
                                        <button class="btn btn-delete" onclick="window.location.href='DeleteWithId?UserId=<%= user.getUserId() %>';">Delete</button>
                                    </div>
                                </td>
                            </tr>
                            <% 
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="recent-transactions">
                <div class="section-header">
                    <h2 style="color: #ffffff;">Recent Transactions</h2>
                    <button class="btn btn-add">Add Transaction</button>
                </div>
                <div class="table-container">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#TX-2024-001</td>
                                <td>$5,000.00</td>
                                <td style="color: #4caf50;">Completed</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-view">View</button>
                                        <button class="btn btn-edit">Edit</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#TX-2024-002</td>
                                <td>$3,200.50</td>
                                <td style="color: #ff4d4d;">Pending</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-view">View</button>
                                        <button class="btn btn-edit">Edit</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>#TX-2024-003</td>
                                <td>$7,600.25</td>
                                <td style="color: #4caf50;">Completed</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-view">View</button>
                                        <button class="btn btn-edit">Edit</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <div class="coins-section">
            <div class="section-header">
                <h2 style="color: #ffffff;">Coins Overview</h2>
                <button class="btn btn-add">Add Coin</button>
            </div>
            <div class="table-container">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Coin</th>
                            <th>Price</th>
                            <th>24h Change</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
    List<Cryptocurrency> allCoins = (List<Cryptocurrency>) session.getAttribute("allCoins");
    if (allCoins == null || allCoins.isEmpty()) { 
%>
    <tr>
        <td colspan="4">No coins available</td>
    </tr>
<% 
    } else { 
        for (Cryptocurrency coin : allCoins) { 
%>
<tr>
    <td><%= coin.getCoinName() %> (<%= coin.getShortName() %>)</td>
    <td>$<%= coin.getCurrentPrice() %></td>
<%--     <td style="color: <%= coin.getChange24h() > 0 ? "#4caf50" : "#ff4d4d" %>;">
        <%= coin.getChange24h() %>%
    </td> --%>
        <td style="color:#4caf50">
        0
    </td> 
    <td>
        <div class="action-buttons">
            <button class="btn btn-view">View</button>
            <button class="btn btn-edit">Edit</button>
            <button class="btn btn-delete" onclick="window.location.href='DeleteWithId?CoinId=<%= coin.getCoinId() %>';">Delete</button>
        </div>
    </td>
</tr>
<% 
        }
    }
%>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New User</h2>
                <button class="modal-close" onclick="closeModal('addUserModal')">&times;</button>
            </div>
            <form class="modal-form" method="post" action="AddNewUser">
                <div>
                    <label for="fullname">Full Name</label>
                    <input type="text" id="fullname" name="fullname" required>
                </div>

                <div>
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div>
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div>
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div>
                    <label for="amount">Amount Invested</label>
                    <input type="number" id="amount" name="amount" required>
                </div>

<!--                 <div>
                    <label for="userStatus">Status</label>
                    <select id="userStatus" name="userStatus">
                        <option value="active">Active</option>
                        <option value="suspended">Suspended</option>
                    </select>
                </div> -->

                <div class="modal-actions">
                    <button type="button" class="modal-btn modal-btn-cancel" onclick="closeModal('addUserModal')">Cancel</button>
                    <button type="submit" class="modal-btn modal-btn-submit">Add User</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Add Transaction Modal -->
    <div id="addTransactionModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Transaction</h2>
                <button class="modal-close" onclick="closeModal('addTransactionModal')">&times;</button>
            </div>
            <form class="modal-form">
                <label for="transactionAmount">Amount</label>
                <input type="number" id="transactionAmount" name="transactionAmount" step="0.01" required>

                <label for="transactionStatus">Status</label>
                <select id="transactionStatus" name="transactionStatus">
                    <option value="pending">Pending</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>

                <div class="modal-actions">
                    <button type="button" class="modal-btn modal-btn-cancel" onclick="closeModal('addTransactionModal')">Cancel</button>
                    <button type="submit" class="modal-btn modal-btn-submit">Add Transaction</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Add Coin Modal -->
    <div id="addCoinModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Coin</h2>
                <button class="modal-close" onclick="closeModal('addCoinModal')">&times;</button>
            </div>
            <form class="modal-form" method="post" action="AddNewCoin" enctype="multipart/form-data">
                <label for="coinName">Coin Name</label>
                <input type="text" id="coinName" name="coinName" required>

                <label for="coinPrice">Current Price</label>
                <input type="number" id="coinPrice" name="coinPrice" required>
                
                <label for="coinShortName">Coin ShortName</label>
                <input type="text" id="coinShortName" name="coinShortName" required>

				<label for="coinLogo">Coin Logo</label>
				<input type="file" id="coinLogo" name="coinLogo" accept="image/*">

                <div class="modal-actions">
                    <button type="button" class="modal-btn modal-btn-cancel" onclick="closeModal('addCoinModal')">Cancel</button>
                    <button type="submit" class="modal-btn modal-btn-submit">Add Coin</button>
                </div>
            </form>
        </div>
    </div>
    
    <script>
    // Function to open modal
    function openModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.style.display = 'flex';
    }

    // Function to close modal
    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.style.display = 'none';
    }

    // Add event listeners to "Add" buttons
    document.querySelector('.btn-add[onclick]') && 
    document.querySelector('.btn-add[onclick]').addEventListener('click', () => openModal('addUserModal'));

    document.querySelectorAll('.btn-add').forEach((btn, index) => {
        btn.onclick = () => {
            switch(index) {
                case 0:
                    openModal('addUserModal');
                    break;
                case 1:
                    openModal('addTransactionModal');
                    break;
                case 2:
                    openModal('addCoinModal');
                    break;
            }
        };
    });

    // Close modal when clicking outside of it
    window.onclick = function(event) {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        });
    }
    </script>
</body>
</html>