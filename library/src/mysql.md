configuation
============

安装
----

### install

    sudo apt install mysql-server
    sudo mysql_secure_installation

此时是给电脑的root用户，创建了一个mysql里root用户的数据库

### 电脑的root用户

sudo apt install mysql-server sudo mysql~secureinstallation~

### sudo

上面默认设置的是电脑root用户的密码，也就是说只能 sudo 登陆 : sudo mysql
-u root -p create new user 后可以用非sudo 登录

### with password

关闭无密码登录

    USE mysql;
    UPDATE user SET plugin='mysql_native_password' WHERE User='root';
    FLUSH PRIVILEGES;
    exit;

sudo systemctl restart mysql.service sudo mysql~secureinstallation~

### remote connect

sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf

bind-address = 127.0.0.1

### Chinese

对该 my.ini 文件下进行配置修改 ：

    [client]
    default-character-set = utf8

    [mysql]
    default-character-set = utf8

    [mysqld]
    character-set-client-handshake = FALSE
    character-set-server = utf8
    collation-server = utf8_unicode_ci
    init_connect=’SET NAMES utf8’

### Plugin is not loaded

if Plugin **\*\*\*** is not loaded: 修改mysql.cnf 在
\[mysqld\]下添加skip-grant-tables

### 电脑的普通用户进入配置 This is not needed

  ------ ------------ ------------------------------------------------------- --------------------------------------
  step   env          command                                                 explain
  01     terminal     sudo mysql -u root -p                                   电脑root进入mysql的root
  02     mysql        select User, Host, plugin from user;                    获取
  03     mysql        update user set plugin=\'mysql\_ native\_ password\';   
  04     mysql        select User, Host, plugin from user;                    获取
  05     mysql        flush privileges;                                       权限更新 in mysqld:skip-grant-tables
  06     mysql [^1]   C-d C-d                                                 退出
  07     terminal     mysql -u root BUT NOT (mysql -u root -p)                不能 -p, 密码为空，直接Enter进入
  08     mysql        set password for root\@localhost = \'123\'              老版本 = password(\'123\');
  09     error        123 is too simple, just not satisfy the                 check the password requirement.
  10     mysql        show variables like \'validate\_ password%\';           显示密码设置要求
  11     mysql        set global validate\_ password\_ length=3;              设置密码长度要求 为 3
  12     mysql        set global validate\_ password\_ policy=0;              设置密码要求概要 为 0
  13     mysql        set password for root\@localhost = \'123\'              老版本 = password(\'123\');
  14     mysql        flush privileges;                                       权限更新 in mysqld:skip-grant-tables
  15     terminal     mysql -u root -p                                        密码 123 , 登陆时不需要 sudo 开头
  ------ ------------ ------------------------------------------------------- --------------------------------------

给数据库添加用户
----------------

在进入数据库的root后，mysql 添加普通用户
[简书连接](https://www.jianshu.com/p/d7b9c468f20d) .

create USER \'sx\'@\'localhost\' IDENTIFIED BY \'scofild\';
创建sx用户，只能本地连接，秘密scofild

GRANT ALL ON testforjava.course TO \'sx\'@\'localhost\';
开放testforjava数据集中的course数据表的所有全线给sx 用户

退出后登陆 sx 用户 mysql -u sx -p scofild

便只能看到有权限的数据集

查看数据库及添加数据库
----------------------

show databases;

create databese kurs;

drop databases kurs;

中文设置
--------

  -------------------------------------
  show variables like \'character%\';
  -------------------------------------

听说mysql的utf8不是真的utf8，需要使用utf8mb4. 在用户登陆后用set
charactater server database = utf8 或者utf8mb4，
只要重开接入，设置就复原。
只有在/etc/mysql/中的mysql.cnf中的clint/mysqld/mysql字段加入以上设定，重启生效

  -------------------- ----------------------------
  在\[client\]下追加   default-character-set=utf8
  在\[mysqld\]下追加   character-set-server=utf8
  在\[mysql\]下追加    default-character-set=utf8
  -------------------- ----------------------------

特殊字符
--------

-   用\`ry-vue\`

create database \`ry-vue\`;

execute file 执行sql文件
------------------------

mysql -u root -p xxxx use database; source .../file.sql

remote
------

alter user \'root\'@\'localhost\' indentified by \'110011\';

reboot
------

sudo systemctl restart mysql

Operation
=========

进入数据库
----------

create databese testforjava; use testforjava;

插入表格
--------

``` {.sql}
create table course(
       id int primary key atuo_increment,
       kurs_name varchar(50),
       kurs_length  varchar(50),
       teacher varchar(50),
       categeory varchar(50)
       );
```

for later version, only works for auto~increment~, not for identity(m,n)

插入值
------

insert into kurs values(1, \'C++\', 23, \'su\', \'basic\'); insert into
kurs values (2, \'Python\', 50, \'morvan\', \'hard\'); insert into kurs
values(3, \'CLI\', 22, \'su\', \'basic\');

或者 不完整信息

insert into kurs(id, kurs~name~, categeory) values(4, \'java\',
\'basic\'); (指定属性给值)

查看表格
--------

show tables;

describe course;

编辑表格
--------

alter table course rename kurs; (重命名)

alter table kurs add link varchar(50); (添加属性，列)

alter table kurs drop column link; (将该列删除)

alter table kurs modify teacher varchar(100); (修改该列的属性，增加容量)

alter table kurs change column teacher lecture varchar(100);
(修改该列的名称，和属性，)

读取内容
--------

select \* from kurs;

select kurs~name~, lecture from kurs;

读取内容时，不重复显示

select distinct lecture from kurs;

高级条件查询
------------

select \* from course where course~name~ = \'gnome\';

select \* from course where course~length~ \> 10;

select \* from course where lecture=\'su\' and categeory=\'adv\';
(满足这两个要求的) select \* from course order by course~length~ desc;
(由课程长度有小到大排序) 后面加desc 则反序排序

delete
------

delete from course where id =2; delete from table where key=value

update
------

update course set lecture = \'Lee\' where id =3;

backup
------

mysqldump -u root -p kurs \> firstForFun.sql;
(在root下将kurs数据库备份为FirstForFun.sql)

mysql -u root -p kurs \< Firstforfun.sql
(将备份文件FirstForFun.sql恢复为kurs数据库)

(此两个语句是在退出sql后的terminal执行的)

Management
==========

user
----

show databases; use mysql; show tables;

mysqld --skip-grant-tables (开启mysql的无验证登陆，对于遗失密码后）
select host,user from user; (查看所有用户)

create user \'cloud\'@\'%\' identified by \'password\'; drop user
\'root\'@\'%\';

rename user si to shi; (将si重命名为shi) set password =
password(\'new\'); (将当前用户密码改为new) set password for si =
password(link); (将si用户密码重置为link)

grant all privileges on \*\*.\*\* to \'cloud\'@\'%\' with grant option;
flush privileges;

privileges
----------

### creat

create user shi identified by \'lining\'; grant all privileges on
\*\*.\*\* to \'shi\'@\'%\' identified by \'lining\' with grant option;
flush privileges;

grant all privileges on \*\*.\*\* to \'root\'@\'%\' identified by
\'lining\';

### 查询

show grants for \'newuser\'@\'localhost\'

### 授予

grants 权限列表 on 数据库名.表明 to \'用户\'@\'主机名\' grants all on
**.** \'newuser\'@\'localhost\'

### 撤销

revoke delete on **.** from \'newuser\'@\'localhost\'

timezone
--------

set global time~zone~ = \'+8:00\';
\#\#修改mysql全局时区为北京时间，即我们所在的东8区 set time~zone~ =
\'+8:00\'; \#\#修改当前会话时区 flush privileges; \#立即生效

Operations for SQL
==================

decripation
-----------

there can available code to execute, change the dbhost and dbpassword

check the connection in 0812erp
-------------------------------

``` {.sql results="output"}
show tables;
```

``` {.example}
Tables_in_0812erp
bus_customer
bus_goods
bus_inport
bus_outport
bus_provider
bus_sales
bus_salesback
sys_dept
sys_loginfo
sys_menu
sys_notice
sys_role
sys_role_menu
sys_role_user
sys_user
```

``` {.sql results="output"}
SELECT * FROM sys_menu          
```

check the database
------------------

``` {.sql}
show tables;
```

dump database
-------------

``` {.bash org-language="sh"}
mysqldump -uroot -p123456 testforjava > ~/Desktop/mysql.sql
```

delete database
---------------

``` {.sql}
drop database testforjava;
show databases;
```

  Database
  ---------------------
  information~schema~
  0812erp
  mysql
  performance~schema~
  sys

recover testforjava
-------------------

``` {.sql}
create database testforjava;
use testforjava;
source ~/Desktop/mysql.sql
show databases;
```

  Database
  ---------------------
  information~schema~
  0812erp
  mysql
  performance~schema~
  sys
  testforjava

Table creation update delete
----------------------------

``` {.sql results="output"}
-- 班级表
CREATE TABLE classe(
    id INT PRIMARY KEY auto_increment,
    caption VARCHAR(30) COMMENT '班级名'
);

-- 学生表
CREATE TABLE student(
    id INT UNSIGNED PRIMARY KEY auto_increment,
    student_name CHAR(30) COMMENT '学生名',
    gender CHAR(30) DEFAULT NULL    COMMENT '学生性别',
    class_id INT DEFAULT NULL COMMENT '班级id'
);

-- 老师表
CREATE TABLE teacher(
    id INT UNSIGNED PRIMARY KEY auto_increment,
    teacher_name CHAR(30) COMMENT '教师名'
);

-- 课程表
CREATE TABLE course(
 id INT UNSIGNED PRIMARY KEY auto_increment,
 course_name CHAR(30) COMMENT '课程名',
 teacher_id INT DEFAULT NULL COMMENT'教师id'
);

-- 成绩表
CREATE TABLE score(
    id INT UNSIGNED PRIMARY KEY auto_increment,
    number INT DEFAULT NULL COMMENT '分数',
    student_id INT DEFAULT NULL COMMENT '学生id',
    course_id INT DEFAULT NULL COMMENT '课程id'
);
```

``` {.sql results="output"}
drop table score;
drop table student;
drop table course;
drop table classe;
drop table teacher;
```

``` {.sql results="output"}
INSERT INTO student (student_name, gender, class_id) VALUES ('张三', 'M', 1);
INSERT INTO student (student_name, gender, class_id) VALUES ('李四', 'M', 2);
-- INSERT INTO student (student_name, gender, class_id) VALUES ('王五', 'F', 4);  
INSERT INTO classe (caption) VALUES ('一班');
INSERT INTO classe (caption) VALUES ('二班');
INSERT INTO classe (caption) VALUES ('三班');           
```

add foreign key
---------------

add foreign key muss be careful, the references must exist, such as --
INSERT INTO student (student~name~, gender, class~id~) VALUES (\'王五\',
\'F\', 4); will give error with add foreign key, because there are no
such item in classe with id=4!!!!

``` {.sql results="output"}
-- ALTER TABLE student DROP FOREIGN KEY student_class;
ALTER TABLE student ADD 
CONSTRAINT student_class 
FOREIGN KEY (class_id) 
REFERENCES classe(id)
ON DELETE CASCADE
ON UPDATE CASCADE;

```

``` {.sql results="output"}
DELETE FROM classe WHERE id=2;
```

``` {.sql results="output"}
UPDATE classe SET id=10 WHERE id=1;
```

left join
---------

``` {.sql results="output"}
select c.caption, s.student_name, s.gender from classe c left join student s on c.id=s.class_id;
```

right join
----------

``` {.sql results="output"}
select c.caption, s.student_name, s.gender from classe c right join student s on c.id=s.class_id;
```

inner join
----------

``` {.sql results="output"}
select c.caption, s.student_name, s.gender from classe c inner join student s on c.id=s.class_id;
```

full joipn
----------

``` {.sql results="output"}
select * from classe left join student on classe.id=student.class_id union  select * from classe right join student on classe.id=student.class_id;          
```

many2one
--------

add more students to same class

``` {.sql results="output"}
INSERT INTO student (student_name, gender, class_id) VALUES ('张五', 'M', 1);
INSERT INTO student (student_name, gender, class_id) VALUES ('李六', 'M', 2);
INSERT INTO student (student_name, gender, class_id) VALUES ('李七', 'M', 1);
INSERT INTO student (student_name, gender, class_id) VALUES ('李八', 'M', 1);
INSERT INTO student (student_name, gender, class_id) VALUES ('李九', 'M', 1);
```

``` {.sql results="output"}
SELECT c.caption ,COUNT(s.student_name) student_num 
FROM classe c LEFT JOIN student s ON c.id=s.class_id 
GROUP BY c.id;
```

``` {.sql results="output"}
select c.caption , s.student_name, s.gender from classe c left join student s on c.id=s.class_id;          
```

many2many
---------

``` {.sql}
CREATE TABLE tag(
id INT UNSIGNED PRIMARY KEY auto_increment,
tag_name VARCHAR(50) NOT NULL
)

CREATE TABLE article(
id INT UNSIGNED PRIMARY KEY auto_increment,
title VARCHAR(100) NOT NULL
)

CREATE TABLE tag_article(
id INT UNSIGNED PRIMARY KEY auto_increment,
tag_id INT UNSIGNED DEFAULT NULL,
article_id INT UNSIGNED DEFAULT NULL,
FOREIGN KEY(tag_id) REFERENCES tag(id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(article_id) REFERENCES article(id) ON DELETE CASCADE ON UPDATE CASCADE,
UNIQUE(tag_id,article_id)
)


SELECT a.title 
FROM article a INNER JOIN tag_article t 
ON a.id=t.article_id 
WHERE tag_id=1







```

Operation from the third program language
=========================================

singal python file connect with mysql
-------------------------------------

``` {.python results="output"}
import pymysql
db = pymysql.connect("localhost", "root", "123456", "testforjava")
cursor = db.cursor()
sql = """create table  IF NOT EXISTS course(id int,  kurs_name varchar(50), kurs_length varchar(50),teacher varchar(50), categeory varchar(50))"""
cursor.execute(sql)
sql = """insert into course values(7, 'CLI', 22, 'su', 'basic')"""
cursor.execute(sql)
sql = """insert into course values(8, 'CLI', 22, 'su', 'basic')"""
cursor.execute(sql)
db.commit()

sql1 = """select * from course"""
cursor.execute(sql1)
results = cursor.fetchall()
print('\n')
for row in results:
    num = row[0]
    name = row[1]
    age = row[2]
    right = row[3]
    dis = row[4]
    print("num is %7s, name is %7s, age is %7s, right is %7s, dis is %7s" %
          (num, name, age, right, dis))

# if __name__ == "__main__":
cursor.close()

```

``` {.python results="output"}
from pymysql import connect
from pymysql.cursors import DictCursor


class Pymysqlconnection:
    def __init__(self):
        self.conn = connect(
            host='localhost',
            port=3306,
            user='cloud',
            password='password',
            database='0812erp'
        )
        self.cursor = self.conn.cursor(DictCursor)

    def __def__(self):
        self.cursor.close()
        self.conn.close()

    def get_item(self):
        sql = 'select * from sys_user'
        self.cursor.execute(sql)
        for temp in self.cursor.fetchall():
            print(temp)


if __name__ == '__main__':
    pymysqlconnection = Pymysqlconnection()
    pymysqlconnection.get_item()

```

singal java file connect with mysql
-----------------------------------

``` {.java classname="JavaConnSQL" results="output" dir="~/Desktop/"}
import java.sql.*;
public class JavaConnSQL
{
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";  
    static final String DB_URL = "jdbc:mysql://localhost:3306/testforjava?useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123456";
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        System.out.println("在dir中生成的代码， 如果dir中有驱动，则可以执行mysql的连接");
        System.out.println("提前执行");
        System.out.println("export CLASSPATH=mysql-connector-java-8.0.20.jar:. ");
        Connection conn = null;
        Statement stmt = null;
        try{
            Class.forName(JDBC_DRIVER);
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL,USER,PASS);

            System.out.println(" 实例化Statement对象...");
            stmt = conn.createStatement();
            String sql;
            sql = "SELECT id, kurs_name FROM course";
            ResultSet rs = stmt.executeQuery(sql);

            while(rs.next()){
                int id  = rs.getInt("id");
                String name = rs.getString("kurs_name");
                // 输出数据
                System.out.print("ID: " + id);
                System.out.print(", kurs name 站点名称: " + name);
                System.out.print("\n");
            }
            rs.close();
            stmt.close();
            conn.close();
        }catch(SQLException se){
            // 处理 JDBC 错误
            se.printStackTrace();
        }catch(Exception e){
            // 处理 Class.forName 错误
            e.printStackTrace();
        }
    }
}

```

Footnotes
=========

[^1]: 此后，电脑的root用户将不能登陆，而此时电脑的普通,
    用户可以登陆，但是没有设置密码，不能用 -p 登陆
