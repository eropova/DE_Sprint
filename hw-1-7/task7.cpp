// Написать программу, которая выводит таблицу значений функции y=-2 * x^2 - 5 * x - 8 в диапазоне от –4 до +4, с шагом 0,5

#include <iostream>
using namespace std;
int main()
{
	setlocale(0, "");

	double x, y;

	for (x = -4; x < 4.5; x = x + 0.5)
	{
		y = -2 * pow(x, 2) - (5 * x) - 8;
		//cout << -2 * pow(x, 2) - (5 * x) - 8 << endl;
		cout << y << endl;
	}
	return 0;
}