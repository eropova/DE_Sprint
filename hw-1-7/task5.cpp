//  Написать программу, которая выводит таблицу квадратов десяти первых положительных чисел.

#include <iostream>
using namespace std;
void fillSquares(int sqN[10], int numN[10]);

int main()
{
	int numbers[10] = { 1,2,3,4,5,6,7,8,9,10 };
	int squares[10] = {};

	fillSquares(squares, numbers);
	return 0;
}


void fillSquares(int sqN[10], int numN[10])
{
	

	for (int i = 0; i < 10;i++)
	{
		sqN[i] = numN[i] * numN[i];
		cout << sqN[i] << " " ;
	}
}


