package com.revature.models;

import com.revature.exceptions.*;

public class Vehicle {
	
	protected int speed;
	protected boolean hasWheels;
	protected int direction;
	
	public Vehicle() {
		super();
	}
	
	public Vehicle(int speed, boolean hasWheels, int direction) {
		this.speed = speed;
		this.hasWheels = hasWheels;
		this.direction = direction;
	}
	
	public void setSpeed(int speed) throws NegativeSpeedException {
		if(speed < 0) {
				throw new NegativeSpeedException("cannot go go negative speed");
		} else {
			System.out.println("Setting vehicle speed to: " + speed);
			this.speed = speed;
		}
		
	}
	
	public int getSpeed() {
		return speed;
	}
	
	public void setHasWheels(boolean hasWheels) {
		this.hasWheels = hasWheels;
	}
	

	public boolean getHasWheels() {
		return hasWheels;
	}

	public int getDirection() {
		return direction;
	}

	public void setDirection(int direction) {
		this.direction = direction;
	}
	
	public static void staticMethod() {
		System.out.println("static method from Vehicle class");
	}
	
	@Override
	public boolean equals(Object arg0) {
		if (this == arg0) {
			return true;
		}
		
		if (arg0 == null) {
			return false;
		} 
		// check if same class
		if(getClass() != arg0.getClass()) {
			return false;
		}
		
		Vehicle otherObj = (Vehicle) arg0;
		// check all values
		if ( speed != otherObj.getSpeed() ) {
			return false;
		}
		if ( hasWheels != otherObj.getHasWheels() ) {
			return false;
		}
		if ( direction != otherObj.getDirection() ) {
			return false;
		}
		
		return true;
		
		
	}

	@Override
	public String toString() {
		return "Vehicle [speed=" + speed + ", hasWheels=" + hasWheels + ", direction=" + direction + "]";
	}

	

	
	
	
}
