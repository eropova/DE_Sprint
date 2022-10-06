/*Создайте структуру с именем train, содержащую поля: название пункта назначения, номер поезда, время отправления. 
Ввести данные в массив из пяти элементов типа train, упорядочить элементы по номерам поездов. 
Добавить возможность вывода информации о поезде, номер которого введен пользователем. 
Добавить возможность сортировки массива по пункту назначения, причем поезда с одинаковыми пунктами назначения должны быть упорядочены по времени отправления.*/

#include <iostream>
#include <string>
#include <array>
#include <algorithm>


using namespace std;
using std::array;
using std::find;


class Sheduller
{

public:
	string arrive;
	int num_train = 0;
	string time;
	
};

int main()
{
	setlocale(0, "");

	Sheduller trains[6]{
		{"Елкино", 998, "09:15:00"},
		{"Палкино", 5411, "11:10:00"},
		{"Метелкино", 38741, "23:12:00"},
		{"Кочкино", 5732, "11:16:00"},
		{"Кочкино", 881, "17:38:00"}
	};

	int i = 0;
	bool next = true;

	cout << "Список до сортировки:" << endl << endl;
	for (i = 0; i < 5; i++)
	{
		cout << trains[i].arrive << " " << trains[i].num_train << " " << trains[i].time << endl;
	}

	cout << endl << "Список после сортировки по номеру поезда:" << endl << endl;
	while (next)
	{
		next = false;
		for (i = 0; i < 5; i++)
		{
			if ((trains[i].num_train - trains[i + 1].num_train) > 0.0001)
			{
				next = true;
				trains[5] = trains[i];
				trains[i] = trains[i + 1];
				trains[i + 1] = trains[5];
			}
		}
	}
	for (i = 0; i < 5; i++)
	{
		cout << trains[i].arrive << " " << trains[i].num_train << " " << trains[i].time << endl;
	}

	
		cout << endl << "Фильтр по номеру поезда пользователем:" << endl;

		int user_number;
		int pos = -1;

		cout << "Введите номер поезда: ";cin >> user_number;

		for (i = 0; i < 5; i++)
		{
			if (trains[i].num_train == user_number)
			{
				pos = i;
			};
		}
		if (pos >= 0)
			{
				cout << trains[pos].arrive << " " << trains[pos].num_train << " " << trains[pos].time << endl;
			}
		else
			{
				cout << "Такого поезда нет, проверьте номер" << endl;
			}


	
	cout << endl << "Список после сортировки по пункту назначения:" << endl;

	next = true;

	while (next)
	{
		next = false;
		for (i = 0; i < 5; i++)
		{

			if (trains[i].arrive > trains[i + 1].arrive)
			{
				next = true;
				trains[5] = trains[i];
				trains[i] = trains[i + 1];
				trains[i + 1] = trains[5];
			}
			else if ((trains[i].arrive == trains[i + 1].arrive) && (trains[i].time > trains[i + 1].time))
			{
				next = true;
				trains[5] = trains[i];
				trains[i] = trains[i + 1];
				trains[i + 1] = trains[5];
			}
		}
	}

		for (i = 0; i < 5; i++)
		{
			cout << trains[i].arrive << " " << trains[i].num_train << " " << trains[i].time << endl;
		}
		





		return 0;

	
}