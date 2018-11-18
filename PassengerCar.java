/**
 * File: PassengerCar.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The box car carrying passengers. Is-a BoxCar & has-a relationship with Person.
 */

import java.util.*;

public class PassengerCar extends BoxCar
{
	private ArrayList<Person> m_passengers;//The ArrayList of people the Passenger Car currently is holding
	
	/**
	 * The null constructor for PassengerCar
	 */
	public PassengerCar()
	{
		super();
		m_passengers = new ArrayList<Person>(0);
	}
	
	/**
	 * The int constructor for PassengerCar
	 * @param capacity The capacity of the PassengerCar
	 */
	public PassengerCar(int capacity)
	{
		super(capacity);
		m_passengers = new ArrayList<Person>(super.getCapacity());
	}
	
	/**
	 * The copy constructor of the PassengerCar
	 * @param other The PassengerCar to be copied
	 */
	public PassengerCar(PassengerCar other)
	{
		super(other.getCapacity());
		super.setCurrentSize(other.getCurrentSize());
		m_passengers = new ArrayList<Person>(other.getCapacity());
		m_passengers.addAll(other.m_passengers);
	}
	
	/**
	 * Adds the given person to the passenger car, if possible
	 */
	public void addPerson(String iD, String name, int age)
	{
		if (super.canIncrementCurrentSizeBy1())
		{
			m_passengers.add(new Person(iD, name, age));
			super.incrementCurrentSizeBy1();
		}
		else
			System.out.println("Error: Passenger car full, didn't add passenger!");
	}
	
	/**
	 * //Does nothing in PassengerCar
	 */
	public void addCargo(String iD, int weight, int height) {}
	
	/**
	 * Removes the desired person from the car, if possible
	 */
	public void removeItem(String iD)
	{
		if (super.canDecrementCurrentSizeBy1())
		{
			for (int i = 0; i < super.getCurrentSize(); i++)
			{
				if (m_passengers.get(i).getID().equalsIgnoreCase(iD))
				{
					m_passengers.remove(i);
					super.decrementCurrentSizeBy1();
					return;
				}
			}
			System.out.println("Error: Passenger not found!");
		}
		else
			System.out.println("Error: No passengers in car, passenger not found!");
		return;
	}
	
	/**
	 * Returns 0 as the type of the car
	 */
	public int type()
	{
		return 0;
	}
	
	/**
	 * Returns true if found the person's ID in the car
	 */
	public boolean hasID(String iD)
	{
		for (int i = 0; i < m_passengers.size(); i++)
			if (m_passengers.get(i).getID().equalsIgnoreCase(iD))
				return true;
		
		return false;
	}
	
	/**
	 * Returns the info each person in the car
	 */
	public String toString()
	{
		String content = "";
		
		for (int i = 0; i < super.getCurrentSize(); i++)
			content += "\t\t" + m_passengers.get(i).toString() + "\n";
		
		return content;
	}
}