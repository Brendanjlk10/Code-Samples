/*
** File: Delivery.cpp
** Project: CMSC 202 Project 5 Spring 2017
** Author: Brendan Jones
** Date: 5-5-17
** Lecture Section: 11
** Lab Section: 22
** Email: bjones10@umbc.edu
**
** This file stores the info for each delivery.
*/

#include "Delivery.h"

//Null constructor for Delivery. Instantiates m_name, m_numItem, and m_rtMinute
Delivery::Delivery()
{
	m_name = "";
	m_numItem = m_rtMinute = 0;
}

//String, int, int constructor for Delivery. Instantiates m_name, m_numItem, and m_rtMinute
Delivery::Delivery(string name, int numItem, int rtMinute)
{
	m_name = name;
	m_numItem = numItem;
	m_rtMinute = rtMinute;
}

//Getter for m_name
string Delivery::GetName() const
{
	return m_name;
}

//Getter for m_numItem
int Delivery::GetNumItem() const
{
	return m_numItem;
}

//Getter for m_rtMinute
int Delivery::GetRTMinute() const
{
	return m_rtMinute;
}
