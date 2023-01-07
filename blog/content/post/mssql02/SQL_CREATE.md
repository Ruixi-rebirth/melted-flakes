> SQL 中有两个可用的 CREATE 语句：
>
> - **创建数据库**
> - **创建表**

---

## 创建数据库

数据库 被定义为一组结构化的数据,因此，在 SQL 中，以结构良好的方式存储数据的第一步是创建数据库。

### 语法

```SQL
CREATE DATABASE database_name;
```

### 示例

```SQL
CREATE DATABASE StudentScore;
```

## 创建表

我们已经在上面了解了创建数据库。 现在要存储数据，我们需要一个表来执行此操作。 CREATE TABLE 语句用于在 SQL 中创建表。 我们知道一个表由行和列组成。 因此，在创建表时，我们必须向 SQL 提供有关列名、要存储在列中的数据类型、数据大小等所有信息。现在让我们深入了解如何使用 CREATE TABLE 语句创建 SQL 中的表。

### 语法

```SQL
CREATE TABLE table_name
(
column1 data_type(size),
column2 data_type(size),
column3 data_type(size),
....
);
```

### 示例

```SQl
CREATE TABLE Students
(
Sno int(3),
Sname varchar(20),
Sage varchar(20),
);
```
