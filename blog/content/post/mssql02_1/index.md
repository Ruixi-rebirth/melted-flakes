---
title: "Mssql02_1"
date: 2022-04-18T17:55:28+08:00
tags:
  - Mssql
categories:
  - Devops
image: feature.jpg
math: true
draft: false
---

## CREATE

### 创建数据库

数据库 被定义为一组结构化的数据,因此，在 SQL 中，以结构良好的方式存储数据的第一步是创建数据库。

#### 语法

```SQL
CREATE DATABASE database_name;
```

#### 示例

```SQL
CREATE DATABASE StudentScore;
```

### 创建表

我们已经在上面了解了创建数据库。 现在要存储数据，我们需要一个表来执行此操作。 CREATE TABLE 语句用于在 SQL 中创建表。 我们知道一个表由行和列组成。 因此，在创建表时，我们必须向 SQL 提供有关列名、要存储在列中的数据类型、数据大小等所有信息。现在让我们深入了解如何使用 CREATE TABLE 语句创建 SQL 中的表。

#### 语法

```SQL
CREATE TABLE table_name
(
column1 data_type(size),
column2 data_type(size),
column3 data_type(size),
....
);
```

#### 示例 1

```SQl
CREATE TABLE Students
(
Sno int(3),
Sname varchar(20),
Sage varchar(20),
);
```

#### 示例 2

建立一个“学生”表 Student、它由学号 Sno、学生姓名 Sname、性别 Ssex、年龄 Sage、所在系 Sdept 组成，其中 Sno 为主码

```SQL
CREATE TABLE Student(
Sno CHAR(9) PRIMARY KEY,
Sname CHAR(20) UNIQUE,
Ssex CHAR(2),
Sage SMALLINT,
Sdept CHAR(20)
);
```

#### 示例 3

建立一个“课程”表 Course,它由课程号 Cno、课程名 Cname、先行课号 Cpno、学分 Ccredit 组成，其中 Cno 为主码

```SQL
CREATE TABLE Course(
Cno CHAR(4) PRIMARY KEY,
Cname CHAR(40),
Cpno CHAR(4),
Ccredit SMALLINT,
FOREIGN KEY (Cpno) REFERENCES Course(Cno)
);
```

#### 示例 4

建立一个“学生选课”表 Sc,它是由学号 Sno、课程号 Cno、选课成绩 Grade 组成，其中(Sno,Cno)为主码

```SQL
CREATE TABLE Sc(
Sno CHAR(9),
Cno CHAR(4),
Grade SMALLINT,
PRIMARY KEY (Sno,Cno),
FOREIGN KEY (Sno) REFERENCES Student(Sno),
FOREIGN KEY (Cno) REFERENCES Student(Cno)
);

/*PRIMARY KEY 只能出现一次*/
```

### 建立索引

#### 语法

```SQL

CREATE [UNIQUE] [CLUMSTER] INDEX <索引名> ON <表名>(<列名>[<次序>][,<列名>[<次序>]]……);

/*注意-->
<次序>：DESC、ASC。缺省为升序ASC。
UNIQUE 表明此索引的每一个索引值只能对应唯一的数据记录（一对一）
对于含有重复值的属性列不能建立UNIQUE索引
对某个列建立UNIQUE索引后，插入新记录时DBMS会自动检查新记录在该列上是否取了重复值。这相当于增加了一个UNIQUE约束

CLUSTEM 表示建立的索引是聚簇索引
建立聚簇索引后，基本表中数据也需要按指定的聚簇属性值的升序或降序存放。即聚簇索引的索引项顺序与表中记录的物理顺序一致
在一个基本标上最多只能建立一个聚簇索引
聚簇索引用途：对于某些类型的查询，可以提高查询效率
聚簇索引适用范围：1.很少对基表增删改查 2.很少对其中的变长列进行修改操作*/
```

#### 示例 1

为学生-课程数据库中的 Course，Sc 表建立索引。其中 Course 表按课程号升序建立唯一索引，Sc 表按学号升序和课程号降序建唯一索引

```SQL
CREATE UNIQUE INDEX Coucno ON Course (
Cno ASC
);

CREATE UNIQUE INDEX Scno ON Sc (
Cno ASC,
Sno DESC
);
```

#### 示例 2

为学生-课程数据库中的 Student 表的 Sname 列上建立一个聚簇索引，而且 Student 表中的记录按照 Sname 值的升序存放

```SQL
CREATE CLUSTERM INDEX Stusname ON Student (
Sname ASC
);
```

## DROP

DROP 用于删除整个数据库或仅删除一个表。DROP 语句会破坏现有数据库、表、索引或视图等对象。

### 语法

```SQL
DROP object object_name

Examples:
DROP TABLE table_name;
table_name: Name of the table to be deleted.

DROP DATABASE database_name;
database_name: Name of the database to be deleted.
```

### 例 1

删除 Student 表的 Stuname 索引

```SQL
DROP INDEX Stuname ON Student;
```

## ALTER

ALTER TABLE 用于添加、删除/删除或修改现有表中的列。 它还用于在现有表上添加和删除各种约束

### 更改表 - 添加

#### 语法

```SQL
 ALTER TABLE table_name
    ADD (
    Columnname_1  datatype,
    Columnname_2  datatype,
    …
    Columnname_n  datatype
    );
```

#### 示例 1

向 Student 中增加“入学时间”列

```SQL
ALTER TABLE Student
ADD S_entrance DATE;
```

#### 示例 2

增加课程名称必须取唯一值的约束条件

```SQL
ATLER TABLE Course
ADD UNIQUE (Cname);
```

### 更改表 - 删除

#### 语法

DROP COLUMN 用于删除表中的列

```SQL
ALTER TABLE table_name
DROP COLUMN column_name;
```

#### 示例 1

删除 Student 表中的 PRIMARY KEY(SqlServer)

```SQL
ALTER TABLE Student
DROP CONSTRAINT Student_PK;
/*Student_PK 是主键的名称，如果创建主键时没有指定名称，就会随机设置一个名称*/
```

### 改变表 - 修改

它用于修改表中的现有列

#### 语法

Syntax(SQL Server):

```SQL
ALTER TABLE table_name
ALTER COLUMN column_name column_type;
```

#### 示例 1

将 Student 表中的年龄的数据类型由字符型改为整数

```SQL
ALTER TABLE Student
ALTER COLUMN Sage INT,
```

## TRUNCATE

truncate 的作用是清空表或者说是截断表，只能作用于表;会清空表中的所有行，但表结构及其约束、索引等保持不变(**empty for reuse**)

### 语法

```SQL
TRUNCATE TABLE  table_name;
table_name: Name of the table to be truncated.
```

## DELETE

SQL 中的 DELETE 语句用于从表中删除现有记录。 根据我们在 WHERE 子句中指定的条件，我们可以删除单个记录或多个记录。

### 基本语法

```SQL
DELETE FROM table_name WHERE some_condition;

table_name: name of the table
some_condition: condition to choose particular record.
```

### 示例

![](./delete.jpg)

```SQL
DELETE FROM Student WHERE NAME = 'Ram';
```

Output:

| Sno | Sname | Saddress | Sphone | Sage |
| :-: | :---: | :------: | :----: | :--: |
|  2  | Rash  |   Aaa    | xxxxxx |  18  |
|  3  | Stuff |   Bbb    | xxxxxx |  20  |
|  4  |  Sbt  |   Ccc    | xxxxxx |  18  |
|  5  | Chen  |   Ddd    | xxxxxx |  20  |
|  6  | Fres  |   Eee    | xxxxxx |  18  |

```SQL
DELETE FROM Student WHERE Age = 20;
```

Output:

| Sno | Sname | Saddress | Sphone | Sage |
| :-: | :---: | :------: | :----: | :--: |
|  1  |  Ram  |  Delhi   | xxxxxx |  18  |
|  2  | Rash  |   Aaa    | xxxxxx |  18  |
|  4  |  Sbt  |   Ccc    | xxxxxx |  18  |
|  6  | Fres  |   Eee    | xxxxxx |  18  |

删除所有记录？

```SQL
DELETE FROM Student;
```
