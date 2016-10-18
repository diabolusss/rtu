package com.mybank.domain;

public class Account {
	private double balance;
	
	public Account(double balance) {
        this.balance = balance;
    }
	public void deposit(double deposit) {
        balance += deposit;
    }
	public void withdraw(double withdraw) {
        if (balance >= withdraw){
        	balance -= withdraw;
        }else System.out.println( "Insufficient balance amount");
        
    }
	
	public double getBalance(){		
		return balance;
	}
}
