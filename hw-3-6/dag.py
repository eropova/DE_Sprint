from datetime import datetime
from datetime import timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from random import randint


def hello():
    print("hi")


def two_numbers():
    a = randint(1, 10)
    b = randint(40, 50)
    with open('/opt/airflow/dags/numbers_file.txt', 'a', newline='\n') as f:
        f.write(f'{a} {b}\n')


def diff_columns():
    row_1 = 0
    row_2 = 0
    out_string = ''
    with open('/opt/airflow/dags/numbers_file.txt', 'r') as f:
        file = f.readlines()
        for _ in file:
            try:
                n1, n2 = _.split(' ')
                row_1 += int(n1)
                row_2 += int(n2)
                out_string += (str(n1) + ' ' + str(n2) + '\n')
            except:
                pass

    diff_n = row_1 - row_2

    out_string += (str(diff_n) + '\n')
    with open('/opt/airflow/dags/numbers_file.txt', 'w', newline='\n') as f:
        f.write(out_string)


with DAG(
        dag_id='frst_dag',
        start_date=datetime(2022, 12, 6, 16, 17, 0),
        default_args={'retries': 5},
        schedule_interval="*/1 * * * *",

         ) as dag:
    bash_task = BashOperator(task_id='hello', bash_command='echo hello')

    python_task = PythonOperator(task_id='world', python_callable=hello)

    python_numbers = PythonOperator(task_id='numbers', python_callable=two_numbers)

    python_diff = PythonOperator(task_id='diff', python_callable=diff_columns)

    bash_task >> python_task >> python_numbers >> python_diff
