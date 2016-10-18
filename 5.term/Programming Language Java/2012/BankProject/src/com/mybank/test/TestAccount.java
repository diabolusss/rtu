package com.mybank.test;
import com.mybank.domain.Account;


public class TestAccount {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Account new_player = new Account(100);
		new_player.deposit(47);
		new_player.withdraw(150);
		System.out.println( "Final account balance: " + new_player.getBalance());
		
	}

}
