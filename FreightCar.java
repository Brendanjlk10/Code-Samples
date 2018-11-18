/**
 * File: FreightCar.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The box car carrying cargo. Is-a BoxCar & has-a relationship with Cargo.
 */

import java.util.*;

public class FreightCar extends BoxCar
{
	private ArrayList<Cargo> m_cargo;//The ArrayList of cargo the Freight Car currently is hauling
	
	/**
	 * The null constructor for FreightCar
	 */
	public FreightCar()
	{
		super();
		m_cargo = new ArrayList<Cargo>(0);
	}
	
	/**
	 * The int constructor for FreightCar
	 * @param capacity The capacity of the freight car
	 */
	public FreightCar(int capacity)
	{
		super(capacity);
		m_cargo = new ArrayList<Cargo>(super.getCapacity());
	}
	
	/**
	 * The copy constructor of the freight car
	 * @param other The FreightCar to be copied
	 */
	public FreightCar(FreightCar other)
	{
		super(other.getCapacity());
		super.setCurrentSize(other.getCurrentSize());
		m_cargo = new ArrayList<Cargo>(other.getCapacity());
		m_cargo.addAll(other.m_cargo);
	}
	
	/**
	 * Adds the given cargo to the freight car, if possible
	 */
	public void addCargo(String iD, int weight, int height)
	{
		if (super.canIncrementCurrentSizeBy1())
		{
			m_cargo.add(new Cargo(iD, weight, height));
			super.incrementCurrentSizeBy1();
		}
		else
			System.out.println("Error: Cargo car full, didn't add cargo!");
	}
	
	/**
	 * //Does nothing in FreightCar
	 */
	public void addPerson(String iD, String name, int age) {}
	
	/**
	 * Removes the desired cargo from the freight car, if possible and found
	 */
	public void removeItem(String iD)
	{
		if (super.canDecrementCurrentSizeBy1())
		{
			for (int i = 0; i < super.getCurrentSize(); i++)
			{
				if (m_cargo.get(i).getID().equals(iD))
				{
					m_cargo.remove(i);
					super.decrementCurrentSizeBy1();
					return;
				}
			}
			System.out.println("Error: Cargo not found!");
		}
		else
			System.out.println("Error: No cargo in car, cargo not found!");
		return;
	}
	
	/**
	 * Returns 1 as the type
	 */
	public int type()
	{
		return 1;
	}
	
	/**
	 * Returns true if the cargo's ID is in this freight car
	 */
	public boolean hasID(String iD)
	{
		for (int i = 0; i < m_cargo.size(); i++)
			if (m_cargo.get(i).getID().equalsIgnoreCase(iD))
				return true;
		
		return false;
	}
	
	/**
	 * Returns a string of the cargo of the freight car
	 */
	public String toString()
	{
		String content = "";
		
		for (int i = 0; i < super.getCurrentSize(); i++)
			content += "\t\t" + m_cargo.get(i).toString() + "\n";
		
		return content;
	}
}