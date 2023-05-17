--- Вариант 3 DRACH KIRILL

--- Найти среднюю цену заказа для каждого покупателя
CREATE OR REPLACE PROCEDURE find_avg_order_p
IS
BEGIN
  FOR cust IN (SELECT CUSTOMERS.CUST_NUM, AVG(ORDERS.AMOUNT) AS avg_order_price
               FROM CUSTOMERS CUSTOMERS
               JOIN ORDERS ORDERS ON CUSTOMERS.CUST_NUM = ORDERS.CUST
               GROUP BY CUSTOMERS.CUST_NUM)
  LOOP
    DBMS_OUTPUT.PUT_LINE('POKUPATEL N=' || cust.CUST_NUM || ': EGO CPEDNAYA CENA ZAKAZA  = ' || cust.avg_order_price);
  END LOOP;
END;

        begin
            find_avg_order_p();
        end;


--- Найти сотрудников, у которых нет заказов

CREATE OR REPLACE PROCEDURE find_employees_without_orders
IS
BEGIN
  FOR emp IN (SELECT SALESREPS.EMPL_NUM, SALESREPS.NAME
              FROM SALESREPS SALESREPS
              LEFT JOIN ORDERS  ON SALESREPS.EMPL_NUM = ORDERS.REP
              WHERE ORDERS.ORDER_NUM IS NULL)
  LOOP
    DBMS_OUTPUT.PUT_LINE('SOTRUDNIC N' || emp.EMPL_NUM || ' (' || emp.NAME || ') NE OFORMIL NI ODNOGO ZAKAZA.');
  END LOOP;
END;


    begin
     find_employees_without_orders();
     end;