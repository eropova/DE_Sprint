/*Создайте структуру с именем student, содержащую поля: фамилия и инициалы, номер группы, успеваемость (массив из пяти элементов). 
Создать массив из десяти элементов такого типа, упорядочить записи по возрастанию среднего балла. 
Добавить возможность вывода фамилий и номеров групп студентов, имеющих оценки, равные только 4 или 5.*/

#include <iostream>
#include <string>
#include <array>
#include <algorithm>


using namespace std;
using std::array;


class Student
{

public:
	string surname;
	string name;
	int num_group=0;
	std::array<int, 5> marks;
	float meanMark()
	{
		int i;
		float summ = 0;
		for (i = 0;i < 5;i++)
		{
			summ = summ + marks[i];
		}
		return summ / 5;
	};
	bool AStudent()
	{
		bool A = true;
		int i;
		for (i = 0;i < 5;i++)
		{
			if (marks[i] < 4)
			{
				A = false;
			}
		}
		return A;
	}
};

int main()
{
	setlocale(0, "");

	Student studentArr[11]{
		{"Синичикин","А.В.", 123, {4,4,5,5,4}},
		{"Воробьев","Б.Г.", 245, {4,3,4,3,3}},
		{"Соколов","В.Д", 245, {5,5,4,3,5}},
		{"Орлов","Г.Е.", 245, {3,3,4,3,3}},
		{"Воронов","Д.Ж.", 123, {5,5,5,4,5}},
		{"Уткин","Е.З.", 245, {5,5,5,5,5}},
		{"Гусев","Ж.И.", 123, {4,4,4,4,4}},
		{"Галкин","З.К.", 111, {5,4,5,4,5}},
		{"Чайкин","И.Л.", 111, {4,5,4,5,4}},
		{"Сорокин","К.М.", 111, {4,3,4,5,4}},
		
	};



	int i = 0;
	int j = 0;
	bool next = true;

	cout << "Список до сортировки:" << endl << endl;
	for (i = 0; i < 10; i++)
	{
		cout << studentArr[i].surname << " " << studentArr[i].name << " " << studentArr[i].num_group << " " << studentArr[i].meanMark() <<  endl;
		for (j = 0; j < 5; j++)
		{
			cout << studentArr[i].marks[j] << ' ';
		}
		cout << endl;
	}

	cout << endl << "Список после сортировки:" << endl << endl;
	while (next)
	{
		next = false;
		for (i = 0; i < 10; i++)
		{
			if ((studentArr[i].meanMark() - studentArr[i + 1].meanMark()) > 0.0001)
			{
				next = true;
				studentArr[10] = studentArr[i];
				studentArr[i] = studentArr[i + 1];
				studentArr[i + 1] = studentArr[10];
			}
		}
	}
	for (i = 0; i < 10; i++)
	{
		cout << studentArr[i].surname << " " << studentArr[i].name << " " << studentArr[i].num_group << " " << studentArr[i].meanMark() << " "  << endl;
		for (j = 0; j < 5; j++)
		{
			cout << studentArr[i].marks[j] << ' ';
		}
		cout << endl;
	}

	cout << endl << "Студенты-отличники: " << endl << endl;
	for (i = 1; i < 10; i++)
	{
		if (studentArr[i].AStudent())
		{
			cout << studentArr[i].surname << " " << studentArr[i].name << " " << studentArr[i].num_group << " " << studentArr[i].meanMark() << " " << studentArr[i].AStudent() << endl;
		}
	}










	return 0;
}