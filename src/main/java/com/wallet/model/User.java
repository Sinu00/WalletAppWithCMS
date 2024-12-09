package com.wallet.model;

public class User {
    private int userId;
    private String username;
    private String fullname;
	private String email;
    private String password;
    private double investmentAmount;

    // Constructors
    public User() {}

    public User(int userId, String username,String fullname, String email, String password, double investmentAmount) {
        this.userId = userId;
        this.username = username;
        this.fullname = fullname;
        this.email = email;
        this.password = password;
        this.investmentAmount = investmentAmount;
    }

    public User(String username, String fullname, String email, String password, double investmentAmount) {
		super();
		this.username = username;
		this.fullname = fullname;
		this.email = email;
		this.password = password;
		this.investmentAmount = investmentAmount;
	}

	// Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public double getInvestmentAmount() {
        return investmentAmount;
    }

    public void setInvestmentAmount(double investmentAmount) {
        this.investmentAmount = investmentAmount;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", username='" + username + '\'' +
                ", fullname='" + fullname + '\'' +
                ", email='" + email + '\'' +
                ", investmentAmount=" + investmentAmount +
                '}';
    }
}
