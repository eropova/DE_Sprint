/*Написать программу решения квадратного уравнения.
Программа должна проверять правильность исходных данных и в случае, 
если коэффициент при второй степени неизвестного равен нулю, выводить соответствующее сообщение.*/

#include <iostream>
using namespace std;
int main()
{
	setlocale(0, "");
	int a, b, c;
	float discriminant, x, x1, x2;

	cout << "Введите коэффициент 1: ";cin >> a;
	cout << "Введите коэффициент 2: ";cin >> b;
	cout << "Введите коэффициент 3: ";cin >> c;

	if (a != 0)
	{
		discriminant = pow(b, 2) - (4 * a * c);
		{if (discriminant == 0)
		{
			x = -b / (static_cast<float>(2) * a);
			cout << "Единственный корень квадратного уравнения:  " << x << endl;
		}

		else if (discriminant > 0)
		{
			x1 = (-b + pow(discriminant, 0.5)) / (2 * a);
			x2 = (-b - pow(discriminant, 0.5)) / (2 * a);
			cout << "Корни квардратного уравнения:  " << x1 << ", " << x2 << endl;
		}
		else
		{
			cout << "Уравнение не имеет решения" << endl;
		}
		}
	}
	else { cout << "Некорректное значение коэффициента 1: " << a << endl; }


	return 0;
	}