/**
 * File: BoxCar.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The abstract class of a box car. Parent class for both the PassengerCar & FreightCar classes.
 */


public abstract class BoxCar
{
	private int m_capacity;//Number of cargo/people the box car can hold
	private int m_currSize;//Number of cargo/people the box car is holding
	
	/**
	 * The null constructor for BoxCar
	 */
	public BoxCar()
	{
		m_capacity = m_currSize = 0;
	}
	
	/**
	 * The int constructor for BoxCar
	 * @param capacity The capacity of the box car
	 */
	public BoxCar(int capacity)
	{
		setCapacity(capacity);
		
		m_currSize = 0;
	}
	
	/**
	 * The copy constructor for BoxCar
	 * @param other The BoxCar to be copied
	 */
	public BoxCar(BoxCar other)
	{
		setCapacity(other.m_capacity);
		setCurrentSize(other.m_currSize);
	}

	/**
	 * Getter for m_capacity
	 * @return m_capacity Number of cargo/people the car can hold
	 */
	public int getCapacity()
	{
		return m_capacity;
	}

	/**
	 * Setter for m_capacity
	 * @param newCapacity The capacity of the car
	 */
	public void setCapacity(int newCapacity)
	{
		if (newCapacity < 0)
		{
			System.out.println("Error: Capacity < 0, set to 0 !");
			m_capacity = 0;
		}
		else
			m_capacity = newCapacity;
	}
	
	/**
	 * Getter for m_currSize
	 * @return m_currSize The current size of the train
	 */
	public int getCurrentSize()
	{
		return m_currSize;
	}
	
	/**
	 * Setter for m_currSize
	 * @param newSize The new current size of the car
	 */
	public void setCurrentSize(int newSize)
	{
		m_currSize = newSize;
	}
	
	/**
	 * Increases m_currSize by 1 if possible
	 */
	public void incrementCurrentSizeBy1()
	{
		if (canIncrementCurrentSizeBy1())
			m_currSize++;
		else
			System.out.println("Error: Cannot add item!");
	}
	
	/**
	 * Decreases m_currSize by 1 if possible
	 */
	public void decrementCurrentSizeBy1()
	{
		if (canDecrementCurrentSizeBy1())
			m_currSize--;
		else
			System.out.println("Error: Cannot remove an item!");
	}
	
	/**
	 * Can an item be added to the box car
	 * @return True if train isn't full before addition
	 */
	public boolean canIncrementCurrentSizeBy1()
	{
		return m_currSize + 1 <= m_capacity;
	}
	
	/**
	 * Can an item be removed from the train
	 * @return True if at least 1 item in box car
	 */
	public boolean canDecrementCurrentSizeBy1()
	{
		return m_currSize - 1 >= 0;
	}
	
	/**
	 * Adds given person to the car if possible, only used in PassengerCar
	 * @param iD The governmentID of the person
	 * @param name The name of the person
	 * @param age The age of the person
	 */
	public abstract void addPerson(String iD, String name, int age);
	
	/**
	 * Adds given cargo to the car if possible, only used in FreightCar
	 * @param iD The ID of the cargo
	 * @param weight The weight of the cargo
	 * @param height The height of the cargo
	 */
	public abstract void addCargo(String iD, int weight, int height);
	
	/**
	 * Unloads the desired person/cargo from the box car, if it is on the car 
	 * @param iD The ID of the person/cargo
	 */
	public abstract void removeItem(String iD);
	
	/**
	 * Returns the type of the car
	 * @return 0 for Passenger car, 1 for Freight car
	 */
	public abstract int type();
	
	/**
	 * Looks to see if desired person/cargo is on the box car
	 * @param iD The ID of the person/cargo
	 * @return True if found the person/cargo
	 */
	public abstract boolean hasID(String iD);
	
	/**
	 * Returns a string of the box car and of its people/cargo
	 */
	public abstract String toString();
}