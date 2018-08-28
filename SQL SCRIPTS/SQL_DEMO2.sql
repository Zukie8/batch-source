
SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION HELLO
RETURN VARCHAR2
IS BEGIN
    RETURN 'HELLO WORLD!!';
    END; 
    /  
    
--DROP FUNCTION HELLO;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
    END ;
    /


BEGIN
    DBMS_OUTPUT.PUT_LINE(HELLO());
    END ;
    /
    
-- CREATE A FUNCTION THAT TAKES A NUMERIC VALUE
--AND RETURNS THE SQUARE OF THAT NUMBER
-- the IN, inside the parameter below isnt necesary
CREATE OR REPLACE FUNCTION SQUARE (X IN NUMBER)
RETURN NUMBER
IS
    BEGIN
    RETURN X*X;
    END;
    /
    
--PL/SQL BLOCK
DECLARE 
    N NUMBER : = 5;
BEGIN
    DBMS_OUTPUT.PUT_LINE(SQUARE (N));
END;
/

SELECT MONTHLY_SALARY,SQUARE(MONTHLY_SALARY)
FROM EMPLOYEE;

SELECT 5 AS "NUMBER",SQUARE(5) AS NUMBERSQUARED
FROM DUAL;
--USING A DECALERED VARIABLE WITHIN A FUNCTION DELCARATION
CREATE OR REPLACE FUNCTION SQUARE (X IN NUMBER)
RETURN NUMBER
IS
Y NUMBER;
    BEGIN
    Y:=X*X;
    RETURN Y;
    END;

    
-- find max. 
CREATE OR REPLACE FUNCTION FIND_MAX_NUM(X NUMBER, Y NUMBER)
RETURN NUMBER
IS
    BEGIN
        IF X>Y THEN
        RETURN X;
        ELSE
        RETURN Y;
        END IF;
    END;
/

DECLARE 
    FIRST_NUM NUMBER; 
    SECOND_NUM NUMBER;
    MAX_NUM NUMBER;
    BEGIN
    FIRST_NUM:=25;
    SECOND_NUM:=38;
    MAX_NUM:= FIND_MAX_NUM(FIRST_NUM, SECOND_NUM);
    DBMS_OUTPUT.PUT_LINE('MAX '||MAX_NUM);
    END;
    /

--create a fucntion that calcs sales tax
CREATE OR REPLACE FUNCTION APPLY_TAX(PRE_TAX IN NUMBER)
RETURN NUMBER
IS
--POST_TAX NUMBER;
    BEGIN
    RETURN (0.75)*PRE_TAX;
    END;
/

SELECT MONTHlY_SALARY AS "PRE TAX", APPLY_TAX(MONTHLY_SALARY) AS "POST TAX"
FROM EMPLOYEE;


------CREATING STORED PROCEDURES----------

--BASIC FIRST HELLO WORLD PROCEDURE

CREATE OR REPLACE PROCEDURE HELLO_PROCEDURE
IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
    END;
    /
    
--You can just call procedures, kinda like static methods

BEGIN 
    HELLO_PROCEDURE();
END;
/


CREATE OR REPLACE PROCEDURE GET_ALL_EMPLOYEES(S OUT SYS_REFCURSOR)
--NO RETURN STATEMENT IN PROCEDURES
IS
    BEGIN
    OPEN S FOR 
        SELECT EMP_ID, EMP_NAME
        FROM EMPLOYEE;
    END;
/


DECLARE 
    SVAR SYS_REFCURSOR;
    TEMP_ID EMPLOYEE.EMP_ID%TYPE;--NUMBER;
    TEMP_NAME EMPLOYEE.EMP_NAME%TYPE;--VARCHAR2(50);
BEGIN
    GET_ALL_EMPLOYEES(SVAR);
    LOOP
        FETCH SVAR INTO TEMP_ID, TEMP_NAME; --ACTIVE SET is each row returned
        EXIT WHEN SVAR%NOTFOUND;
        --ANY manipulation to the data would be done here
         DBMS_OUTPUT.PUT_LINE(TEMP_ID || 'IS CURRENT ID, ' ||TEMP_NAME || ' IS CURRENT NAME ');
    END LOOP;
   CLOSE SVAR;
END;
/


--write a procedure that increases the dept monthly budget
--UPDATE DEPARTMENT
--SET MONTHLY_BUDGET = MONTHLY_BUDGET+500
--WHERE DEPT_ID=3; 
--out update statement would not vary much if done multiple times

CREATE OR REPLACE PROCEDURE INCREASE_BUDGET (DEPT IN NUMBER, VAL IN NUMBER)
--CREATE OR REPLACE PROCEDURE INCREASE_BUDGET (DEPT IN DEPARTMENT.DEPT_ID%TYPE, VAL IN DEPARTMEMT.,MONTHLY_BUDGET%TYPE)
--This is a good way of ensuring type safety
IS
    BEGIN
    UPDATE DEPARTMENT
    SET MONTHLY_BUDGET=MONTHLY_BUDGET+VAL
    WHERE DEPT_ID=DEPT;
    END;
    /

BEGIN
    INCREASE_BUDGET(1,6000);
    INCREASE_BUDGET(2,10000);
    INCREASE_BUDGET(3,11000); 
    INCREASE_BUDGET(4,1000);
    INCREASE_BUDGET(5,8000);
    INCREASE_BUDGET(6,9000);
    COMMIT;
END;
/
--DISPLAYING the department budget and how much is being used side by side
SELECT D.DEPT_NAME AS DEPARTMENT, D.MONTHLY_BUDGET AS BUDGET, SUM(E.MONTHLY_SALARY) AS "BUDGET USED"
FROM employee E
JOIN DEPARTMENT D
ON D.DEPT_ID=E.DEPT_ID
GROUP BY D.DEPT_NAME,D.MONTHLY_BUDGET;

BEGIN
--    increase_budget(1,2000);
    INCREASE_BUDGET(1,1000);
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE GIVE_RAISE(INPUT_ID EMPLOYEE.EMP_ID%TYPE, RAISE_AMOUNT EMPLOYEE.MONTHLY_SALARY%TYPE)
IS 
   DEPT_BUDGET DEPARTMENT.MONTHLY_BUDGET%TYPE;
   BUDGET_USED DEPARTMENT.MONTHLY_BUDGET%TYPE;
   EMPLOYEE_NAME EMPLOYEE.EMP_NAME%TYPE;
   EMPLOYEE_NAME EMPLOYEE.EMP_NAME%TYPE;
    BEGIN
    --save the department budget of the employee into the monthly budget
        SELECT MONTHLY_BUDGET INTO DEPT_BUDGET
        FROM DEPARTMENT
        WHERE DEPT_ID=(
            SELECT DEPT_ID
            FROM EMPLOYEE 
            WHERE EMP_ID=INPUT_ID);
           -- dbms_output.put_line(DEPT_BUDGET);
           
           
           SELECT SUM(MONTHLY_SALARY) INTO BUDGET_USED
           FROM EMPLOYEE
           WHERE DEPT_ID=(
            SELECT DEPT_ID
            FROM EMPLOYEE 
            WHERE EMP_ID=INPUT_ID);
            
        IF( (BUDGET_USED+RAISE_AMOUNT) > DEPT_BUDGET ) THEN
            dbms_output.put_line('INSUFFICIENT DEPARTMENT FUNDS');
        ELSE 
        UPDATE EMPLOYEE
        SET MONTHLY_SALARY = MONTHLY_SALARY + RAISE_AMOUNT
        WHERE EMP_ID = INPUT_ID;
        DBMS_OUTPUT.PUT_LINE('RAISE SUCCESS');
        END IF;
            --
    END;
    /
    
    
    BEGIN
        GIVE_RAISE(1,100);
    END;
    /
    
    
-----------------------------------------------
--working with sequences and triggeres
-----------------------------------------------

CREATE SEQUENCE SQ_DEPARTMENT_PK
START WITH 7
INCREMENT BY 1;

--CREATE A TRIGGER THAT USES THIS SEQUENCE TO GEN PK

CREATE OR REPLACE TRIGGER TR_INSERT_DEPARTMENT
BEFORE INSERT ON DEPARTMENT
FOR EACH ROW
BEGIN
 SELECT SQ_DEPARTMENT_PK.NEXTVAL INTO :NEW.DEPT_ID FROM DUAL;
 --SELECT structure always expects a value from a table
 
END; 
/

INSERT INTO DEPARTMENT (DEPT_NAME, MONTHLY_BUDGET) VALUES ('ADVERTISING',11500);
INSERT INTO DEPARTMENT (DEPT_NAME, MONTHLY_BUDGET) VALUES ('ADVERTISING',11500);

CREATE SEQUENCE SQ_EMPLOYEE_PK
START WITH 21
INCREMENT BY 1;

--DROP SEQUENCE SQ_EMPLOYEE_PK;

CREATE OR REPLACE TRIGGER TR_INSERT_EMPLOYEE
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
 SELECT SQ_EMPLOYEE_PK.NEXTVAL INTO :NEW.EMP_ID FROM DUAL;
 --SELECT structure always expects a value from a table
 
END; 
/

INSERT INTO EMPLOYEE (EMP_NAME, BIRTHDAY, MONTHLY_SALARY,HIRE_DATE,POSITION,MANAGER_ID,
DEPT_ID,LOC_ID) VALUES ('GORDON RAMSEY', DATE '1993-11-13', 200, DATE '2017-10-14', 'MK_REP', 1,7,3);

CREATE SEQUENCE SQ_LOCATIONS_PK
START WITH 4
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TR_INSERT_LOCATIONS
BEFORE INSERT ON LOCATIONS
FOR EACH ROW
BEGIN
 SELECT SQ_LOCATIONS_PK.NEXTVAL INTO :NEW.LOC_ID FROM DUAL;
 --SELECT structure always expects a value from a table
 
END; 
/

INSERT INTO LOCATIONS (STREET,CITY,STATE,ZIPCODE ) VALUES('1 WORLD WAY', 'NEW YORK', 'NY', 38490);


---rather then on delete cascade you can create a trigger that would do the same
CREATE OR REPLACE TRIGGER TR_LIMIT_SALARY
BEFORE INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF (:NEW.MONTHLY_SALARY> 10000)THEN
        RAISE_APPLICATION_ERROR(-20101,'SALARY TOO HIGH');

END IF;
END;
/

INSERT INTO EMPLOYEE(MONTHLY_SALARY) VALUES (12000);


