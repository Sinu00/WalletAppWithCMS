package com.wallet.model;

public class Investment {
    private int investmentId;
    private int userId;
    private int coinId;
    private double investmentAmount;
    private double quantity;
    private double profitLoss;

    // Constructors
    public Investment() {}

    public Investment(int investmentId, int userId, int coinId, double investmentAmount,double quantity, double profitLoss) {
        this.investmentId = investmentId;
        this.userId = userId;
        this.coinId = coinId;
        this.investmentAmount = investmentAmount;
        this.quantity =quantity;
        this.profitLoss = profitLoss;
    }

    // Getters and Setters
    public int getInvestmentId() {
        return investmentId;
    }

    public void setInvestmentId(int investmentId) {
        this.investmentId = investmentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCoinId() {
        return coinId;
    }

    public void setCoinId(int coinId) {
        this.coinId = coinId;
    }

    public double getInvestmentAmount() {
        return investmentAmount;
    }

    public void setInvestmentAmount(double investmentAmount) {
        this.investmentAmount = investmentAmount;
    }
    
    public double getQuantity() {
		return quantity;
	}

	public void setQuantity(double quantity) {
		this.quantity = quantity;
	}

	public double getProfitLoss() {
        return profitLoss;
    }

    public void setProfitLoss(double profitLoss) {
        this.profitLoss = profitLoss;
    }

    @Override
    public String toString() {
        return "Investment{" +
                "investmentId=" + investmentId +
                ", userId=" + userId +
                ", coinId=" + coinId +
                ", investmentAmount=" + investmentAmount +
                ", profitLoss=" + profitLoss +
                '}';
    }
}
