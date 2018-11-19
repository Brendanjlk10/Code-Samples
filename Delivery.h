#ifndef DELIVERY_H
#define DELIVERY_H

#include <string>
#include <sstream>
#include <iomanip>
#include <iostream>//TODO: Delete

using namespace std;

class Delivery
{
public:
  //Name: Delivery and Delivery(name, numItem, rtMinute) - Constructors
  //Precondition: None
  //Postcondition: Creates a delivery
  Delivery();
  Delivery(string name, int numItem, int rtMinute);

  //Name: GetName, GetNumItem
  //Precondition: None
  //Postcondition: Returns various class values
  string GetName() const; //Returns m_name
  int GetNumItem() const; //Returns m_numItem
  int GetRTMinute() const; //Returns m_rtMinute - Travel time for delivery

private:
  string m_name; //Last name of customer
  int m_numItem; //Number of items in customer order
  int m_rtMinute; //Number of minutes to travel to customer house and deliver
};

#endif
