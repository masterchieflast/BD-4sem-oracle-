

--задание 2

CREATE OR REPLACE PROCEDURE FIND_TOP_CUSTOMERS AS
  v_company VARCHAR(20);
  v_total_purchases NUMBER;
BEGIN

  BEGIN
    SELECT C.COMPANY, COUNT(*) AS TOTAL_PURCHASES
    INTO v_company, v_total_purchases
    FROM CUSTOMERS C
    JOIN ORDERS O ON C.CUST_NUM = O.CUST
    WHERE C.CREDIT_LIMIT < 5000
    GROUP BY C.COMPANY
    ORDER BY TOTAL_PURCHASES DESC
    FETCH FIRST 3 ROWS ONLY;
    DBMS_OUTPUT.PUT_LINE('Company: ' || v_company || ', Total Purchases: ' || v_total_purchases);
      -- Обработка исключения, если нет данных
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No data found');
  END;
END;
/

BEGIN
FIND_TOP_CUSTOMERS;
    END;


--задание 1

CREATE OR REPLACE PROCEDURE FIND_AVG_PRODUCT_PRICE IS
    avg_price DECIMAL(9, 2);
BEGIN
    SELECT AVG(p.PRICE) INTO avg_price
    FROM PRODUCTS p
    JOIN ORDERS o ON p.MFR_ID = o.MFR AND p.PRODUCT_ID = o.PRODUCT
    JOIN SALESREPS s ON o.REP = s.EMPL_NUM
        -- так как of зарезервированное слово взяли его в ""
    JOIN OFFICES "of" ON s.REP_OFFICE = "of".OFFICE
    WHERE "of".REGION = 'Western';

    DBMS_OUTPUT.PUT_LINE('res: ' || avg_price);
END;
/


BEGIN
    FIND_AVG_PRODUCT_PRICE;
END;

commit;

