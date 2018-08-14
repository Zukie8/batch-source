package com.revature.strings;

public class StringDriver {
	public static void main(String[] args) {
		
		String s1 = "I'm a string!";
		String s2 = "I'm a string!";
		
		// due to string pool these two objects are the same
		System.out.println("Objects are ==: " + (s1 == s2));
		System.out.println("Objects are equals: " + (s1.equals(s2)));
		System.out.println("S1 hash code: " + s1.hashCode());
		System.out.println("S2 hash code: " + s2.hashCode());
		System.out.println();
		
		String alsoString1 = s1;
		// returns a new String object reference in String Pool
		s1 = s1 + "!";
		
		
		System.out.println(s1);
		System.out.println(alsoString1);
		// diff hashcodes due to diff spots in String Pool
		System.out.println("S1 hash code: " + s1.hashCode());
		System.out.println("Also string one: " + alsoString1.hashCode());
		
		System.out.println(s1 == alsoString1);
		System.out.println(s1.equals(alsoString1));
		
		System.out.println();
		
		// using StringBuilder
		StringBuilder sb = new StringBuilder("I'm a string builder object!");
		StringBuilder sb2 = new StringBuilder("I'm a string builder object!");
		
		System.out.println("sb1 hashcode before mutation: " + sb.hashCode());
		System.out.println("sb2 hashcode: " + sb2.hashCode());
		// .equals is actually using a value equality here, not a reference
		// .equals is overriden in the String class so it has a meaningful implementation
		// whereas .equals is not overriden in the StringBuilder class
		System.out.println(sb.toString().equals(sb2.toString()));
		System.out.println();
		
		// modifying a StringBuilder's value
		StringBuilder alsoSb = sb;
		System.out.println("sb: " + sb);
		System.out.println("alsoSb hashcode " + alsoSb.hashCode());
		System.out.println("alsoSb: " + alsoSb);
		
		sb.append("!");
		
		System.out.println("sb1 hashcode after mutation: " + sb.hashCode());
		System.out.println("alsoSb hashcode after sb's mutation: " + alsoSb.hashCode());
		
		
		
	}
}
