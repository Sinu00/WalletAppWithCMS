# CoinVault - Investment & Wallet Management App

CoinVault is a wallet management application that allows admins to create and manage users, as well as add and track investments in virtual coins. Users can monitor their investment portfolio and track the performance of the coins they have invested in. Admins can also create new coins and set their prices.

## Features

- **User Features:**
  - User Registration and Login
  - View Investment Portfolio
  - Track Coin Prices
  - Monitor Investment Performance

- **Admin Features:**
  - Admin Login
  - Add and Manage Users
  - Create and Manage Coins (Name, Price)
  - Add Investments for Users
  - View and Update User Investments

## Tech Stack

- **Frontend:**
  - JavaServer Pages (JSP)
  - HTML, CSS, JavaScript

- **Backend:**
  - Java Servlets
  - JDBC for Database Connection

- **Database:**
  - MySQL

## Installation

To set up the CoinVault project on your local machine, follow the steps below:

### Prerequisites

- Java Development Kit (JDK) 8 or higher
- Apache Tomcat (or any servlet container)
- MySQL database server

### Steps

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-username/coinvault.git
   ```

2. **Set up the Database:**
   - Create a MySQL database named `coinvault`:
   
     ```sql
     CREATE DATABASE coinvault;
     ```

   - Import the database schema from `coinvault_schema.sql` (if provided) or create your own tables based on the app's requirements.

   - Example table creation:
   
     ```sql
     CREATE TABLE users (
         id INT AUTO_INCREMENT PRIMARY KEY,
         username VARCHAR(50) NOT NULL,
         password VARCHAR(255) NOT NULL,
         email VARCHAR(100),
         balance DECIMAL(10, 2) DEFAULT 0
     );

     CREATE TABLE coins (
         id INT AUTO_INCREMENT PRIMARY KEY,
         name VARCHAR(50),
         price DECIMAL(10, 2)
     );

     CREATE TABLE investments (
         id INT AUTO_INCREMENT PRIMARY KEY,
         user_id INT,
         coin_id INT,
         amount DECIMAL(10, 2),
         FOREIGN KEY (user_id) REFERENCES users(id),
         FOREIGN KEY (coin_id) REFERENCES coins(id)
     );
     ```

3. **Configure Database Connection:**
   - Open the `web.xml` or relevant configuration file to set your database connection details (hostname, username, password).

4. **Deploy to Tomcat:**
   - Build the project and deploy the `WAR` file to your Apache Tomcat server (or any other servlet container).

5. **Run the Application:**
   - Once the server is running, navigate to `http://localhost:8080/coinvault` in your web browser to access the app.

## Usage

### User Flow:

1. **Sign up/Login:**
   - New users can create an account with a username and password, while returning users can log in.

2. **View Portfolio:**
   - After logging in, users can see a list of coins they have invested in, the amount of each coin they own, and the current value of their investments based on the coin prices.

3. **Track Coin Prices:**
   - Users can view the latest prices of various coins available on the platform.

### Admin Flow:

1. **Admin Login:**
   - Admins can log in using their credentials to access the admin dashboard.

2. **Manage Users:**
   - Admins can add new users, view existing users, and manage user investments.

3. **Manage Coins:**
   - Admins can create new coins, set their prices, and update the prices of existing coins.

4. **Add Investments:**
   - Admins can add investments for users by selecting the coin and the amount to invest.

## Directory Structure

```
/coinvault
├── /src
│   ├── /model          # Java classes for database models (User, Coin, Investment)
│   ├── /controller     # Servlet classes for handling requests (Login, Registration, Admin, etc.)
│   ├── /view           # JSP pages for user interface (Login.jsp, Dashboard.jsp, AdminPanel.jsp)
│   └── /utils          # Utility classes (e.g., database connection management)
├── /web
│   ├── /WEB-INF        # Configuration files (web.xml, etc.)
│   ├── /lib            # External libraries (JARs)
├── /resources          # Static files (CSS, JS, images)
└── README.md           # This file
```

## Contributing

If you want to contribute to the development of CoinVault, feel free to fork the repository, make changes, and create a pull request. Please ensure your changes align with the coding standards used in the project.
