set serveroutput on;

--1--
--Ќайти товары,которые не заказывали сотрудники из офисов ¬осточного региона 
CREATE OR REPLACE PROCEDURE find_products_not_ordered
IS
  CURSOR c_products IS
    SELECT *
    FROM PRODUCTS
    WHERE (MFR_ID, PRODUCT_ID) NOT IN (
      SELECT MFR, PRODUCT
      FROM ORDERS
      JOIN CUSTOMERS ON ORDERS.CUST = CUSTOMERS.CUST_NUM
      JOIN SALESREPS ON CUSTOMERS.CUST_REP = SALESREPS.EMPL_NUM
      JOIN OFFICES ON SALESREPS.REP_OFFICE = OFFICES.OFFICE
      WHERE OFFICES.REGION = 'Eastern'
    );
  v_product PRODUCTS%ROWTYPE;
BEGIN
  OPEN c_products;
  LOOP
    FETCH c_products INTO v_product;
    EXIT WHEN c_products%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_product.MFR_ID || ' ' || v_product.PRODUCT_ID || ' ' || v_product.DESCRIPTION);
  END LOOP;
  CLOSE c_products;
END;

BEGIN
  find_products_not_ordered;
END;


--2--
--найти 3 товара ,которые заказвали меньше всего
CREATE OR REPLACE PROCEDURE FindLeastOrderedProducts2 AS
  v_product_id PRODUCTS.PRODUCT_ID%TYPE;
  v_description PRODUCTS.DESCRIPTION%TYPE;
  v_total_quantity NUMBER;
BEGIN
  FOR rec IN (
    SELECT P.PRODUCT_ID, P.DESCRIPTION, SUM(O.QTY) AS TOTAL_QUANTITY
    FROM PRODUCTS P
    LEFT JOIN ORDERS O ON P.MFR_ID = O.MFR AND P.PRODUCT_ID = O.PRODUCT
    GROUP BY P.PRODUCT_ID, P.DESCRIPTION
    ORDER BY TOTAL_QUANTITY ASC
    FETCH FIRST 3 ROWS ONLY
  ) LOOP
    v_product_id := rec.PRODUCT_ID;
    v_description := rec.DESCRIPTION;
    v_total_quantity := rec.TOTAL_QUANTITY;

    DBMS_OUTPUT.PUT_LINE('Product ID: ' || v_product_id || ', Description: ' || v_description || ', Total Quantity: ' || v_total_quantity);
  END LOOP;
END;

BEGIN
  FindLeastOrderedProducts2;
END;




