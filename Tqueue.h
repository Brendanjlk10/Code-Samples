/*
** File: Tqueue.h
** Project: CMSC 202 Project 5 Spring 2017
** Author: Brendan Jones
** Date: 5-5-17
** Lecture Section: 11
** Lab Section: 22
** Email: bjones10@umbc.edu
**
** This file
*/

#ifndef TQUEUE_H
#define TQUEUE_H

#include <iostream>
#include <cstdlib>
using namespace std;

template <class T, int N>
class Tqueue {
public:
  //Name: Tqueue - Default Constructor
  //Precondition: None (Must be templated)
  //Postcondition: Creates a queue using dynamic array
  Tqueue(); //Default Constructor
  //Name: Copy Constructor - Not used but required for project 5
  //Precondition: Existing Tqueue
  //Postcondition: Copies an existing Tqueue
  Tqueue( const Tqueue<T,N>& x ); //Copy Constructor
  //Name: Destructor
  //Precondition: Existing Tqueue
  //Postcondition: Destructs existing Tqueue
  ~Tqueue(); //Destructor
  //Name: enqueue
  //Precondition: Existing Tqueue
  //Postcondition: Adds item to back of queue
  void enqueue(T data); //Adds item to queue (to back)
  //Name: dequeue
  //Precondition: Existing Tqueue
  //Postcondition: Removes item from front of queue
  void dequeue(T &); //Removes item from queue (from front)
  //Name: queueFront
  //Precondition: Existing Tqueue
  //Postcondition: Retrieve front (does not remove it)
  void queueFront(T &);    // Retrieve front (does not remove it)
  //Name: isEmpty
  //Precondition: Existing Tqueue
  //Postcondition: Returns 1 if queue is empty else 0
  int isEmpty(); //Returns 1 if queue is empty else 0
  //Name: isFull
  //Precondition: Existing Tqueue
  //Postcondition: Returns 1 if queue is full else 0
  int isFull(); //Returns 1 if queue is full else 0
  //Name: Overloaded assignment operator - Not used but required for project 5
  //Precondition: Existing Tqueue
  //Postcondition: Sets one Tqueue to same as a second Tqueue using =
  Tqueue<T,N>& operator=( Tqueue<T,N> y); //Overloaded assignment operator for queue
private:
  T* m_data; //Data of the queue (Must be dynamically allocated array)
  int m_front; //Front of the queue
  int m_back; //Back of the queue
};

//**** Add class definition below ****

//Null constructor for Tqueue
template<class T, int N>
inline Tqueue<T, N>::Tqueue()
{
	m_data = new T[3001];//Creates a dymanic T array for m_data

	m_front = m_back = 0;
}

//Overleaded for Tqueue. Makes this Tqueue same as other tqueue
template<class T, int N>
inline Tqueue<T, N>::Tqueue(const Tqueue<T, N>& x)
{
	m_data = new T[3001];
	m_data = x.m_data;
	m_front = x.m_front;
	m_back = x.m_back;
}

//Destructor for Tqueue
template<class T, int N>
inline Tqueue<T, N>::~Tqueue()
{
	if (isEmpty() == 0)
	{
		T object;

		while (isEmpty() != 1)
			dequeue(object);
	}
	//delete[] m_data;
}

//Adds the passed data to the queue
template<class T, int N>
inline void Tqueue<T, N>::enqueue(T data)
{
	if (isEmpty() == 1)//If back of m_data is empty, sets that spot in the array to data
	{
		m_front = m_back = 0;
		m_data[0] = data;
	}
	else if (isFull() == 1)
		cerr << "m_data is full!\n";
	else if (m_back < 3001 - 1)//If not at last element of array, sets next spot in array to data and increments m_back
		m_data[++m_back] = data;
	else//If at last element of array, sets first spot 
	{
		m_back = 0;
		m_data[m_back] = data;
	}
}

//Pops off the first object of m_data
template<class T, int N>
inline void Tqueue<T, N>::dequeue(T &object)
{
	if (isEmpty() == 1)
		cerr << "No elements in queue to dequeue!\n";
	else
	{
		object = m_data[m_front];
		m_data[m_front] = T();

		if (isEmpty() == 1)//If m_data is empty sets m_front and m_back to 0
			m_front = m_back = 0;
		else if (m_front < 3001 - 1)//If m_data not at back of array, increments m_front
			m_front++;
		else//If m_front at back of array, sets m_front to 0
			m_front = 0;
	}
}

//Returns but doesn't pop off first element of queue
template<class T, int N>
inline void Tqueue<T, N>::queueFront(T &object)
{
	if (isEmpty() == 1)
		cerr << "No elements in queue to dequeue!\n";
	else
		object = m_data[m_front];
}

//Determines if m_data is empty
template<class T, int N>
inline int Tqueue<T, N>::isEmpty()
{
	for (unsigned int i = 0; i < 3001; i++)//Goes through entire m_data. If it finds element which isn't null, returns 0 for false. If not, returns 1 for true
		if (m_data[i].GetName().length() > 0)
			return 0;
	return 1;
}

//Determines if m_data is full
template<class T, int N>
inline int Tqueue<T, N>::isFull()
{
	for (unsigned int i = 0; i < 3001; i++)//Goes through entire m_data. If it finds element which is null, returns 0 for false. If not, returns 1 for true
		if (m_data[i].GetName() == "")
			return 0;
	return 1;
}

//Overloaded = operator
template<class T, int N>
inline Tqueue<T, N>& Tqueue<T, N>::operator=(Tqueue<T, N> y)
{
	for (unsigned int i = 0; i < 3001; i++)
		y.m_data[i] = m_data[i];
	y.m_front = m_front;
	y.m_back = m_back;
	return y;
}
#endif