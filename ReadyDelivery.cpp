/*
** File: ReadyDelivery.cpp
** Project: CMSC 202 Project 5 Spring 2017
** Author: Brendan Jones
** Date: 5-5-17
** Lecture Section: 11
** Lab Section: 22
** Email: bjones10@umbc.edu
**
** This file loads in the files and adds them to their corresponding vectors.
*/

#include "ReadyDelivery.h"

//NULL Constructor for ReadyDelivery
ReadyDelivery::ReadyDelivery()
{
	m_truckFile = m_deliveryFile = m_itemFile = "";
	
	cout << "Trucks loaded: " << m_truck.size() << "\nDeliveries Loaded: " << m_delivery.size() << "\nItems Loaded: " << m_item.size() << endl << endl;
}

//The string, string, string constructor for ReadyDelivery. Stores file names and calls the three load methods.
ReadyDelivery::ReadyDelivery(string truckFile, string deliveryFile, string itemFile)
{
	//Stores the three file names
	m_truckFile = truckFile;
	m_deliveryFile = deliveryFile;
	m_itemFile = itemFile;
	
	LoadItem();//Fills the m_item vector
	LoadDelivery();//Fills the m_delivery vector
	LoadTruck();//Fills the m_truck vector

	cout << "Trucks loaded: " << m_truck.size() << "\nDeliveries Loaded: " << m_delivery.size() << "\nItems Loaded: " << m_item.size() << endl << endl;//Couts the # of trucks, deliveries, and items loaded
}

//Reads in the trucks and loads them onto m_truck
void ReadyDelivery::LoadTruck()
{
	string name;//The truck's name
	int capacity;//The truck's capacity
	ifstream inputStream;//The input stream for the file

	inputStream.open(m_truckFile.c_str());//Opens the file

	while (true)//Reads in and adds each truck. Exits when end of file
	{
		inputStream >> name;//Reads in the item's type/name

		if (inputStream.eof())//If end of file, exits while loop
			break;

		inputStream >> capacity;//Reads in the truck's weight capacity (in lbs.)
		if (inputStream.peek() == '\n')
			inputStream.ignore();

		m_truck.push_back(Truck<Item, MAX_CAPACITY> (name, capacity));//Adds Truck item to m_truck
	}
	inputStream.close();//Closes the input stream
}

//Reads in and loads the orders into m_delivery
void ReadyDelivery::LoadDelivery()
{
	string name;//Customer's name
	int numItems/*Number of items the customer ordered*/, roundTripMinutes;//Round trip time (in min) of the delivery
	ifstream inputStream;//The input stream for the file
	
	inputStream.open(m_deliveryFile.c_str());//Opens the file

	while (true)//Reads in and adds each order. Exits when end of while
	{
		inputStream >> name;//Reads in the customer's name

		if (inputStream.eof())//
			break;

		inputStream >> numItems;//Reads in the number of items the customer ordered
		inputStream >> roundTripMinutes;//Reads in the round trip time to and from the customer's house
		if (inputStream.peek() == '\n')
			inputStream.ignore();

		m_delivery.push_back(Delivery(name, numItems, roundTripMinutes));//Adds Delivery object to m_delivery
	}
}

void ReadyDelivery::LoadItem()
{
	string type;//The item's type/name
	float weight;//The item's weight (in lbs.)
	ifstream inputStream;//The input stream for the file

	inputStream.open(m_itemFile.c_str());//Opens the file

	while (true)//Reads in and adds each item. Exits when end of file
	{
		inputStream >> type;//Reads in the item's type/name

		if (inputStream.eof())//Exits loop when end of file
			break;
		
		inputStream >> weight;//Reads in the item's weight (in lbs.)
		if (inputStream.peek() == '\n')
			inputStream.ignore();
		
		m_item.push_back(Item(type, weight));//Adds Item object to m_item
	}
	inputStream.close();//Closes the input stream
}

//Getter for m_truck
vector<Truck <Item, MAX_CAPACITY> >& ReadyDelivery::GetTruck()
{
	return m_truck;
}

//Getter for m_delivery
vector<Delivery> ReadyDelivery::GetDelivery()
{
	return m_delivery;
}

//Getter for m_item
vector<Item> ReadyDelivery::GetItem()
{
	return m_item;
}
