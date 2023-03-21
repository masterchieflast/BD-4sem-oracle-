--1. Получите список всех существующих PDB в рамках экземпляра ORA12W. Определите их текущее состояние.
select name, open_mode, con_id from v$pdbs;
select pdb_name, pdb_id, status from SYS.dba_pdbs;

--2. Выполните запрос к ORA12W, позволяющий получить перечень экземпляров.
select * from v$instance;

--3. Выполните запрос к ORA12W, позволяющий получить перечень установленных компонентов СУБД Oracle 12c и их версии и статус.
select *from SYS.product_component_version;

--4. Создайте собственный экземпляр PDB (необходимо подключиться к серверу с серверного компьютера и используйте Database Configuration Assistant) с именем XXX_PDB, где XXX – инициалы студента.
--database configuration assistant -> DDD_PDB

--5. Получите список всех существующих PDB в рамках экземпляра ORA12W. Убедитесь, что созданная PDB-база данных существует.
select name,open_mode,con_id from v$pdbs;

--6. Подключитесь к XXX_PDB c помощью SQL Developer создайте инфраструктурные объекты (табличные пространства, роль, профиль безопасности, пользователя с именем U1_XXX_PDB).

ALTER SESSION SET "_ORACLE_SCRIPT"=true;
ALTER SESSION SET "_ORACLE_SCRIPT"=false;

CREATE TABLESPACE TS_DDD
    DATAFILE 'TS_DDD_pdb_2.dbf'
    SIZE 7 m
    AUTOEXTEND ON NEXT 5M
    MAXSIZE 20M
    EXTENT MANAGEMENT LOCAL;

CREATE TEMPORARY TABLESPACE  TS_DDD_TEMP
    TEMPFILE 'TS_DDD_temp_pdb_2.dbf'
    SIZE 5 m
    AUTOEXTEND ON NEXT 3M
    MAXSIZE 30M
    EXTENT MANAGEMENT LOCAL;

CREATE ROLE RL_DDDCORE;

drop role RL_DDDCORE;

grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view,
      drop any procedure
to RL_DDDCORE;
commit;

grant create session to RL_DDDCORE;
select * from dba_sys_privs where grantee = 'RL_DDDCORE';

CREATE PROFILE PF_DDDCORE LIMIT
    PASSWORD_LIFE_TIME 180
    SESSIONS_PER_USER 3
    FAILED_LOGIN_ATTEMPTS 7
    PASSWORD_LOCK_TIME 1
    PASSWORD_REUSE_TIME 10
    PASSWORD_GRACE_TIME DEFAULT
    CONNECT_TIME 180
    IDLE_TIME 30;

select *from v$pdbs;


create user U1_DDD_PDB identified by 12345
default tablespace TS_DDD quota unlimited on TS_DDD
temporary tablespace TS_DDD_TEMP
account unlock;


grant create session to U1_DDD_PDB;
grant create table to U1_DDD_PDB;

--7. Подключитесь к пользователю U1_XXX_PDB, с помощью SQL Developer, создайте таблицу XXX_table, добавьте в нее строки, выполните SELECT-запрос к таблице.

create table DDD_table ( x int , y varchar(5));

insert into DDD_table values (1, 'frst');
insert into DDD_table values (3, 'thrd');

select *from DDD_table;

--8. С помощью представлений словаря базы данных определите, все табличные пространства, все  файлы (перманентные и временные), все роли (и выданные им привилегии), профили безопасности, всех пользователей  базы данных XXX_PDB и  назначенные им роли.
select * from DBA_TABLESPACES;
select * from DBA_ROLES;
select * from DBA_PROFILES;
select * from ALL_USERS;

select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;

--9. Подключитесь  к CDB-базе данных, создайте общего пользователя с именем C##XXX, назначьте ему привилегию, позволяющую подключится к базе данных XXX_PDB. Создайте 2 подключения пользователя C##XXX в SQL Developer к CDB-базе данных и  XXX_PDB – базе данных. Проверьте их работоспособность.

GRANT CREATE TABLE TO C##DDD;



--10. Назначьте привилегию, разрешающему подключение к XXX_PDB общему пользователю C##YYY, созданному другим студентом. Убедитесь в работоспособности  этого пользователя в базе данных XXX_PDB.
create user c##ddd1 identified by 12345;

grant create session to c##ddd1;

select *from v$session;

--13. Удалите созданную базу данных XXX_DB. Убедитесь, что все файлы PDB-базы данных удалены. Удалите пользователя C##XXX. Удалите в SQL Developer все подключения к XXX_PDB.
--alter pluggable database mka_pdb unplug into 'C:\app\ora_install_userzmka_pdb.xml';
--drop pluggable database mka_pdb;
--create pluggable database mka_pdb as clone using 'C:\app\ora_install_userzmka_pdb.xml' nocopy tempfile reuse;
create table DDD1_table ( x int , y varchar(5));

insert into DDD1_table values (1, 'frst');
insert into DDD1_table values (3, 'thrd');

select * from DDD1_table;


SELECT owner, object_name, object_type
FROM all_objects
ORDER BY owner, object_name;
