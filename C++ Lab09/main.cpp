/*
 * main.cpp
 *
 *  Created on: Nov 12, 2017
 *      Author: ntt3013
 */
//Include for cout
#include <iostream>
//Include Automobile header
#include "Automobile.h"
//Include for pointers
#include <memory>
using namespace std;
//main Function
int main(int argc, char **argv) {

	//Create Vehicle pointer
	Vehicle *MyVehicle = new Automobile("Chevy", "Impala", "Sedan");

	//print myVehicle
	MyVehicle->Print();

	//print new line
	std::cout << std::endl;

	//delete myVehicle
	delete MyVehicle;

	//My other car created
	Automobile MyOtherCar("Ford", "F-150", "Truck");
	//test declared to test other car
	Vehicle Test = MyOtherCar;

	//print test function
	Test.Print();

	//print new line
	cout << std::endl;

	//create pointer for my third car
	std::shared_ptr<Vehicle> MyThirdCar(
			new Automobile("Madza", "Miata", "Roadster"));

	//print my third car
	MyThirdCar->Print();

	//print new line
	cout << std::endl;

	//create pointer my boat
	std::shared_ptr<Vehicle> MyBoat = Vehicle::Create("Boat", "Boston Whaler",
			"Conquest", "Outboard");

	//print my boat
	MyBoat->Print();

	//print new line
	cout << std::endl;

	//create pointer for my automobile
	std::shared_ptr<Vehicle> MyAutomobile = Vehicle::Create("Automobile",
			"Ford", "Focus", "Sedan");

	//print my auto mobile
	MyAutomobile->Print();

	//print new line
	cout << std::endl;

	//create pointer my bicycle
	std::shared_ptr<Vehicle> MyBicycle = Vehicle::Create("Bicycle", "Colnago",
			"Sport Bikes", "C60");

	//print my bicycle
	MyBicycle->Print();

	//Return main
	return (0);
}

