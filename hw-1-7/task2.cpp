//Написать программу, которая проверяет является ли год високосным.

#include <iostream>
using namespace std;

int main()
{
	int year;
	cout << "Введите год: ";cin >> year;
	if (year % 4 == 0) 	{ 
		if (year % 100 == 0) 	
		{ 
			if (year % 400 == 0)
			{
				cout << year << " это високосный год" << endl;
			}

			else 
			{ 
				cout << year << " это не високосный год" << endl; 
			}
		} 
		else cout << year << " это високосный год" << endl;
	}
	else cout << year << " это не високосный год" << endl;

	return 0;
}