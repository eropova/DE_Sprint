### 3.1 Практика HDFS

1. Переместим файлики в папку на HDFS.

```
$ ls /home/cloudera/Downloads/
voyna-i-mir-tom-1.txt  voyna-i-mir-tom-3.txt
voyna-i-mir-tom-2.txt  voyna-i-mir-tom-4.txt

$ hadoop fs -put -f /home/cloudera/Downloads/voyna-i-mir-tom-*.txt /user/cloudera
```

2. Выведем содержимое папки
```
$ hadoop fs -ls
Found 4 items
-rw-r--r--   1 cloudera cloudera     736519 2022-11-23 02:51 voyna-i-mir-tom-1.txt
-rw-r--r--   1 cloudera cloudera     770324 2022-11-23 02:51 voyna-i-mir-tom-2.txt
-rw-r--r--   1 cloudera cloudera     843205 2022-11-23 02:51 voyna-i-mir-tom-3.txt
-rw-r--r--   1 cloudera cloudera     697960 2022-11-23 02:51 voyna-i-mir-tom-4.txt
```

3. Сожмем все файлы в один и уберем лишние отдельные тома
``` 
$ hadoop fs -getmerge -nl /user/cloudera/voyna-i-mir-tom-1.txt /user/cloudera/voyna-i-mir-tom-2.txt /user/cloudera/voyna-i-mir-tom-3.txt /user/cloudera/voyna-i-mir-tom-4.txt /home/cloudera/Downloads/voyna-i-mir.txt
$ hadoop fs -put voyna-i-mir.txt /user/cloudera
$ hadoop fs -rm -skipTrash /user/cloudera/voyna-i-mir-tom*.txt
$ hadoop fs -ls
Found 1 items
-rw-r--r--   1 cloudera cloudera    3048012 2022-11-23 03:23 voyna-i-mir.txt
```

4. Изменим права доступа к файлу
```
$ hadoop fs -chmod 755 /user/cloudera/voyna-i-mir.txt
$ hadoop fs -ls
Found 1 items
-rwxr-xr-x   1 cloudera cloudera    3048012 2022-11-23 03:23 voyna-i-mir.txt
```

5. Выведем информацию о месте на диске под файл
```
$ hadoop fs -du -h /user/cloudera/voyna-i-mir.txt
2.9 M  2.9 M  /user/cloudera/voyna-i-mir.txt
```

6. Изменим фактор репликации
```
$ hadoop fs -setrep 2 /user/cloudera/voyna-i-mir.txt
Replication 2 set: /user/cloudera/voyna-i-mir.txt
$ hadoop fs -du -h /user/cloudera/voyna-i-mir.txt
2.9 M  5.8 M  /user/cloudera/voyna-i-mir.txt
```

7. Кол-во строк в файле
```
$ hadoop fs -cat /user/cloudera/voyna-i-mir.txt | wc -l
10276
```
