--1
CREATE OR REPLACE PROCEDURE FindEmployees AS
    CURSOR emp_cursor IS
        SELECT SR.NAME AS EMP_NAME, O.CITY
        FROM SALESREPS SR
        INNER JOIN OFFICES O ON SR.REP_OFFICE = O.OFFICE
        LEFT JOIN ORDERS OD ON SR.EMPL_NUM = OD.REP
        WHERE OD.ORDER_NUM IS NULL OR OD.AMOUNT <= 5000
        ORDER BY O.CITY;

    emp_rec emp_cursor%ROWTYPE;

BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_rec;

        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Employee: ' || emp_rec.EMP_NAME || ', City:' || emp_rec.CITY);
    END LOOP;
    CLOSE emp_cursor;
END;

EXECUTE FindEmployees;

--2
CREATE OR REPLACE PROCEDURE FindOffices AS
    CURSOR office_cursor IS
        SELECT O.OFFICE, O.CITY, O.REGION
        FROM OFFICES O
        INNER JOIN SALESREPS SR ON O.OFFICE = SR.REP_OFFICE
        INNER JOIN CUSTOMERS C ON SR.EMPL_NUM = C.CUST_REP
        INNER JOIN ORDERS OD ON C.CUST_NUM = OD.CUST
        WHERE C.CREDIT_LIMIT > 20000
        GROUP BY O.OFFICE, O.CITY, O.REGION;
    
    OFFICE_ID OFFICES.OFFICE%TYPE;
    OFFICE_CITY OFFICES.CITY%TYPE;
    OFFICE_REGION OFFICES.REGION%TYPE;
BEGIN
    OPEN office_cursor;
    LOOP
        FETCH office_cursor INTO OFFICE_ID, OFFICE_CITY, OFFICE_REGION;
        EXIT WHEN office_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Office: ' || OFFICE_ID || ', City: ' || OFFICE_CITY || ', Region: ' || OFFICE_REGION);
    END LOOP;
    CLOSE office_cursor;
END;

EXECUTE FindOffices;