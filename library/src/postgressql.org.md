---
title: Postgresql
---

```{=org}
#+STARTUP: overview
```
# basic OP

    sudo apt install postgresql-client-common

    sudo apt install postgresql postgresql-contrib

sudo -i -u postgres psql

``` example
swith to psql user (postgres, auto created), and then login in
```

sudo -u postgres psql

``` example
login psql from current user
```

`\password`{=latex} postgres; OR alter user postgres with PASSWORD
\'new~password~\';

``` example
set password
```

psql -h localhost -U \'user~name~\' (with be asked for password)

``` example
login with password, for locally distributed or remotely
for remote login, please install at least one client version( install postgres-client-12)
Had to set listen_addresses='*' in postgresql.conf to allow for incoming connections from any ip / all ip
add <hostssl   all            all             0.0.0.0/0           md5> to allow ssl connection
if remotely, please check if the port is open
```

psql \"sslmode=require host=141.5.103.1 port=5432 dbname=postgres\"
--username=postgres

ḑatabase `\du`{=latex} `\q`{=latex}

    DROP SCHEMA public CASCADE;
    CREATE SCHEMA public;

``` example
drop all table
```

# src block

## with header

```{=org}
#+header: :engine postgresql
```
```{=org}
#+header: :dbhost 141.5.103.1
```
```{=org}
#+header: :dbuser postgres
```
```{=org}
#+header: :dbpassword "xx"
```
```{=org}
#+header: :database postgres
```
``` sql
create table personv (
 id int, 
 firstname varchar(50),
 lastname varchar(50),
 gender varchar(6),
 dataofbirth DATE
) ;
```

```{=org}
#+header: :engine postgresql
```
```{=org}
#+header: :dbhost 141.5.103.1
```
```{=org}
#+header: :dbuser postgres
```
```{=org}
#+header: :dbpassword "xxx"
```
```{=org}
#+header: :database postgres
```
``` sql
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  content TEXT,
  published_by INT,
  published_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_articles_users FOREIGN KEY (published_by) REFERENCES users (id)
);
```

## with session

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="ich" database="postgres" dbport="5432"}
\l
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="ich" database="postgres" dbport="5432"}
\d 
```
