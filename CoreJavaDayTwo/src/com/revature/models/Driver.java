package com.revature.models;

import com.revature.exceptions.NegativeSpeedException;

public class Driver {
	public static void main(String[] args) {
////		Vehicle car = new Vehicle();
////		Vehicle car2 = new Vehicle();
//		
//		
////		System.out.println(car);
////		System.out.println(car2);
////		
////		System.out.println(car.equals(car2));
//		/*
//		 * Multi line comments
//		 */
//		
//		
//		System.out.println("Declaring a vehicle obj:");
//		
//		Vehicle myVehicle = new Vehicle();
//		myVehicle.setSpeed(5);
//		myVehicle.setSpeed(10);
//		System.out.println();
//		
//		System.out.println("Declaring a hybrid car object:");
//		// at runtime JVM checks for which implementation of the setspeed method
//		Hybrid fordFusion = new Hybrid();
//		fordFusion.setSpeed(50);
//		fordFusion.setSpeed(60);
//		System.out.println(fordFusion);
//		
//		
//		// not actually overriding
//		// Runtime Polymorphism
//		// method hiding is the term
//		Vehicle.staticMethod();
//		Hybrid.staticMethod();
		
		Vehicle v1 = new Vehicle();
		try {
			v1.setSpeed(-2);
		} catch (NegativeSpeedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
