--        1
SELECT o.OFFICE, AVG(ord.AMOUNT) 
FROM OFFICES o
LEFT JOIN SALESREPS s ON o.MGR = s.EMPL_NUM
LEFT JOIN CUSTOMERS c ON s.EMPL_NUM = c.CUST_REP
LEFT JOIN ORDERS ord ON c.CUST_NUM = ord.CUST
GROUP BY o.OFFICE;

CREATE OR REPLACE PROCEDURE avg_order_price
IS
BEGIN
  FOR rec IN (
    SELECT o.OFFICE, AVG(ord.AMOUNT) AS AVG_AMOUNT
    FROM OFFICES o
    LEFT JOIN SALESREPS s ON o.MGR = s.EMPL_NUM
    LEFT JOIN CUSTOMERS c ON s.EMPL_NUM = c.CUST_REP
    LEFT JOIN ORDERS ord ON c.CUST_NUM = ord.CUST
    GROUP BY o.OFFICE
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE('Office ' || rec.OFFICE || ': Average Order Price = ' || rec.AVG_AMOUNT);
  END LOOP;
END;
BEGIN avg_order_price; END;

--        2
CREATE OR REPLACE PROCEDURE FindTopEmployees AS
    CURSOR top_employees_cursor IS
        SELECT SR.NAME, COUNT(*) AS ORDER_COUNT
        FROM SALESREPS SR
        JOIN CUSTOMERS C ON SR.EMPL_NUM = C.CUST_REP
        JOIN ORDERS O ON C.CUST_NUM = O.CUST
        WHERE C.CREDIT_LIMIT < 30000
        GROUP BY SR.NAME
        ORDER BY ORDER_COUNT DESC
        FETCH FIRST 2 ROWS ONLY;
        
    v_name SALESREPS.NAME%TYPE;
    v_order_count NUMBER;
BEGIN
    OPEN top_employees_cursor;
    LOOP
        FETCH top_employees_cursor INTO v_name, v_order_count;
        EXIT WHEN top_employees_cursor%NOTFOUND;
        
        --                  
        DBMS_OUTPUT.PUT_LINE('Employee: ' || v_name || ', Order Count: ' || v_order_count);
    END LOOP;
    CLOSE top_employees_cursor;
END;
BEGIN FindTopEmployees;END;