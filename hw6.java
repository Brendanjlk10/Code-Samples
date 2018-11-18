/**
 * File: hw6.java
 * Project: CMSC 331 Homework 6 Fall 2017
 * Author: Brendan Jones
 * Date: 12-3-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The main file for hw6. Reads from the input file and runs the program. Has-a Train.
 */

import java.util.*;
import java.io.*;

public class hw6
{
	private static Train m_theTrain;//The train
	
	/**
	 * The main method
	 * @param args
	 */
	public static void main(String[] args)
	{
		//Initial values for the train in their respective variables, can be changed and program still work
		String startCity = "New York";
		int initialMinSpeed = 10;
		int initialMaxSpeed = 50;
		int initialMaxNumOfCars = 3;
		
		m_theTrain = new Train(startCity, initialMinSpeed, initialMaxSpeed, initialMaxNumOfCars);
		
		readFile();//Reads in and executes the commands 
		
		return;
	}
	
	/**
	 * Reads in the command from the file and executes them as possbile
	 */
	public static void readFile()
	{
		Scanner input;
		try
		{
			input = new Scanner( new FileInputStream("train_commands.txt"));//Create scanner from input file
			
			while(input.hasNextLine())//While not end
			{
				String command = input.nextLine();//The new command
				
				if (command.equalsIgnoreCase("PRINT"))//Prints out the data of the train
				{
					System.out.println("PRINT");
					System.out.println(m_theTrain.toString());
				}
				else if (command.equalsIgnoreCase("ARRIVE"))//Tells the train to arrive at its destination
				{
					System.out.println("ARRIVE");
					m_theTrain.arrive();
				}
				else if (command.equalsIgnoreCase("DEPART"))//Tells the train to depart to given destination
				{
					if (input.hasNextLine())
					{
						String newCity = input.nextLine();
						System.out.println("DEPART to " + newCity);
						m_theTrain.depart(newCity);
					}
					else
						System.out.println("Error: DEPART expected city, got end of file!");
				}
				else if (command.equalsIgnoreCase("SPEEDUP"))//Tells the train to speed up by given amount
				{
					if (input.hasNextLine())
					{
						if (input.hasNextInt())
						{
							int increase = Integer.parseInt(input.nextLine());
							System.out.println("SPEEDUP " + increase);
							m_theTrain.speedUp(increase);
						}
						else
						{
							input.nextLine();
							System.out.println("Error: SPEEDUP expected int, got string!");
						}
					}
					else
						System.out.println("Error: SPEEDUP expected integer, got end of file!");
				}
				else if (command.equalsIgnoreCase("SLOWDOWN"))//Tells the train to slowdown by given amount
				{
					if (input.hasNextLine())
					{
						if (input.hasNextInt())
						{
							int decrease = Integer.parseInt(input.nextLine());
							System.out.println("SPEEDUP " + decrease);
							m_theTrain.slowDown(decrease);
						}
						else
						{
							input.nextLine();
							System.out.println("Error: SLOWDOWN expected integer, got string!");
						}
					}
					else
						System.out.println("Error: SLOWDOWN expected integer, got end of file!");
				}
				else if (command.equalsIgnoreCase("ADDCAR"))//Tells train to add car of given type & capacity to end of train
				{
					if (input.hasNextLine())
					{
						String carType = input.nextLine();
						
						if (carType.equalsIgnoreCase("PERSON"))
						{
							if (input.hasNextLine())
							{
								if (input.hasNextInt())
								{
									int carsCapacity = Integer.parseInt(input.nextLine());
									System.out.println("ADDCAR Passenger Car " + carsCapacity);
									m_theTrain.addPassengerCar(carsCapacity);
								}
								else
								{
									input.nextLine();
									System.out.println("Error: ADDCAR expected int for second argument, got string!");
								}
							}
							else
								System.out.println("Error: ADDCAR expected string and int, got end of file for second!");
						}
						else if (carType.equalsIgnoreCase("CARGO"))
						{
							if (input.hasNextLine())
							{
								if (input.hasNextInt())
								{
									int carsCapacity = Integer.parseInt(input.nextLine());
									System.out.println("ADDCAR Freight Car " + carsCapacity);
									m_theTrain.addFreightCar(carsCapacity);
								}
								else
								{
									input.nextLine();
									System.out.println("Error: ADDCAR expected int for second argument, got string!");
								}
							}
							else
								System.out.println("Error: ADDCAR expected string and int, got end of file for second!");
						}
						else
						{
							input.nextLine();
							System.out.println("Error: ADDCAR car type unknown type, car not added!");
						}
					}
					else
						System.out.println("Error: ADDCAR expected string and int, got end of file for first!");
				}
				else if (command.equalsIgnoreCase("REMOVECAR"))//Tells train to remove given car, if given car not empty
				{
					if (input.hasNextLine())
					{
						if (input.hasNextInt())
						{
							int index = Integer.parseInt(input.nextLine());
							System.out.println("REMOVECAR " + index);
							m_theTrain.removeCar(index);
						}
						else
						{
							input.nextLine();
							System.out.println("Error: REMOVECAR expected int, got string!");
						}
					}
					else
						System.out.println("Error: REMOVECAR expected int, got end of file!");
				}
				else if (command.equalsIgnoreCase("QUIT"))//Ends the program
				{
					System.out.println("QUIT");
					input.close();
					return;
				}
				else if (command.equalsIgnoreCase("LOAD"))//Loads given person or cargo onto train with its given info, if possible
				{
					if (input.hasNextLine())
					{
						String itemType = input.nextLine();
						
						if (itemType.equalsIgnoreCase("PERSON"))
						{
							if (input.hasNextLine())
							{
								if (input.hasNextInt())
								{
									int carID = Integer.parseInt(input.nextLine());
									
									if (input.hasNextLine())
									{
										String governmentID = input.nextLine();
										
										if (input.hasNextLine())
										{
											String name = input.nextLine();
											
											if (input.hasNextLine())
											{
												if (input.hasNextInt())
												{
													int age = Integer.parseInt(input.nextLine());
													System.out.println("LOAD Person " + carID + " " + governmentID + " " + name + " " + age);
													m_theTrain.loadPerson(carID, governmentID, name, age);
												}
												else
												{
													System.out.println("Error: LOAD expected int for fifth line, got string!");
													input.nextLine();
												}
											}
											else
												System.out.println("Error: LOAD expected 5 lines, got end of file for fifth!");
										}
										else
											System.out.println("Error: LOAD expected 5 lines, got end of file for fourth!");
									}
									else
										System.out.println("Error: LOAD expected 5 lines, got end of file for third!");
								}
								else
								{
									System.out.println("Error: LOAD expected int for second line, got string!");
									if (input.hasNextLine())
										input.nextLine();
									if (input.hasNextLine())
										input.nextLine();
									if (input.hasNextLine())
										input.nextLine();
								}
							}
							else
								System.out.println("Error: LOAD expected 5 lines, got end of file for second!");
						}
						else if (itemType.equalsIgnoreCase("CARGO"))
						{

							if (input.hasNextLine())
							{
								if (input.hasNextInt())
								{
									int carID = Integer.parseInt(input.nextLine());
									
									if (input.hasNextLine())
									{
										String cargoID = input.nextLine();
										
										if (input.hasNextLine())
										{
											if (input.hasNextInt())
											{
												int weight = Integer.parseInt(input.nextLine());
												
												if (input.hasNextLine())
												{
													if (input.hasNextInt())
													{
														int height = Integer.parseInt(input.nextLine());
														
														System.out.println("LOAD Cargo " + carID + " " + cargoID + " " + weight + " " + height);
														m_theTrain.loadCargo(carID, cargoID, weight, height);
													}
													else
													{
														System.out.println("Error: LOAD expected int for fifth line, got string!");
														input.nextLine();
													}
												}
												else
													System.out.println("Error: LOAD expected 5 lines, got end of file for fifth!");
											}
											else
											{
												System.out.println("Error: LOAD expected int for fourth line, got string!");
												input.nextLine();
												if (input.hasNextLine())
													input.nextLine();
											}
										}
										else
											System.out.println("Error: LOAD expected 5 lines, got end of file for fourth!");
									}
									else
										System.out.println("Error: LOAD expected 5 lines, got end of file for third!");
								}
								else
								{
									System.out.println("Error: LOAD expected int for second line, got string!");
									if (input.hasNextLine())
										input.nextLine();
									if (input.hasNextLine())
										input.nextLine();
									if (input.hasNextLine())
										input.nextLine();
								}
							}
							else
								System.out.println("Error: LOAD expected 5 lines, got end of file for second!");
						}
						else
						{
							System.out.println("Error: LOAD item type unknown!");
							if (input.hasNextLine())
								input.nextLine();
							if (input.hasNextLine())
								input.nextLine();
							if (input.hasNextLine())
								input.nextLine();
							if (input.hasNextLine())
								input.nextLine();
						}
					}
					else
						System.out.println("Error: LOAD expected 5 lines, got end of file for first!");
				}
				else if (command.equalsIgnoreCase("UNLOAD"))//Unloads given person or cargo, if possible
				{
					if (input.hasNextLine())
					{
						if (input.hasNextInt())
						{
							int carID = Integer.parseInt(input.nextLine());
							
							if (input.hasNextLine())
							{
								String itemID = input.nextLine();
								
								System.out.println("UNLOAD " + carID + " " + itemID);
								
								m_theTrain.removeItem(carID, itemID);
							}
							else
								System.out.println("Error: UNLOAD expected 2 lines, got end of file for second!");
						}
						else
						{
							System.out.println("Error: UNLOAD expected int first line, got string!");
							input.nextLine();
							if (input.hasNextLine())
								input.nextLine();
						}
					}
					else
						System.out.println("Error: UNLOAD expected 2 lines, got end of file for first!");
				}
				else
					System.out.println("Command--" + command + "--not recognized!");
			}
			
			input.close();
		} catch (FileNotFoundException e)
		{
			System.out.println("Error: File not found!");
			e.printStackTrace();
		}
	}
}