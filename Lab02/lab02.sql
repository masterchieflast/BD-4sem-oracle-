create tablespace TS_DDD    
  datafile 'TS_DDD.dbf'
  size 7M
  autoextend on next 5M
  maxsize 30M;

create temporary tablespace TS_DDD_TEMP
  tempfile 'TS_DDD_TEMP.dbf'
  size 5M
  autoextend on next 3M
  maxsize 20M;

create user C##DDDCORE identified by 3546
  default tablespace TS_DDD quota unlimited on TS_DDD
  temporary tablespace TS_DDD_TEMP
  profile c##PF_DDDCORE
  account unlock 
  password expire;


select tablespace_name, status, contents logging from dba_tablespaces;
select file_name, tablespace_name, status from  dba_data_files
union

alter session set "_ORACLE_SCRIPT"=true;

create role RL_DDDCORE;
grant create session,
      create table, drop any table, 
      create view, drop any view,
      create procedure, drop any procedure
      to RL_DDDCORE;
      

select * from dba_roles where role like 'RL%';
select * from dba_sys_privs where grantee = 'RL_DDDCORE';

create profile PF_DDDCORE limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30;

select * from dba_profiles where profile = 'PF_DDDCORE';
select * from dba_profiles where profile = 'DEFAULT';

create user C##U_DDDCORE identified by 12345
  default tablespace TS_DDD quota unlimited on TS_DDD
  temporary tablespace TS_DDD_TEMP
  profile C##PF_DDDCORE
  account unlock 
  password expire;
  
grant RL_DDDCORE to U_DDDCORE;

CREATE TABLE DDD_U2( x number(3), s varchar2(50));

INSERT ALL
    INTO DDD_U2 (x, s) VALUES (1, 'a')
    INTO DDD_U2 (x, s) VALUES (2, 'b')
    INTO DDD_U2 (x, s) VALUES (3, 'c')
SELECT * FROM dual;
COMMIT;
SELECT * FROM DDD_U2;

create tablespace DDD_QDATA
  datafile '/home/oracle/.sqldeveloper/DDD_QDATA.dbf'
  size 10M
  autoextend on next 5M
  maxsize 20M
  offline;
  
alter tablespace DDD_QDATA online;

create user DDD identified by 12345
  default tablespace DDD_QDATA quota 2M on DDD_QDATA
  temporary tablespace TS_DDD_TEMP
  profile PF_DDDCORE
  account unlock 
  password expire;
  
grant RL_DDDCORE to DDD;

create tablespace DDD_T1
  datafile '/home/oracle/.sqldeveloper/DDD_T1.dbf'
  size 10M
  autoextend on next 5M
  maxsize 20M;

create table DDD_T2
( 
  x number(3), 
  s varchar2(50)
) tablespace DDD_T1;

INSERT ALL
    INTO DDD_T2 (x, s) VALUES (1, 'a')
    INTO DDD_T2 (x, s) VALUES (2, 'b')
    INTO DDD_T2 (x, s) VALUES (3, 'c')
SELECT * FROM dual;
COMMIT;

select * from dba_tablespaces;
select * from DDD_t2;