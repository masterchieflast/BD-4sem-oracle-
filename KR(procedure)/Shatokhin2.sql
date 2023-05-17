CREATE OR REPLACE PROCEDURE get_high_orders AS
   v_name SALESREPS.NAME%TYPE;
   v_total_amount NUMBER;
BEGIN
   FOR rec IN (
      SELECT s.NAME, SUM(o.AMOUNT) AS TOTAL_AMOUNT
      FROM SALESREPS s
      JOIN ORDERS o ON s.EMPL_NUM = o.REP
      WHERE o.AMOUNT > 2000
      GROUP BY s.NAME
      ORDER BY TOTAL_AMOUNT DESC
   )
   LOOP
      v_name := rec.NAME;
      v_total_amount := rec.TOTAL_AMOUNT;
      DBMS_OUTPUT.PUT_LINE(v_name||CHR(9)||v_total_amount);
   END LOOP;
END get_high_orders;
/

SET SERVEROUTPUT ON SIZE UNLIMITED;
 BEGIN DBMS_OUTPUT. ENABLE (buffer_size => NULL); END;

BEGIN
   get_high_orders;
END;