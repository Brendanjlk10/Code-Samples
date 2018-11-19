#ifndef READYDELIVERY_H
#define READYDELIVERY_H

#include <iostream>
#include <string>
#include <fstream>
#include <vector>

#include "Truck.h"
#include "Item.h"
#include "Delivery.h"

using namespace std;
const int MAX_CAPACITY = 3001; //Expect that the Tqueue is limited to 200 items.

class ReadyDelivery{
 public:
  //Name: ReadyDelivery() and ReadyDelivery(string, string)
  //Precondition: Requires 3 files: a truck file, a deliveries file and an item file
  //Postcondition: Populates three vectors
  ReadyDelivery();
  ReadyDelivery(string truckFile, string deliveryFile, string itemFile);

  //Name: LoadTruck
  //Precondition: Requires a truck file
  //Postcondition: Builds a vector of delivery trucks
  //Trucks: Holds items
  void LoadTruck();

  //Name: LoadDelivery
  //Precondition: Requires a delivery file
  //Postcondition: Builds a vector of deliveries
  void LoadDelivery();

  //Name: LoadItem
  //Precondition: Requires an item file
  //Postcondition: Builds a vector of items
  void LoadItem();

  //Name: GetTruck
  //Precondition: Requires that a truck has been built
  //Postcondition: Returns a vector of all trucks
  vector< Truck<Item, MAX_CAPACITY> >& GetTruck();

  //Name: GetDelivery
  //Precondition: Requires that a delivery has been built
  //Postcondition: Returns a vector of all deliveries
  vector<Delivery> GetDelivery();

  //Name: GetItem
  //Precondition: Requires that an item vectors has been built
  //Postcondition: Returns a vector of all items
  vector< Item > GetItem();

 private:
  string m_truckFile; //Name of the truck file
  string m_deliveryFile; //Name of the delivery file
  string m_itemFile; //Name of the item file
  vector< Truck<Item, MAX_CAPACITY> > m_truck; //Vector of templated trucks
  vector< Delivery> m_delivery; //Vector of deliveries
  vector< Item> m_item; //Vector of items
};

#endif
