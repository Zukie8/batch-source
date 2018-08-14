package com.revature.animals;

import com.revature.exceptions.NegativeTuskLength;

public class Elephant extends Mammal {
	
	public Elephant(int lengthOfTusks) {
		super();
		this.lengthOfTusks = lengthOfTusks;
	}

	private int lengthOfTusks;
	private int age = lengthOfTusks / 4; // this is abstraction
	// we're abstracting the calculation of age based on tusk length
	// so we as programmers only have to access .getAge();
	public int getLengthOfTusks() {
		return lengthOfTusks;
	}
	
	public void setLengthOfTusks(int lengthOfTusks) throws NegativeTuskLength {
		if(lengthOfTusks < 0) {
			throw new NegativeTuskLength();
		}
		this.lengthOfTusks = lengthOfTusks;
	}
	
	public int getAge() {
		return age;
	}
	
	
	
	
	
}
