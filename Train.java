/**
 * File: Train.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The main class for the train which manages and controls the train.
 */

import java.util.*;

public class Train
{
	private ArrayList<BoxCar> m_cars;//The ArrayList of BoxCars
	private int m_maxSpeed;//The max speed of the train
	private int m_minSpeed;//The minimum speed of the train
	private int m_maxCars;//The max number of cars the train can haul
	private int m_currentNumOfCars;//The number of cars the train currently is hauling
	private int m_currentSpeed;//The current speed of the train
	private String m_location;//The current location of the train
	private String m_origin;//The current/last station the train is/was at
	private String m_destination;//The next/current station the train will be/is at
	private boolean m_inStation;//Whether or not the train is currently in a station
	
	/**
	 * The null constructor for Train.
	 */
	public Train()
	{
		m_maxSpeed = m_minSpeed = m_maxCars = m_currentSpeed = 0;
		m_location = "";
		m_inStation = true;
		m_cars = new ArrayList<BoxCar>(0);
	}
	
	/**
	 * The String, int, int, int constructor for Train.
	 * @param start The station the train is initially stopped at
	 * @param minSpeed The minimum allowed speed for the train while moving
	 * @param maxSpeed The maximum allowed speed for the train
	 * @param maxCars The maximum number of cars the train can pull
	 */
	public Train(String start, int minSpeed, int maxSpeed, int maxCars)
	{
		m_location = "Stopped in " + start;
		m_origin = m_destination = start;
		m_inStation = true;
		m_currentSpeed = 0;
		
		if (minSpeed < 0)
		{
			System.out.println("Error: Min speed negative, set to 0 !");
			m_minSpeed = 0;
		}
		if (maxSpeed < 0)
		{
			if (m_minSpeed > 0)
			{
				System.out.println("Error: Max speed negative, setting min & max speeds to 0 !");
				m_maxSpeed = m_minSpeed = 0;
			}
			else
			{
				System.out.println("Error: Max speed negative, setting max speed to 0 !");
				m_maxSpeed = 0;
			}
		}
		if (minSpeed >= 0 && maxSpeed >= 0)
		{
			if (minSpeed > maxSpeed)
			{
				System.out.println("Error: Min speed greater than max speed, swapping them!");
				m_minSpeed = maxSpeed;
				m_maxSpeed = minSpeed;
			}
			else
			{
				m_minSpeed = minSpeed;
				m_maxSpeed = maxSpeed;
			}
		}
		
		m_currentNumOfCars = 0;
		setMaxNumOfCars(maxCars);
		
		m_cars = new ArrayList<BoxCar>(m_maxCars);
	}
	
	/**
	 * The copy constructor for Train
	 * @param other The Train to be copied
	 */
	public Train(Train other)
	{
		setMaxSpeed(other.m_maxSpeed);
		setMinSpeed(other.m_minSpeed);
		setMaxNumOfCars(other.m_maxCars);
		setNumOfCars(other.m_currentNumOfCars);
		setCurrentSpeed(other.m_currentSpeed);
		setOrigin(other.m_origin);
		setDestination(other.m_destination);
		setInStation(other.m_inStation);
		m_cars = new ArrayList<BoxCar>(m_maxCars);
	}
	
	/**
	 * The getter for m_maxSpeed
	 * @return m_maxSpeed The maximum speed the train can go
	 */
	public int getMaxSpeed()
	{
		return m_maxSpeed;
	}
	
	/**
	 * The setter for m_maxSpeed
	 * @param maxSpeed The maximum speed the train can go
	 */
	public void setMaxSpeed(int maxSpeed)
	{
		if (maxSpeed >= 0)
		{
			if (maxSpeed >= m_minSpeed)
				m_maxSpeed = maxSpeed;
			else
			{
				System.out.println("Error: Max speed less than min speed, changing both to be equal!");
				m_maxSpeed = m_minSpeed = maxSpeed;
			}
		}
		else
		{
			System.out.println("Error: Max speed negative, set min and max speed to 0 !");
			m_maxSpeed = m_minSpeed = 0;
		}
	}
	
	/**
	 * Getter for m_minSpeed
	 * @return m_minSpeed The minimum speed the train can travel while not in station
	 */
	public int getMinSpeed()
	{
		return m_minSpeed;
	}
	
	/**
	 * The setter for m_minSpeed
	 * @param minSpeed The minimum allowed speed for the train while it is moving
	 */
	public void setMinSpeed(int minSpeed)
	{
		if (minSpeed >= 0)
		{
			if (minSpeed <= m_maxSpeed)
				m_minSpeed = minSpeed;
			else
			{
				System.out.println("Error: Min speed greater than max speed, changing both!");
				m_maxSpeed = m_minSpeed = minSpeed;
			}
		}
		else
			System.out.println("Error: Min speed negative, not changed!");
	}
	
	/**
	 * The getter for m_currentSpeed
	 * @return m_currentSpeed The current speed of the train
	 */
	public int getCurrentSpeed()
	{
		return m_currentSpeed;
	}
	
	/**
	 * The setter for m_currentSpeed
	 * @param newSpeed The new speed of the train, if valid
	 */
	public void setCurrentSpeed(int newSpeed)
	{
		if (!m_inStation)
		{
			if (validSpeed(newSpeed))
				m_currentSpeed = newSpeed;
			else
				System.out.println("Error: Invalid speed!");
		}
		else if (newSpeed == 0)
			m_currentSpeed = newSpeed;
		else if (newSpeed < 0)
			System.out.println("Error: Negative speed!");
		else
			System.out.println("Error: Train in station, train cannot move!");
	}
	
	/**
	 * The getter for m_maxCars
	 * @return m_maxCars The maximum number of cars the train can haul
	 */
	public int getMaxNumOfCars()
	{
		return m_maxCars;
	}
	
	/**
	 * The setter for m_maxCars
	 * @param totalMaxCars The maximum number of cars the train can haul
	 */
	public void setMaxNumOfCars(int totalMaxCars)
	{
		if (totalMaxCars < 0)
		{
			if (m_currentNumOfCars <= 0)
			{
				System.out.println("Error: Max num cars negative, set to 0 !");
				m_maxCars = 0;
			}
			else
			{
				System.out.println("Error: Max num cars negative, set to current num of cars!");
				m_maxCars = m_currentNumOfCars;
			}
		}
		else if (totalMaxCars < m_currentNumOfCars)
		{
			System.out.println("Error: Current train size > new max size, max size set to current size!");
			m_maxCars = m_currentNumOfCars;
		}
		else
			m_maxCars = totalMaxCars;
	}
	
	/**
	 * The getter for m_currentNumOfCars
	 * @return m_currentNumOfCars The current number of cars in the train
	 */
	public int getNumOfCars()
	{
		return m_currentNumOfCars;
	}
	
	/**
	 * Setter for m_maxCars
	 * @param numCars The max number of cars the train can hold
	 */
	public void setNumOfCars(int numCars)
	{
		if (numCars < 0)
		{
			System.out.println("Error: Number of cars negative, set to 0 !");
			m_currentNumOfCars = 0;
		}
		else if (numCars > m_maxCars)
		{
			System.out.println("Error: Number of cars greater than max num of cars, set to max num of cars!");
			m_currentNumOfCars = m_maxCars;
		}
		else
			m_currentNumOfCars = numCars;
	}
	
	/**
	 * The getter for m_location
	 * @return m_location The current location of the train
	 */
	public String getLocation()
	{
		return m_location;
	}
	
	/**
	 * The setter for m_location
	 * @param newLocation The new location of train
	 */
	public void setLocation(String newLocation)
	{
		m_location = newLocation;
	}
	
	/**
	 * The getter for m_inStation
	 * @return m_inStation True if train in station, false if train traveling between stations
	 */
	public boolean getInStation()
	{
		return m_inStation;
	}
	
	/**
	 * The setter for m_inStation
	 * @param inStation True if train in station, false if train traveling between stations
	 */
	public void setInStation(boolean inStation)
	{
		m_inStation = inStation;
	}
	
	/**
	 * Getter for m_origin
	 * @return m_orgin Current location if train in station, previous location if train traveling 
	 */
	public String getOrigin()
	{
		return m_origin;
	}
	
	/**
	 * The setter for m_origin
	 * @param newOrigin The station the train currently is in
	 */
	public void setOrigin(String newOrigin)
	{
		m_origin = newOrigin;
	}
	
	/**
	 * The getter for m_destination
	 * @return m_destination If train traveling the train's destination, if in station then current station 
	 */
	public String getDestination()
	{
		return m_destination;
	}
	
	/**
	 * The setter for m_destination
	 * @param newDestination The train's new destination
	 */
	public void setDestination(String newDestination)
	{
		m_destination = newDestination;
	}
	
	/**
	 * To check if the speed is a valid speed
	 * @param speed The desired speed
	 * @return True if train can travel that fast in its current location
	 */
	public boolean validSpeed(int speed)
	{
		if (!m_inStation)
			return speed <= m_maxSpeed && speed >= m_minSpeed && speed >= 0;
		else
			return speed == 0;
	}
	
	/**
	 * If the train can speed up by the given amount
	 * @param change The speed increase
	 * @return True if the train can travel by given speedup in its current location
	 */
	public boolean validSpeedIncrease(int change)
	{
		return validSpeed(m_currentSpeed + change);
	}
	
	/**
	 * If the train can slow down by the given amount
	 * @param change The speed decrease
	 * @return True if the speed is valid
	 */
	public boolean validSpeedDecrease(int change)
	{
		return validSpeed(m_currentSpeed - change);
	}
	
	/**
	 * Sets the train to be in a station
	 */
	public void arrive()
	{
		if (!m_inStation)
		{
			setInStation(true);
			m_currentSpeed = 0;
			setOrigin(m_destination);
			setLocation("Stopped in " + m_destination);
		}
		else
			System.out.println("Error: Train is already in a station!");
	}
	
	/**
	 * Sets the train to depart to the given destination
	 * @param newDestination The new destination for the train
	 */
	public void depart(String newDestination)
	{
		if (m_inStation)
		{
			setInStation(false);
			m_currentSpeed = m_minSpeed;
			setDestination(newDestination);
			setLocation("Traveling from " + m_origin + " to " + m_destination);
		}
		else
			System.out.println("Error: Train not in station, new destination not set!");
	}
	
	/**
	 * Has the train speed up by given amount, if possible
	 * @param mphIncrease The desired speed increase
	 */
	public void speedUp(int mphIncrease)
	{
		if (!m_inStation)
		{
			if (validSpeedIncrease(mphIncrease))
				setCurrentSpeed(m_currentSpeed + mphIncrease);
			else
				System.out.println("Error: Speed increase outside allowed bounds, speed not changed!");
		}
		else
			System.out.println("Train in station, cannot move!");
	}
	
	/**
	 * Has the train slow down by given amount, if possible
	 * @param mphDecrease The desired speed decrease
	 */
	public void slowDown(int mphDecrease)
	{
		if (!m_inStation)
		{
			if (validSpeedDecrease(mphDecrease))
				setCurrentSpeed(m_currentSpeed - mphDecrease);
			else
				System.out.println("Error: Speed decrease outside allowed bounds, speed not changed!");
		}
		else
			System.out.println("Train in station, cannot move!");
	}
	
	/**
	 * Adds a passenger car to the train with the given capacity, if possible
	 * @param capacity The capacity of the new passenger car
	 */
	public void addPassengerCar(int capacity)
	{
		if (m_inStation)
		{
			if (m_currentNumOfCars < m_maxCars)
			{
				m_cars.add(new PassengerCar(capacity));
				setNumOfCars(m_currentNumOfCars + 1);
			}
			else
				System.out.println("Error: Train full, passenger car not added!");
		}
		else
			System.out.println("Error: Train not in station, passenger car not added!");
	}
	
	/**
	 * Adds a freight car to the train with the given capacity, if possible
	 * @param capacity The capacity of the freight car
	 */
	public void addFreightCar(int capacity)
	{
		if (m_inStation)
		{
			if (m_currentNumOfCars < m_maxCars)
			{
				m_cars.add(new FreightCar(capacity));
				setNumOfCars(m_currentNumOfCars + 1);
			}
			else
				System.out.println("Error: Train full, freight car not added!");
		}
		else
			System.out.println("Error: Train not in station, freight car not added!");
	}
	
	/**
	 * Removes a car from the train if the car isn't empty and the car exists
	 * @param index The car to be removed
	 */
	public void removeCar(int index)
	{
		if (m_inStation)
		{
			if (index < 0)
				System.out.println("Error: Remove car index negative, no car removed!");
			else if (index >= m_currentNumOfCars)
				System.out.println("Error: Remove car index too large for current train size, no car removed!");
			else
			{
				if (m_cars.get(index).getCurrentSize() <= 0)
				{
					m_cars.remove(index);
					setNumOfCars(m_currentNumOfCars - 1);
				}
				else
					System.out.println("Error: Car " + index + " not empty, car not removed!");
			}
		}
		else
			System.out.println("Error: Train not in a station, car not removed!");
	}
	
	/**
	 * Loads a given person onto the desired car if possible
	 * @param carIndex The index of the car the person is to be loaded on
	 * @param governmentID The ID of the person to be loaded
	 * @param name The name of the person to be loaded
	 * @param age The age of the person to be loaded
	 */
	public void loadPerson(int carIndex, String governmentID, String name, int age)
	{
		if (m_inStation)
		{
			if (carIndex < 0)
				System.out.println("Error: Car index negative, person not loaded!");
			else if (carIndex >= m_currentNumOfCars)
				System.out.println("Error: Car index too large for current train size, person not loaded!");
			else if (m_cars.get(carIndex).type() != 0)
				System.out.println("Error: Cannot insert person into freight car, person not loaded!");
			else if (!m_cars.get(carIndex).canIncrementCurrentSizeBy1())
				System.out.println("Error: Passenger car full, person not loaded!");
			else
			{
				boolean duplicate = false;
				for (int i = 0; i < m_currentNumOfCars; i++)
					if (m_cars.get(i).type() == 0)
						if (m_cars.get(i).hasID(governmentID))
							duplicate = true;
				
				if (duplicate)
					System.out.println("Error: Person with same ID already loaded onto train, person not loaded!");
				else
					m_cars.get(carIndex).addPerson(governmentID, name, age);
			}
		}
		else
			System.out.println("Error: Train not in station, person not loaded!");
	}
	
	/**
	 * Loads a given cargo onto the desired car if possible
	 * @param carIndex The index of the car for the cargo to be loaded on
	 * @param cargoID The ID of the cargo to be loaded
	 * @param weight The weight of the cargo to be loaded
	 * @param height The height of the cargo to be loaded
	 */
	public void loadCargo(int carIndex, String cargoID, int weight, int height)
	{
		if (m_inStation)
		{
			if (carIndex < 0)
				System.out.println("Error: Car index negative, cargo not loaded!");
			else if (carIndex >= m_currentNumOfCars)
				System.out.println("Error: Car index too large for current train size, cargo not loaded!");
			else if (m_cars.get(carIndex).type() != 1)
				System.out.println("Error: Cannot insert cargo into passenger car, cargo not loaded!");
			else if (!m_cars.get(carIndex).canIncrementCurrentSizeBy1())
				System.out.println("Error: Passenger car full, person not loaded!");
			else
			{
				boolean duplicate = false;
				for (int i = 0; i < m_currentNumOfCars; i++)
					if (m_cars.get(i).type() == 1)
						if (m_cars.get(i).hasID(cargoID))
							duplicate = true;
				
				if (duplicate)
					System.out.println("Error: Cargo with same ID already loaded onto train, cargo not loaded!");
				else
					m_cars.get(carIndex).addCargo(cargoID, weight, height);
			}
		}
		else
			System.out.println("Error: Train not in station, cargo not loaded!");
	}
	
	/**
	 * Tries to remove the desired item from the desired car
	 * @param carIndex
	 * @param itemID
	 */
	public void removeItem(int carIndex, String itemID)
	{
		if (m_inStation)
		{
			if (carIndex < 0)
				System.out.println("Error: Car index negative, person/cargo not removed!");
			else if (carIndex >= m_currentNumOfCars)
				System.out.println("Error: Car index too large for current train size, person/cargo not removed!");
			else if (!m_cars.get(carIndex).canDecrementCurrentSizeBy1())
				System.out.println("Error: Car empty, no person/cargo to be removed!");
			else
				m_cars.get(carIndex).removeItem(itemID);
		}
		else
			System.out.println("Error: Train not in station, person/cargo not removed!");
	}
	
	/**
	 * Returns a string of the train's info plus info of each car of the train
	 */
	public String toString()
	{
		String output = "";
		output += "Train Status\n------------\n\tCurrentSpeed: " + m_currentSpeed + "\n\tMinimum Speed: " + m_minSpeed +
				"\n\tMaximum Speed: " + m_maxSpeed + "\n\tCurrentPosition: " + m_location + "\n\tCurrent Number of Boxcars: " +
				m_currentNumOfCars + "\n\tMaximum Number of Boxcars: " + m_maxCars + "\n";
		
		for (int i = 0; i < m_currentNumOfCars; i++)
		{
			output += "\tBoxcar: " + i + "\n\t-----------\n\tContents:\n";
			output += m_cars.get(i).toString();
		}
		
		return output;
	}
}