/*Необходимо создать двумерный массив 5 х 5. 
Далее написать функцию, которая заполнит его случайными числами от 30 до 60. 
Создать еще две функции, которые находят максимальный и минимальный элементы этого двумерного массива*/

#include <iostream>
#include <random>
using namespace std;
void addNumbers(int arrNumbers[5][5]);
void findMax(int arrNumbers[5][5]);
void findMin(int arrNumbers[5][5]);

int main()
{
	setlocale(0, "");
	int newArray[5][5] = {};
	addNumbers(newArray);
	findMax(newArray);
	findMin(newArray);
	
	return 0;
}

void addNumbers(int arrNumbers[5][5])
{
	srand(time(NULL));
	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++) {
			arrNumbers[i][j] = rand() % (60 - 30 + 1) + 30;
			cout << arrNumbers[i][j] << "  ";
		}
	} cout << endl;
	}


void findMax(int arrNumbers[5][5])
{
	int max;
	max = arrNumbers[0][0];
	for (int i = 1; i < 5; i++)
	{
		for (int j = 0; j < 5; j++) {
			if (max < arrNumbers[i][j]) max = arrNumbers[i][j];
		}
	}
	cout << "\n" << "Max: " << max << endl;
}

void findMin(int arrNumbers[5][5])
{
	int min;
	min = arrNumbers[0][0];
	for (int i = 1; i < 5; i++)
	{
		for (int j = 0; j < 5; j++) {
			if (min > arrNumbers[i][j]) min = arrNumbers[i][j];
		}
	}
	cout <<"\n" << "Min: " << min << endl;
}