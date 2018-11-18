/**
 * File: Cargo.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The info for a cargo item.
 */

public class Cargo
{
	private String m_ID;//The ID of the cargo
	private int m_weight;//The weight of the cargo
	private int m_height;//The height of the cargo
	
	/**
	 * The null constructor for Cargo
	 */
	public Cargo()
	{
		m_ID = "";
		m_weight = m_height = 0;
	}
	
	/**
	 * The String, int, int constructor for Cargo
	 * @param iD The cargo's ID
	 * @param weight The cargo's weight, should be nonnegative
	 * @param height The cargo's height, should be nonnegative
	 */
	public Cargo(String iD, int weight, int height)
	{
		setID(iD);
		setWeight(weight);
		setHeight(height);
	}
	
	/**
	 * The copy constructor for Cargo
	 * @param other The Cargo to be copied
	 */
	public Cargo(Cargo other)
	{
		setID(other.m_ID);
		setWeight(other.m_weight);
		setHeight(other.m_height);
	}
	
	/**
	 * The getter for m_ID
	 * @return m_ID The cargo's ID
	 */
	public String getID()
	{
		return m_ID;
	}
	
	/**
	 * The setter for m_ID
	 * @param iD The cargo's ID
	 */
	public void setID(String iD)
	{
		m_ID = iD;
	}
	
	/**
	 * The getter for m_weight
	 * @return m_weight The cargo's weight
	 */
	public int getWeight()
	{
		return m_weight;
	}
	
	/**
	 * The setter for m_weight
	 * @param weight The cargo's weight
	 */
	public void setWeight(int weight)
	{
		if (weight < 0)
		{
			System.out.println("Error: Weight : " + weight + " negative, set to 0 !");
			m_weight = 0;
		}
		else
			m_weight = weight;
	}
	
	/**
	 * The getter for m_height
	 * @return m_height The cargo's height
	 */
	public int getHeight()
	{
		return m_height;
	}
	
	/**
	 * The setter for m_height
	 * @param height The cargo's height
	 */
	public void setHeight(int height)
	{
		if (height < 0)
		{
			System.out.println("Error: Height : " + height + " negative, set to 0 !");
			m_height = 0;
		}
		else
			m_height = height;
	}
	
	/**
	 * Returns a string of the 
	 */
	public String toString()
	{
		return m_ID + ":\tWeight: " + m_weight + "\tHeight: " + m_height;
	}
}