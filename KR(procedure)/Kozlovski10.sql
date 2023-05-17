--10 VARIANT

-- 1
CREATE OR REPLACE PROCEDURE CountOrderedProductsByOffice IS
BEGIN
  FOR rec IN (
    SELECT O.REP, COUNT(*) AS TOTAL_ORDERS, SUM(O.QTY) AS TOTAL_QUANTITY
    FROM ORDERS O
    GROUP BY O.REP
    ORDER BY SUM(O.QTY) DESC
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Office: ' || rec.REP || ', Total Orders: ' || rec.TOTAL_ORDERS || ', Total Quantity: ' || rec.TOTAL_QUANTITY);
  END LOOP;
END;

SET SERVEROUTPUT ON;

BEGIN
  CountOrderedProductsByOffice;
END;

--2
CREATE OR REPLACE PROCEDURE FindOfficesByOrderDate AS
BEGIN
  FOR rec IN (
    SELECT DISTINCT O.REP, OF.CITY
    FROM ORDERS O
    JOIN OFFICES OF ON O.REP = OF.OFFICE
    WHERE O.ORDER_DATE BETWEEN '2007-01-01' AND '2008-01-01'
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Office: ' || rec.REP || ', City: ' || rec.CITY);
  END LOOP;
END;

