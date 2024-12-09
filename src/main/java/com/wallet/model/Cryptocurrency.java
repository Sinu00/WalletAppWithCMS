package com.wallet.model;

public class Cryptocurrency {
    private int coinId;
    private String coinName;
    private double currentPrice;
    private byte[] coinLogo;
    private String shortName;

    // Constructors
    public Cryptocurrency() {
    	super();
    }

    public Cryptocurrency(int coinId, String coinName, double currentPrice, byte[] coinLogo, String shortName) {
    	super();
    	this.coinId = coinId;
    	this.coinName = coinName;
    	this.currentPrice = currentPrice;
    	this.coinLogo = coinLogo;
    	this.shortName = shortName;
    }

    public Cryptocurrency(String coinName, double currentPrice, byte[] coinLogo, String shortName) {
		super();
		this.coinName = coinName;
		this.currentPrice = currentPrice;
		this.coinLogo = coinLogo;
		this.shortName = shortName;
	}


	
	// Getters and Setters
	public byte[] getCoinLogo() {
		return coinLogo;
	}

	public void setCoinLogo(byte[] coinLogo) {
		this.coinLogo = coinLogo;
	}

	public String getShortName() {
		return shortName;
	}



	public void setShortName(String shortName) {
		this.shortName = shortName;
	}


    public int getCoinId() {
        return coinId;
    }

    public void setCoinId(int coinId) {
        this.coinId = coinId;
    }

    public String getCoinName() {
        return coinName;
    }

    public void setCoinName(String coinName) {
        this.coinName = coinName;
    }

    public double getCurrentPrice() {
        return currentPrice;
    }

    public void setCurrentPrice(double currentPrice) {
        this.currentPrice = currentPrice;
    }


}
