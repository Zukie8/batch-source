package com.revature.abstraction;

public class Driver {
	public static void main(String[] args) {
		InterfaceImpl impl = new InterfaceImpl();
		
		impl.doSomething();
		impl.doSomethingElse();
		System.out.println(InterfaceA.MY_INT);
		System.out.println();
		
		
		impl.myAbstractMethod();
		impl.myConcreteMethod();
		
		impl.printEach(1, 2, 3, 4, 5, 6, 7);
		
		String s1 = "Hello";
		String s2 = "Hello";
		
		System.out.println(s1.equals(s2));
	}
}
