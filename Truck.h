/*There are a number of optional functions in Truck.h. 
This is because you may want to implement the management of the trucks in a variety of ways. 
Trucks are kind of complex so it is up to you as to how you want to implement them. 
If you don't use a function, just stub it out and include a quick comment.
 */

#ifndef TRUCK_H
#define TRUCK_H

#include "Item.h"
#include "Tqueue.h"
#include "Delivery.h"

#include <vector>
using namespace std;

template <class T, int N>
class Truck
{
 public:
  //Name: Truck(string, int) Overloaded constructor.
  //Precondition: Requires truck file has been loaded
  //Postcondition: Builds a new templated truck
  Truck(string inName, int capacity);

  //Name: Destructor
  //Precondition: Requires truck file has been loaded
  //Postcondition: Destroys everything in truck
  ~Truck();

  //Name: GetItem (optional)
  //Precondition: Requires that the truck's item queue has been populated
  //Postcondition: Templated accessor for this truck's cargo
  Tqueue<T,N> GetItem() const;

  //Name: GetItemAt (optional)
  //Precondition: Requires that the truck's item queue has been populated
  //Postcondition: Templated accessor for this truck's cargo at a specific location
  const T& GetItemAt(int index) const;

  //Name: AddItem (optional)
  //Precondition: Requires that the trucks have been loaded
  //Postcondition: Adds item into this truck
  void AddItem(T& inputObject);

  //Name: DeliverItemFromTruck (optional)
  //Precondition: Requires that the trucks have been loaded
  //Postcondition: Delivers item from this truck to customer
  void DeliverItemFromTruck();  

  //Name: AddDelivery (optional)
  //Precondition: Requires that all deliveries have been input and trucks
  //Postcondition: Used to add deliveries for specific trucks
  void AddDelivery(Delivery&);

  //Name: CompleteDelivery (optional)
  //Precondition: Requires that deliveries have been assigned to this truck
  //Postcondition: Removes current deliveries from this truck
  void CompleteDelivery();

  //Name: GetDeliveryAt (optional)
  //Precondition: Requires that this truck has at least 1 delivery assigned to it
  //Postcondition: Used to return a specific delivery
  Delivery& GetDeliveryAt(int index);

  //Name: GetDelivery (optional)
  //Precondition: Requires deliveries have been asssigned to this truck
  //Postcondition: Used to return the entire vector of deliveries
  vector<Delivery> GetDelivery() const;
 
  //Name: GetTime (optional)
  //Precondition: None
  //Postcondition: Used to return current time for a specific truck
  int GetTime(); 

  //Name: SetTime (optional)
  //Precondition: None
  //Postcondition: Used to set time for a specific truck
  void SetTime(int time);

  //Name: GetCapacity (optional)
  //Precondition: Requires that the trucks have been loaded
  //Postcondition: Used to access the capacity of a truck
  double GetCapacity() const;

  //Name: GetName (optional)
  //Precondition: Requires that the trucks have been loaded
  //Postcondition: Used to access the name of a truck
  string GetName() const;

private:
  string m_name;
  int m_capacity;
  int m_time;
  vector<Delivery> m_curDelivery;
  Tqueue<T,N> m_item;
};
//Implement the class definition below

//String, int constructor for Truck. Instantiates m_name and m_capacity and m_time
template<class T, int N>
inline Truck<T, N>::Truck(string inName, int capacity)
{
	m_name = inName;
	m_capacity = capacity;
	m_time = 0;
}

//Deleter for Truck
template<class T, int N>
inline Truck<T, N>::~Truck()
{
	m_item.~Tqueue();
}

//Dequeue's the item from m_item
template<class T, int N>
inline Tqueue<T, N> Truck<T, N>::GetItem() const
{
	T object;
	m_item.dequeue(object);
	return object;
}

//Gets the said item in the queue
template<class T, int N>
inline const T & Truck<T, N>::GetItemAt(int index) const
{
	if (index <= 0)
	{
		cerr << "Get item index is nonpositive!\n";
		return NULL;
	}
	else
	{
		T object;
		for (int i = 0; i < index; i++)
			m_item.dequeue(object);
		return object;
	}
}

//Adds the passed item to the queue
template<class T, int N>
inline void Truck<T, N>::AddItem(T &inputObject)
{
	m_item.enqueue(inputObject);
}

//Does nothing
template<class T, int N>
inline void Truck<T, N>::DeliverItemFromTruck(){}

template<class T, int N>
inline void Truck<T, N>::AddDelivery(Delivery &newDelivery)
{
	m_curDelivery.push_back(newDelivery);
}

template<class T, int N>
inline void Truck<T, N>::CompleteDelivery()
{
	m_curDelivery.clear();
}

template<class T, int N>
inline Delivery & Truck<T, N>::GetDeliveryAt(int index)
{
	if (index < 0)
	{
		cerr << "Get Delivery index is negative!\n";
		return NULL;
	}
	else
		return m_curDelivery.at(index);
}

template<class T, int N>
inline vector<Delivery> Truck<T, N>::GetDelivery() const
{
	return m_curDelivery;
}

template<class T, int N>
inline int Truck<T, N>::GetTime()
{
	return m_time;
}

template<class T, int N>
inline void Truck<T, N>::SetTime(int time)
{
	m_time = time;
}

template<class T, int N>
inline double Truck<T, N>::GetCapacity() const
{
	return (double) m_capacity;
}

template<class T, int N>
inline string Truck<T, N>::GetName() const
{
	return m_name;
}
#endif