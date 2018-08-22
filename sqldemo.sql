-- we can create a comment like this
/*
multi line comment
we can comment on this line too
*/

/*
DDL: data definiITION LANGAUGE
-CREATE
-ALTER
-DROP
-TRUNCATE table-lvl

DML: DATA MANIPULATION LANGUAGE
-INSERT
-SELECT (DQL)
-UPDATE
-DELETE

TCL: TRANSACTION CONTROL LANGUAGE
-COMMIT
-ROLLBACK
-SAVEPOINT

DCL: DATA CONTROL LANGUAGE
-GRANT
-REVOKE
*/

----------------------------------
-- USING DDL TO CREATE OUR TABlES
----------------------------------
-- CREATE OUR DEPT TABLE
CREATE TABLE DEPARTMENT  (
    DEPT_ID NUMBER(5) CONSTRAINT PK_DEPT PRIMARY KEY,
    DEPT_NAME VARCHAR2(50),
    MONTHLY_BUDGET NUMBER(7,2)
);

-- CREATE OUR EMPLOYEE TABLE
CREATE TABLE EMPLOYEE (
    EMP_ID NUMBER(5) CONSTRAINT PK_EMP PRIMARY KEY,
    EMP_NAME VARCHAR2(50),
    BIRTHDAY DATE,
    MONTHLY_SALARY NUMBER(7, 2) NOT NULL,
    HIRE_DATE DATE,
    POSITION VARCHAR2(20),
    MANAGER_ID NUMBER(5),
    DEPT_ID NUMBER(5) CONSTRAINT FK_EMP_DPT REFERENCES DEPARTMENT
);



/*
WE CAN CREATE AN ANONYMOUS CONSTRAINT DURING TABLE DECLARATION,
A NAME CONSTRAINT DURING TABLE DECLARATION
OR A NAMED CONSTRAINT INDEPENDENTLY FROM TABLE DECLARATION,
AFTER OUR TABLE HAS BEEN MADE

CANDIDATE KEY = ANY COLUMN WHICH UNIQUELY IDENTIFIES A ROW
AND THAT WE COULD USE AS A PRIMARY KEY
*/
-- MUST CREATE DEPT BEFORE EMPLOYEE(DUE TO FK)
INSERT INTO DEPARTMENT VALUES (
    1, 'MARKETING', 5000 
);
INSERT INTO DEPARTMENT VALUES (
    2, 'ACCOUNTING', 4000 
);
INSERT INTO DEPARTMENT VALUES (
    3, 'INFORMATION TECHNOLOGY', 4500 
);
INSERT INTO DEPARTMENT VALUES (
    4, 'HUMAN RESOURCES', 3500 
);
INSERT INTO DEPARTMENT VALUES (
    5, 'LEGAL', 2000 
);
INSERT INTO DEPARTMENT VALUES (
    6, 'CUSTOMER SERVICES', 3000 
);
INSERT INTO DEPARTMENT (DEPT_ID, DEPT_NAME) VALUES (
    7, 'SALES'
);


INSERT INTO EMPLOYEE VALUES (
    1, 'JOHN SMITH', DATE '1989-01-05', 2000, DATE '2015-03-08', 
    'MK_REP', NULL, 1
);

INSERT INTO LOCATION VALUES (1, 'Alexandria');
INSERT INTO LOCATION VALUES (2, 'Arlington');
INSERT INTO LOCATION VALUES (3, 'Louisville');
INSERT INTO LOCATION VALUES (4, 'Munfordville');

insert into EMPLOYEE values (1, 'Meryl', '1992-05-04', 3500.87, '2017-08-13', 'MKT', 1, 2);
insert into EMPLOYEE values (2, 'Isis', '1/20/1991', 2284.34, '08/13/2017', 'MKT', 2, 1);
insert into EMPLOYEE values (3, 'Frans', '3/12/1993', 2409.08, '08/17/2016', 'TECH', 4, 1);
insert into EMPLOYEE values (4, 'Bucky', '3/15/1992', 1212.15, '03/1/2017', 'MKT', 1, 3);
insert into EMPLOYEE values (5, 'Avie', '1/31/1995', 4458.42, '012/11/2017', 'Electrical Controls', 2, 3);
insert into EMPLOYEE values (6, 'Juan', '3/27/1996', 1203.84, '08/9/2017', 'Therapeutic Areas', 1, 3);
insert into EMPLOYEE values (7, 'Roslyn', '5/17/1994', 2135.59, '04/10/2017', 'DDR2', 1, 3);
insert into EMPLOYEE values (8, 'Cacilia', '9/9/1994', 4584.05, '05/20/2017', 'Unity3D', 1, 3);



-- ATTEMPTING TO DROP A TABLE WHICH IS REFERENCE BY ANOTHER GIVES ERROR
-- DROP TABLE DEPARTMENT
ALTER TABLE EMPLOYEE DROP CONSTRAINT FK_EMP_DPT;

-- REMOVED FOREIGN KEY SO NOW ABLE TO DROP
--DROP TABLE DEPARTMENT;

-- RECREATING OUR FOREIGN KEY RELATIONSHIP
-- STUDY THIS
ALTER TABLE EMPLOYEE ADD CONSTRAINT FK_EMP_DPT
FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENT(DEPT_ID) ON DELETE CASCADE;
-- ANOTHER OPTION IS ON DELETE SET NULL


-- INSERTING EMPLOYEES INTO OUR EMPLOYEE TABLE
INSERT INTO EMPLOYEE VALUES (
    2, 'JOHN DOE', DATE '1989-01-05', 2000, DATE '2015-03-08', 
    'MK_REP', NULL, 1
);
INSERT INTO EMPLOYEE VALUES (
    3, 'JOHN SMITHEROO', DATE '1995-01-05', 3500, DATE '2015-03-08', 
    'MK_REP', 1, 1
);
INSERT INTO EMPLOYEE VALUES (
    6, 'JANERY SMITH', DATE '1975-01-05', 3600, DATE '2015-03-08', 
    'MK_REP', 2, 2
);
INSERT INTO EMPLOYEE VALUES (
    5, 'JOHN SMITHEROO', DATE '1989-01-05', 2000, DATE '2015-03-08', 
    'MK_REP', 2, 2
);

INSERT INTO EMPLOYEE VALUES (7, 'JOHN SMITH', DATE '1989-01-05', 2000, DATE '2015-03-08', 'MK_REP',NULL,1);
INSERT INTO EMPLOYEE VALUES (8, 'JAMES BOSH', DATE '1990-08-13', 3200, DATE '2013-02-20', 'AC_ACCOUNT',NULL,2);
INSERT INTO EMPLOYEE VALUES (9, 'LISA JACKSON', DATE '1988-10-15', 3800, DATE '2012-03-08', 'IT_PROF',NULL,3);
INSERT INTO EMPLOYEE VALUES (10, 'ANGELA DEAN', DATE '1982-12-07', 2000, DATE '2017-04-12', 'IT_PROF',3,3);
INSERT INTO EMPLOYEE VALUES (11, 'NIGEL OAKS', DATE '1990-07-28', 2200, DATE '2018-07-20', 'MK_REP',1,1);
INSERT INTO EMPLOYEE VALUES (12, 'JAMES BOND', DATE '1992-11-13', 2800, DATE '2017-10-03', 'MK_REP',1,1);
UPDATE EMPLOYEE
SET LOCATION_ID = 1
WHERE EMP_ID = 3;

SELECT *
FROM EMPLOYEE

DELETE FROM EMPLOYEE
WHERE MONTHLY_SALARY > 3500;

-------------------
-- QUERYING THE DB
-------------------

SELECT EMP_NAME, MONTHLY_SALARY
FROM EMPLOYEE
WHERE MANAGER_ID=2;

SELECT * 
FROM EMPLOYEE
WHERE EMP_NAME LIKE 'JOHN %'
ORDER BY MONTHLY_SALARY DESC;

SELECT COUNT(*) AS TOTAL_EMPLOYEES
FROM EMPLOYEE;

-- IMPLICIT AND EXPLICIT ALIASING
--AVERAGE SALARY BY DEPT
SELECT DEPT_ID AS DEPT, ROUND(AVG(MONTHLY_SALARY)) AVG_SALARY
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING DEPT_ID < 2;

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = 1 OR DEPT_ID = 3 OR DEPT_ID = 6;

SELECT *
FROM EMPLOYEE
WHERE DEPT_ID IN (1,3,6);

-- USING SUBQUERIES
SELECT * 
FROM EMPLOYEE
WHERE MONTHLY_SALARY = (SELECT MAX(MONTHLY_SALARY) FROM EMPLOYEE);


-- ADDING ANOTHER TABLE FOR EMPLOYEE LOCATIONS
CREATE TABLE LOCATION (
    LOCATION_ID NUMBER(5),
    STREET VARCHAR2(25),
    CITY VARCHAR2(25),
    STATE VARCHAR2(2),
    ZIPCODE NUMBER(5)
);

ALTER TABLE LOCATION
ADD CONSTRAINT PK_LOCATION PRIMARY KEY (LOCATION_ID);

-- ADD  COLUMN FOR LOCATION ID
ALTER TABLE EMPLOYEE
ADD LOCATION_ID NUMBER(5);
-- ADD THE FK RELATIONSHIP
ALTER TABLE EMPLOYEE
ADD CONSTRAINT FK_EMP_LOCATION
FOREIGN KEY (LOCATION_ID) REFERENCES LOCATION_ID;

INSERT INTO LOCATION VALUES (1, '14 MAIN STREET', 'RESTON', 'VA', 20190);
INSERT INTO LOCATION VALUES (2, '960 TCHOUPITOULAS ST', 'NEW ORLEANS', 'LA', 70118);

----------------
-- JOINS
----------------

-- INNER JOIN
SELECT E.EMP_NAME AS NAME,
D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- JOIN W/OUT JOIN CLAUSE IMPLICIT INNER JOIN
SELECT
    E.EMP_NAME AS NAME,
    D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID;

-- OUTER JOIN
SELECT E.EMP_NAME AS NAME,
D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
FULL JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;


-- LEFT JOIN / RIGHT JOIN
SELECT E.EMP_NAME AS NAME,
D.DEPT_NAME AS DEPARTMENT
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID;

-- SELF JOIN USING AN IMPLICIT INNER JOIN
SELECT
    EMP1.EMP_NAME EMPLOYEE, EMP2.EMP_NAME MANAGER
FROM EMPLOYEE EMP1, EMPLOYEE EMP2
WHERE EMP1.MANAGER_ID = EMP2.EMP_ID;

--CROSS JOIN WITH EVERY EMPLOYEE AND DEPARTMENT
-- EQUIVALENT OF INNER JOIN W/OUT DUPLICATE COL NAMES
SELECT EMP_NAME, DEPT_NAME
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;


-- OUTER JOIN W/ LOCATIONS AND EMPLOYEES
SELECT *
FROM LOCATION
FULL JOIN EMPLOYEE
ON EMPLOYEE.LOCATION_ID = LOCATION.LOCATION_ID;


-- WE CAN STACK JOINS AND JOIN 
-- FROM MORE THAN ONE ONE TABLE
-- QUERYING INFORMATION FROM ALL THREE
SELECT
    E.EMP_NAME NAME,
    D.DEPT_NAME DEPARTMENT,
    -- CONCAT THE STATE
    CONCAT(CONCAT(L.CITY, ', ') L.STATE) LOCATION
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D
ON E.DEPT_ID = D.DEPT_ID
INNER JOIN LOCATION L
ON L.LOCATION_ID = E.LOCATION_ID;


CREATE VIEW MANAGERS AS
SELECT
    EMP1.EMP_NAME EMPLOYEE, EMP2.EMP_NAME MANAGER
FROM EMPLOYEE EMP1, EMPLOYEE EMP2
WHERE EMP1.MANAGER_ID = EMP2.EMP_ID;

--------------
-- SET OPERATORS
-------------
-- UNION
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID=1
UNION
SELECT * FROM EMPLOYEE
WHERE LOCATION_ID=1;

-- UNION ALL
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID=1
UNION ALL
SELECT * FROM EMPLOYEE
WHERE LOCATION_ID=1;

-- INTERSECT
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID=1
INTERSECT
SELECT * FROM EMPLOYEE
WHERE LOCATION_ID=1;

-- MINUS
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID=1
MINUS
SELECT * FROM EMPLOYEE
WHERE LOCATION_ID=1;

------------------
-- USING IN AND EXISTS WITH SUBQUERIES
------------------
SELECT *
FROM DEPARTMENT
WHERE DEPT_ID IN (
    SELECT DEPT_ID
    FROM EMPLOYEE
);

-- EXISTS KEYWORD
