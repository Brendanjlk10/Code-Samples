/*
** File: ManageDelivery.cpp
** Project: CMSC 202 Project 5 Spring 2017
** Author: Brendan Jones
** Date: 5-5-17
** Lecture Section: 11
** Lab Section: 22
** Email: bjones10@umbc.edu
**
** This file manages the loading of items into trucks and orders
*/

#include "ManageDelivery.h"

//The three vector default constructor for ManageDelivery. Initializes m_truck, m_delivery, and m_item and driver for the class
ManageDelivery::ManageDelivery(vector<Truck<Item, MAX_CAPACITY> > truck, vector<Delivery> delivery, vector<Item> item)
{
	m_truck = truck;
	m_delivery = delivery;
	m_item = item;
	
	StartDelivery();//Calls StartDelivery to manage the orders
	DisplayItemLeft();//Displays leftover item(s)

	for (unsigned int i = 0; i < m_truck.size(); i++)
		m_truck.at(i).~Truck();//Delete m_truck

}

//Does all of the deliveries
void ManageDelivery::StartDelivery()
{
	unsigned int currentItem/*The current item*/, deliveryStartOn = 0;//The order started on for the curent delivery
	unsigned int deliveryFinishOn = 0/*The order ended on for the current delivery*/, currentTruck = 0/*The current truck*/, totalItemsOrdered = 0;//Total items ordered by everyone
	const int LOADING_TIME = 10;//Time it takes to load truck
	bool nextOrder = false;//Move on to next order?
	float truckCurrentWeight = 0.0;//The truck's current weight
	vector<int> itemsOrdered/*Unfilled items ordered by each person*/, itemsPerOrderInTruck(1, 0);//Items per order in truck

	for (unsigned int i = 0; i < m_delivery.size(); i++)//Gets the total # of items ordered
		totalItemsOrdered += m_delivery.at(i).GetNumItem();

	for (unsigned int i = 0; i < m_delivery.size(); i++)
		itemsOrdered.push_back(m_delivery.at(i).GetNumItem());

	for (currentItem = 0; currentItem < totalItemsOrdered && currentItem < m_item.size(); currentItem++)//Goes through each item of m_item
	{
		if (truckCurrentWeight + m_item.at(currentItem).GetWeight() <= m_truck.at(currentTruck).GetCapacity())//Checks to see if the current truck has room for the next item
		{
			cout << m_item.at(currentItem).GetName() << " loaded into Truck" << currentTruck + 1 << endl;//Outputs the info on the current truck

			m_truck.at(currentTruck).AddItem(m_item.at(currentItem));//Adds current item to current truck

			if (nextOrder)//If moving on to next order
			{
				deliveryFinishOn++;
				nextOrder = false;
				itemsPerOrderInTruck.push_back(0);
			}

			itemsPerOrderInTruck.at(itemsPerOrderInTruck.size() - 1)++;//Increments current last order size by 1

			for (unsigned int i = 0; i < m_delivery.size(); i++)//Decrements the order size of order an item was taken from
			{
				if (itemsOrdered.at(i) > 0)
				{
					itemsOrdered.at(i)--;

					if (itemsOrdered.at(i) == 0)
						nextOrder = true;
					break;
				}
			}

			truckCurrentWeight += m_item.at(currentItem).GetWeight();//Increases the truck's current weight
		}
		else//If the truck is full or all orders have been filled
		{
			cout << "**Truck Name: Truck" << currentTruck + 1 << "**\n";

			for (unsigned int i = 0; i < deliveryFinishOn - deliveryStartOn + 1; i++)//Spits out the info for each delivery the truck is fulfilling
			{
				cout << "***********Delivery " << i + 1 << "*************\nDelivery Time : ";

				if (i == 0)
					cout << LOADING_TIME + m_delivery.at(deliveryStartOn).GetRTMinute();//Adds loading time to first order
				else
					cout << m_delivery.at(deliveryStartOn + i).GetRTMinute();//Doesn't add loading time to other orders

				cout << "\nDelivery for: " << m_delivery.at(deliveryStartOn + i).GetName() << "\nDelivered: " << itemsPerOrderInTruck.at(i) << "\n";
			}

			if (currentTruck < m_truck.size() - 1)//Sets currentTruck to the next truck
				currentTruck++;
			else//If only one truck or last truck is current truck, sets currentTruck to 0
				currentTruck = 0;
			
			//Resets truckCurrentWeight and itemsPerOrderInTruck
			truckCurrentWeight = 0;
			itemsPerOrderInTruck.clear();
			itemsPerOrderInTruck.resize(1, 0);

			DeliverItem(currentTruck);//Clear's the truck's current delivery

			//If moving on to next order
			if (nextOrder)
			{
				deliveryFinishOn++;
				deliveryStartOn = deliveryFinishOn;
				nextOrder = false;
			}
			else//If not moving on to next order
				deliveryStartOn = deliveryFinishOn;

			cout << "*****Loading Truck (Truck" << currentTruck + 1 << ")*****\n";//Loading new truck

			currentItem--;//Cancels out the for loop's currentItem++ to keep at the current item
		}
	}

	//Spits out info of last delivery
	cout << "**Truck Name: Truck" << currentTruck + 1 << "**\n";
	for (unsigned int i = 0; i < deliveryFinishOn - deliveryStartOn + 1; i++)//Spits out the info for each delivery the truck is fulfilling
	{
		cout << "***********Delivery " << i + 1 << "*************\nDelivery Time : ";

		if (i == 0)
			cout << LOADING_TIME + m_delivery.at(deliveryStartOn).GetRTMinute();//Adds loading time to first order
		else
			cout << m_delivery.at(deliveryStartOn + i).GetRTMinute();//Doesn't add loading time to other orders

		cout << "\nDelivery for: " << m_delivery.at(deliveryStartOn + i).GetName() << "\nDelivered: " << itemsPerOrderInTruck.at(i) << "\n";
	}
}

//Calls complete delivery for the truck
void ManageDelivery::DeliverItem(int j)
{
	m_truck.at(j).CompleteDelivery();
}

//Dislplays the item(s) left
void ManageDelivery::DisplayItemLeft()
{
	unsigned int totalItemsOrdered = 0;

	cout << "*****Items Left After Deliveries*****\n";

	for (unsigned int i = 0; i < m_delivery.size(); i++)//Gets the total # of items ordered
		totalItemsOrdered += m_delivery.at(i).GetNumItem();

	if (totalItemsOrdered >= m_item.size())//If no items left, says so
		cout << "No items left.\n";
	else
		for (int i = totalItemsOrdered - 1, count = 1; i < m_item.size(); i++, count++)//Prints out the info of each unordered item
			cout << "Item " << count << " - Name: " << m_item.at(i).GetName() << " - Weight: " << m_item.at(i).GetWeight() << endl;
}