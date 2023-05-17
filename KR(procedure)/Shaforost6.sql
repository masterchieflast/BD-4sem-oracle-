CREATE OR REPLACE
   PROCEDURE Task1 (
   p_start_date IN DATE,
   p_end_date   IN DATE
) IS
DECLARE offices_arr OFFICES.OFFICE%type;
BEGIN
    SELECT OFFICE INTO offices_arr FROM OFFICES
      WHERE OFFICE NOT IN (SELECT DISTINCT REP_OFFICE FROM ORDERS
         WHERE ORDER_DATE BETWEEN p_start_date AND p_end_date)
   FOR office_rec IN offices; 
   LOOP
      DBMS_OUTPUT.PUT_LINE('ќфис ' || office_rec.OFFICE || ' не имел заказов с ' || p_start_date || ' по ' || p_end_date);
   END LOOP;
END;
BEGIN
    Task_1(TO_DATE('01.01.2007', 'DD.MM.YYYY'), TO_DATE('01.01.2008', 'DD.MM.YYYY'));
END;