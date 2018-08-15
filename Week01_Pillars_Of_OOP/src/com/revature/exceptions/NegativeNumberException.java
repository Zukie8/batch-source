package com.revature.exceptions;


/** This is a runtime exception that is thrown when a negative number is 
 * provided as a parameter when one should not have. */
public class NegativeNumberException extends IllegalArgumentException {
	
	
	/** A generated serial ID required by extending the IllegalArgumentException
	 * class. */
	private static final long serialVersionUID = -4598696230690765490L;


	/** Constructs a new NegativeNumberException with a default message. */
	public NegativeNumberException() {
		super("Negative Numbers are not allowed. ");
	} // end of constructor NegativeNumberException
	
	
	/** Constructs a new NegativeNumberException with the specified message. 
	 * @param message The message of the exception */
	public NegativeNumberException(String message) {
		super(message);
	} // end of constructor NegativeNumberException
	
	
} // end of class NegativeNumberException
