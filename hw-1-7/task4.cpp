// Проверить на чётность введённое с клавиатуры число

#include <iostream>
using namespace std;

int main()
{
	setlocale(0, "");

	int number;

	cout << "Введите число: ";cin >> number;

	if (number % 2 == 0) 
	{ 
		cout << number << " четное число" << endl; 
	}
	else 
	{ 
		cout << number << " нечетное число" << endl; 
	}

return 0;
}