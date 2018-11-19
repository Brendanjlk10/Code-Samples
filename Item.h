#ifndef ITEM_H
#define ITEM_H

#include <string>
#include <sstream>
#include <iomanip>
#include <iostream>//TODO: Delete

using namespace std;

class Item
{
public:
  //Name: Item() and Item(string, float) - Default and Overloaded Constructor
  //Precondition: None
  //Postcondition: Creates an item
  Item();
  Item(string iName, float iWeight);

  //Name: GetName/GetWeight
  //Precondition: None
  //Postcondition: Returns name or weight
  string GetName() const;
  float GetWeight() const;

private:
  string m_name; //Name of item - not unique
  float m_weight; //Weight of item
};

#endif
