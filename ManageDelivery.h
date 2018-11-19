#ifndef MANAGEDELIVERY_H
#define MANAGEDELIVERY_H

#include "ReadyDelivery.h"

class ManageDelivery {
 public:
  // Constructor for managing the deliveries.
  // Once the data has been imported and split used to manage all additonal functions
  // One vector for trucks
  // One vector for deliveries
  // One vector for items
  ManageDelivery(vector< Truck <Item, MAX_CAPACITY> > truck, vector< Delivery > delivery, vector< Item > item);
  
  //Name: StartDelivery
  //Precondition: Requires truck, delivery, and items
  //Postcondition: Loads items into a truck
  //Additional information: All deliveries must be complete - you cannot split a 
  //single delivery into two trucks. A single truck can complete more than
  //one delivery at a time.
  void StartDelivery();

  //Name: DeliverItem
  //Precondition: Requires that the truck has been loaded with deliveries and items
  //Postcondition: Outputs the delivery information including truck name and items
  void DeliverItem(int j);

  //Name: DisplayItemLeft
  //Precondition: Requires that all trucks have been loaded
  //Postcondition: Outputs (cout) each item not loaded into a delivery
  void DisplayItemLeft();

 private:
  vector< Truck<Item, MAX_CAPACITY> > m_truck; //Vector of all templated trucks
  vector< Delivery > m_delivery; //Vector of all deliveries
  vector< Item > m_item; //Vector of all items
};

#endif
