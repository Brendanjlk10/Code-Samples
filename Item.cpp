/*
** File: Item.cpp
** Project: CMSC 202 Project 5 Spring 2017
** Author: Brendan Jones
** Date: 5-5-17
** Lecture Section: 11
** Lab Section: 22
** Email: bjones10@umbc.edu
**
** This file stores the info for each item.
*/

#include "Item.h"

//Null constructor for Item. Intitializes m_name and m_weight
Item::Item()
{
	m_name = "";
	m_weight = 0.0;
}

//String, float constructor for Item. Initializes m_name an m_weight
Item::Item(string iName, float iWeight)
{
	m_name = iName;
	m_weight = iWeight;
}

//Getter for m_name
string Item::GetName() const
{
	return m_name;
}

//Getter for m_weight
float Item::GetWeight() const
{
	return m_weight;
}
