--1 Найти товары, которые заказывали сотридники из офисов Восточного региона

CREATE OR REPLACE PROCEDURE FIND_PRODUCTS_EA
AS
BEGIN
    FOR product IN (
        SELECT DISTINCT P.DESCRIPTION
        FROM PRODUCTS P
                 JOIN ORDERS O ON P.MFR_ID = O.MFR AND P.PRODUCT_ID = O.PRODUCT
                 JOIN SALESREPS S ON O.REP = S.EMPL_NUM
                 JOIN OFFICES OFF ON S.REP_OFFICE = OFF.OFFICE
        WHERE OFF.REGION = 'Eastern'
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('product from Eastern region: ' || product.DESCRIPTION);
        END LOOP;
END;

begin
    FIND_PRODUCTS_EA();
end;

--2 Подсчитать среднию цену товара для каждого сотрудника и найти тех, у кого средняя цена больше 600

CREATE OR REPLACE PROCEDURE CALCULATE_AVERAGE_PRICE
    IS
BEGIN
    FOR emp IN (
        SELECT s.NAME AS EMPLOYEE_NAME, ROUND(AVG(p.PRICE), 2) AS AVERAGE_PRODUCT_PRICE
        FROM SALESREPS s
                 JOIN ORDERS o ON s.EMPL_NUM = o.REP
                 JOIN PRODUCTS p ON o.MFR = p.MFR_ID AND o.PRODUCT = p.PRODUCT_ID
        GROUP BY s.NAME
        HAVING AVG(p.PRICE) > 600
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Employee: ' || emp.EMPLOYEE_NAME || ', Average Product Price: ' ||
                                 emp.AVERAGE_PRODUCT_PRICE);
        END LOOP;
END;

begin
    CALCULATE_AVERAGE_PRICE();
end;