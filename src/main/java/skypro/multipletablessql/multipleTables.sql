
--Задание №1:

postgres=# \c skypro
Вы подключены к базе данных "skypro" как пользователь "postgres".
skypro=# CREATE TABLE city (
                               skypro(# city_id BIGSERIAL NOT NULL PRIMARY KEY,
                               skypro(# city_name VARCHAR(60) NOT NULL
                                   skypro(# );
CREATE TABLE
    skypro=# SELECT * FROM city;
city_id | city_name
---------+-----------
(0 строк)


skypro=# ALTER TABLE employee
    skypro-# ADD city_id INT;
ALTER TABLE
    skypro=# SELECT * FROM employee;
id | first_name | last_name | gender | age | city_id
----+------------+-----------+--------+-----+---------
  1 | Lena       | Katina    | woman  |  18 |
  4 | Ivan       | Ivanov    | man    |  51 |
  6 | Misha      | Mishkin   | man    |  48 |
  5 | Ivan       | Petrov    | man    |  32 |
  3 | Lena       | Ocmina    | woman  |  19 |
(5 строк)

--Назначить внешний ключ и связать с таблицей city.
skypro=# ALTER TABLE employee ADD FOREIGN KEY (city_id) REFERENCES city(city_id);
ALTER TABLE

--Заполнить таблицу city и назначить работникам соответствующие города.
    skypro=# INSERT INTO city (
    skypro(# city_id, city_name)
    skypro-# VALUES (1, 'Bryansk'), (3, 'Podolsk'), (4, 'Kaluga'), (5, 'Suzdal'), (6, 'Kostroma');
    INSERT 0 5
    skypro=# SELECT * FROM city;
    city_id | city_name
---------+-----------
    1 | Bryansk
    3 | Podolsk
    4 | Kaluga
    5 | Suzdal
    6 | Kostroma
    (5 строк)

    skypro=# UPDATE employee SET city_id = 1 WHERE id = 1;
    UPDATE 1
    skypro=# UPDATE employee SET city_id = 3 WHERE id = 3;
    UPDATE 1
    skypro=# UPDATE employee SET city_id = 4 WHERE id = 4;
    UPDATE 1
    skypro=# UPDATE employee SET city_id = 5 WHERE id = 5;
    UPDATE 1
    skypro=# UPDATE employee SET city_id = 6 WHERE id = 6;
    UPDATE 1

    skypro=# SELECT * FROM employee;
    id | first_name | last_name | gender | age | city_id
----+------------+-----------+--------+-----+---------
    1 | Lena       | Katina    | woman  |  18 |       1
    3 | Lena       | Ocmina    | woman  |  19 |       3
    4 | Ivan       | Ivanov    | man    |  51 |       4
    5 | Ivan       | Petrov    | man    |  32 |       5
    6 | Misha      | Mishkin   | man    |  48 |       6
    (5 строк)


--Задание №2:

--Получите имена и фамилии сотрудников, а также города, в которых они проживают.
    skypro=# SELECT first_name, last_name, city_name FROM employee
    skypro-# INNER JOIN city
    skypro-# ON employee.city_id = city.city_id
    skypro-# ORDER BY first_name;
    first_name | last_name | city_name
------------+-----------+-----------
    Ivan       | Ivanov    | Kaluga
    Ivan       | Petrov    | Suzdal
    Lena       | Katina    | Bryansk
    Lena       | Ocmina    | Podolsk
    Misha      | Mishkin   | Kostroma
    (5 строк)

--Получите города, а также имена и фамилии сотрудников, которые в них проживают.
--Если в городе никто из сотрудников не живет, то вместо имени должен стоять null.
    skypro=# SELECT city_name, first_name, last_name
    skypro-# FROM employee
    skypro-# INNER JOIN city
    skypro-# ON city.city_id=employee.id;
    city_name | first_name | last_name
-----------+------------+-----------
    Bryansk   | Lena       | Katina
    Podolsk   | Lena       | Ocmina
    Kaluga    | Ivan       | Ivanov
    Suzdal    | Ivan       | Petrov
    Kostroma  | Misha      | Mishkin
    (5 строк)

    skypro=# SELECT city_name, first_name, last_name
    skypro-# FROM employee
    skypro-# LEFT JOIN city
    skypro-# ON city.city_id=employee.id;
    city_name | first_name | last_name
-----------+------------+-----------
    Bryansk   | Lena       | Katina
    Podolsk   | Lena       | Ocmina
    Kaluga    | Ivan       | Ivanov
    Suzdal    | Ivan       | Petrov
    Kostroma  | Misha      | Mishkin
    (5 строк)

--Получите имена всех сотрудников и названия всех городов.
--Если в городе не живет никто из сотрудников, то вместо имени должен стоять null.
--Аналогично, если города для какого-то из сотрудников нет в списке, так же должен быть получен null.
    skypro=# SELECT city_name, first_name, last_name
    skypro-# FROM employee
    skypro-# FULL OUTER JOIN city
    skypro-# ON employee.id=city.city_id
    skypro-# ORDER BY first_name;
    city_name | first_name | last_name
-----------+------------+-----------
    Kaluga    | Ivan       | Ivanov
    Suzdal    | Ivan       | Petrov
    Bryansk   | Lena       | Katina
    Podolsk   | Lena       | Ocmina
    Kostroma  | Misha      | Mishkin
    (5 строк)


    skypro=# DELETE FROM employee WHERE id=4;
    DELETE 1
    skypro=# SELECT * FROM employee;
    id | first_name | last_name | gender | age | city_id
----+------------+-----------+--------+-----+---------
    1 | Lena       | Katina    | woman  |  18 |       1
    3 | Lena       | Ocmina    | woman  |  19 |       3
    5 | Ivan       | Petrov    | man    |  32 |       5
    6 | Misha      | Mishkin   | man    |  48 |       6
    (4 строки)


    skypro=# SELECT city_name, first_name, last_name
    skypro-# FROM employee
    skypro-# FULL OUTER JOIN city
    skypro-# ON employee.id=city.city_id
    skypro-# ORDER BY first_name;
    city_name | first_name | last_name
-----------+------------+-----------
    Suzdal    | Ivan       | Petrov
    Bryansk   | Lena       | Katina
    Podolsk   | Lena       | Ocmina
    Kostroma  | Misha      | Mishkin
    Kaluga    |            |
    (5 строк)

    skypro=# INSERT INTO employee (
    skypro(# first_name, last_name, gender, age)
    skypro-# VALUES ('Anna', 'Bugina', 'woman', 26);
    INSERT 0 1
    skypro=# SELECT * FROM employee;
    id | first_name | last_name | gender | age | city_id
----+------------+-----------+--------+-----+---------
    1 | Lena       | Katina    | woman  |  18 |       1
    3 | Lena       | Ocmina    | woman  |  19 |       3
    5 | Ivan       | Petrov    | man    |  32 |       5
    6 | Misha      | Mishkin   | man    |  48 |       6
    7 | Anna       | Bugina    | woman  |  26 |
    (5 строк)


    skypro=# SELECT city_name, first_name, last_name
    skypro-# FROM employee
    skypro-# FULL OUTER JOIN city
    skypro-# ON employee.id=city.city_id
    skypro-# ORDER BY first_name;
    city_name | first_name | last_name
-----------+------------+-----------
              | Anna       | Bugina
    Suzdal    | Ivan       | Petrov
    Bryansk   | Lena       | Katina
    Podolsk   | Lena       | Ocmina
    Kostroma  | Misha      | Mishkin
    Kaluga    |            |
    (6 строк)


    skypro=# UPDATE employee SET city_id = 4 WHERE id = 7;
    UPDATE 1
    skypro=# SELECT * FROM employee;
    id | first_name | last_name | gender | age | city_id
----+------------+-----------+--------+-----+---------
    1 | Lena       | Katina    | woman  |  18 |       1
    3 | Lena       | Ocmina    | woman  |  19 |       3
    5 | Ivan       | Petrov    | man    |  32 |       5
    6 | Misha      | Mishkin   | man    |  48 |       6
    7 | Anna       | Bugina    | woman  |  26 |       4
    (5 строк)


    skypro=# SELECT city_name, first_name, last_name
    skypro-# FROM employee
    skypro-# INNER JOIN city
    skypro-# ON employee.city_id=city.city_id
    skypro-# ORDER BY first_name;
    city_name | first_name | last_name
-----------+------------+-----------
    Kaluga    | Anna       | Bugina
    Suzdal    | Ivan       | Petrov
    Bryansk   | Lena       | Katina
    Podolsk   | Lena       | Ocmina
    Kostroma  | Misha      | Mishkin
    (5 строк)


--Получите таблицу, в которой каждому имени должен соответствовать каждый город.
    skypro=# SELECT first_name, last_name, city_name FROM employee
    skypro-# CROSS JOIN city;
    first_name | last_name | city_name
------------+-----------+-----------
    Lena       | Katina    | Bryansk
    Lena       | Ocmina    | Bryansk
    Ivan       | Petrov    | Bryansk
    Misha      | Mishkin   | Bryansk
    Anna       | Bugina    | Bryansk
    Lena       | Katina    | Podolsk
    Lena       | Ocmina    | Podolsk
    Ivan       | Petrov    | Podolsk
    Misha      | Mishkin   | Podolsk
    Anna       | Bugina    | Podolsk
    Lena       | Katina    | Kaluga
    Lena       | Ocmina    | Kaluga
    Ivan       | Petrov    | Kaluga
    Misha      | Mishkin   | Kaluga
    Anna       | Bugina    | Kaluga
    Lena       | Katina    | Suzdal
    Lena       | Ocmina    | Suzdal
    Ivan       | Petrov    | Suzdal
    Misha      | Mishkin   | Suzdal
    Anna       | Bugina    | Suzdal
    Lena       | Katina    | Kostroma
    Lena       | Ocmina    | Kostroma
    Ivan       | Petrov    | Kostroma
    Misha      | Mishkin   | Kostroma
    Anna       | Bugina    | Kostroma
    (25 строк)

