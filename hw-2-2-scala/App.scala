import scala.io.StdIn.readLine
import scala.math

object App {

  def main(args: Array[String]): Unit = {

    //    playStrings()
    //    onePersonIncome()
    //    departmentIncome()
    //    reloadSalary()
    //    sortSalary()
    salaryIncrease()
  }

  def playStrings(): Unit = {
    var st = "Hello, scala world!"
    var newSt = " But never Python goodbye =)"
    println(st) // первоначальная строка
    println(st.reverse) // выводит фразу справа налево
    println(st.toLowerCase) // переводит всю фразу в нижний регистр
    println(st.replace("!", "")) // удаляет символ!
    println(st.concat(newSt)) //добавляет в конец фразы
  }

  // Напишите программу, которая вычисляет ежемесячный оклад сотрудника после вычета налогов.
  // На вход вашей программе подается значение годового дохода до вычета налогов,
  // размер премии – в процентах от годового дохода и компенсация питания.

  def onePersonIncome(): Unit = {
    val incomeYear = readLine("Введите доход до налогообложения: ")
    val bonus = readLine("Введите размер премии: ")
    val foodCompensation = readLine("Введите размер компенсации на питание: ")
    var totalIncome = (incomeYear.toInt + incomeYear.toInt * bonus.toInt / 100 + foodCompensation.toInt) * .87
    println(totalIncome)
  }

  //Напишите программу, которая рассчитывает для каждого сотрудника отклонение(в процентах)
  // от среднего значения оклада на уровень всего отдела. В итоговом значении должно учитываться в большую или меньшую
  // сторону отклоняется размер оклада.
  // На вход вышей программе подаются все значения, аналогичные предыдущей программе,
  // а также список со значениями окладов сотрудников отдела 100, 150, 200, 80, 120, 75.

  def departmentIncome(): Unit = {
    val salaries = List(100, 150, 200, 80, 120, 75)
    val bonus = readLine("Введите размер премии: ")
    val foodCompensation = readLine("Введите размер компенсации на питание: ")
    val avgSalary: Double = salaries.sum / salaries.size
    salaries.foreach(
      (s: Int) => {
        val sNew = (s + s * bonus.toInt / 100 + foodCompensation.toInt) // в расчет берется сумма до вычета для сопоставимости со средней
        var diff: Double = (100 - (sNew / avgSalary) * 100).round
        if (sNew < avgSalary) println(f"$sNew меньше средней зарплаты на $diff%%")
        else {
          diff = diff * -1
          println(s"$sNew больше средней зарплаты на $diff%%")
        }
      })

  }


  //Попробуйте рассчитать новую зарплату сотрудника, добавив или отняв (если сотрудник плохо себя вел)
  // необходимую сумму с учетом результатов прошлого задания. Добавьте его зарплату в список
  // и вычислите значение самой высокой зарплаты и самой низкой.
  def reloadSalary(): Unit = {
    var salaries = List(100, 150, 200, 80, 120, 75)
    val bonus = readLine("Введите размер премии: ")
    val foodCompensation = readLine("Введите размер компенсации на питание: ")
    val avgSalary: Double = salaries.sum / salaries.size
    val newSalaries = salaries.map((s: Int) => if (s < avgSalary) s + 15 else s)
    println(f"${newSalaries.max} - максимальное значение зарплаты \n ${newSalaries.min} - максимальное значение зарплаты")
  }


  // e Также в вашу команду пришли два специалиста с окладами 350 и 90 тысяч рублей.
  // Попробуйте отсортировать список сотрудников по уровню оклада от меньшего к большему.

  // f Кажется, вы взяли в вашу команду еще одного сотрудника и предложили ему оклад 130 тысяч.
  // Вычислите самостоятельно номер сотрудника в списке так, чтобы сортировка не нарушилась и добавьте его на это место.

  // g Попробуйте вывести номера сотрудников из полученного списка, которые попадают под категорию middle.
  // На входе программе подается «вилка» зарплаты специалистов уровня middle.

  def sortSalary(): Unit = {
    var salaries = List(100, 150, 200, 80, 120, 75)
    var newEmployee = List(350, 90)
    var newSalary = salaries ::: newEmployee
    var sortedSalary = newSalary.sortWith(_ < _)
    println(sortedSalary) // e

    var veryNewEmployee = 130
    var sortedArraySalary = sortedSalary.toArray
    var i: Int = 0
    for (s <- sortedArraySalary)
      if (s <= veryNewEmployee) (i = i + 1)

    var veryNewSortedArraySalary = sortedArraySalary.slice(0, i) ++ Array(veryNewEmployee) ++ sortedArraySalary.slice(i, sortedArraySalary.length)
    println(veryNewSortedArraySalary.mkString(", ")) // f

    var minSalary = readLine("Введите нижнее значение зарплаты Middle: ")
    var maxSalary = readLine("Введите верхнее значение зарплаты Middle: ")

    for (s <- veryNewSortedArraySalary) {

      if ((s >= minSalary.toInt) && (s <= maxSalary.toInt)) {
        println("Индекс сотрудника уровня Middle - " + veryNewSortedArraySalary.indexOf(s).toString + ", значение зарплаты - " + s.toString)
      }
    }
  }

  //  Однако наступил кризис и ваши сотрудники требуют повысить зарплату.
  //  Вам необходимо проиндексировать зарплату каждого сотрудника на уровень инфляции – 7%
  def salaryIncrease(): Unit = {
    var salaries = Array(100, 150, 200, 80, 120, 75, 350, 90, 130)
    for (i <- salaries.indices)
      salaries(i) = (salaries(i) * 1.07).toInt

    println(salaries.mkString(", "))
  }
}


