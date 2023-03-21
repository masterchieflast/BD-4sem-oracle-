CREATE TABLE DDD_T( x number(3) primary key, s varchar(50));

INSERT ALL
    INTO DDD_T (x, s) VALUES (1, 'a')
    INTO DDD_T (x, s) VALUES (2, 'b')
    INTO DDD_T (x, s) VALUES (3, 'c')
    SELECT * FROM dual;
COMMIT;

UPDATE DDD_T SET x = 99, s = 'someone' WHERE x = 1;
UPDATE DDD_T SET x = 999, s = 'help' WHERE x = 2;
COMMIT;

SELECT * FROM DDD_T WHERE s = 'help';
SELECT max(x) FROM DDD_T;

DELETE FROM DDD_t WHERE x = 3;
COMMIT;
Rollback;

DELETE FROM DDD_T;
ALTER TABLE DDD_T ADD p_id int primary key;

CREATE TABLE DDD_t_child 
(
    a number(3), 
    b varchar2(50),
    constraint id_pk foreign key (a) REFERENCES DDD_T(p_id)
);

INSERT ALL
    INTO DDD_T (p_id, x, s) VALUES (1, 66, 'help me')
    INTO DDD_T (p_id, x, s) VALUES (2, 666, 'save me')
SELECT * FROM dual;
COMMIT;

INSERT ALL
    INTO DDD_t_child (a,b) VALUES (1, 'so')
    INTO DDD_t_child (a,b) VALUES (2, 'sad')
SELECT * FROM dual;
COMMIT;

SELECT * FROM DDD_T t LEFT OUTER JOIN DDD_t_child t1 ON t.p_id = t1.a;
SELECT * FROM DDD_T t RIGHT JOIN DDD_t_child t1 ON t.p_id = t1.a;
SELECT * FROM DDD_T t INNER JOIN DDD_t_child t1 ON t.p_id = t1.a;

DROP TABLE DDD_T;
DROP TABLE DDD_t_child;