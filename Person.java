/**
 * File: Person.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The info for a person.
 */

public class Person
{
	private String m_governmentID;//The person's government ID
	private String m_name;//The person's full name
	private int m_age;//The person's age
	
	/*
	 * The null constructor for Person
	 */
	public Person()
	{
		m_governmentID = m_name = "";
		m_age = 0;
	}
	
	/**
	 * The String, String, age constructor for Person
	 * @param iD The person's governmentID
	 * @param name The person's name
	 * @param age The person's age, should be nonnegative
	 */
	public Person(String iD, String name, int age)
	{
		setID(iD);
		setName(name);
		setAge(age);
	}
	
	/**
	 * The copy constructor for Person
	 * @param other The Person to be copied
	 */
	public Person(Person other)
	{
		setID(other.m_governmentID);
		setName(other.m_name);
		setAge(other.m_age);
	}
	
	/**
	 * The getter for m_governmentID
	 * @return m_governmentID The person's ID
	 */
	public String getID()
	{
		return m_governmentID;
	}
	
	/**
	 * The setter for m_governmentID
	 * @param iD The person's ID
	 */
	public void setID(String iD)
	{
		m_governmentID = iD;
	}
	
	/**
	 * The getter for m_name
	 * @return m_name The person's name
	 */
	public String getName()
	{
		return m_name;
	}
	
	/**
	 * The setter for m_name
	 * @param name The name of the person
	 */
	public void setName(String name)
	{
		m_name = name;
	}
	
	/**
	 * The getter for m_age
	 * @return m_age The person's age
	 */
	public int getAge()
	{
		return m_age;
	}
	
	/**
	 * The setter for m_age
	 * @param age The age of the person, should be nonnegative
	 */
	public void setAge(int age)
	{
		if (age < 0)
			System.out.println("Error: Age < 0, age set to 0 !");
		else
			m_age = age;
	}
	
	/**
	 * Returns a string of the person
	 */
	public String toString()
	{
		return m_governmentID + ":\tName: " + m_name + "\t\tAge: " + m_age;
	}
}