/*
주석영역
table
1. 테이블명 컬럼명의 최대크기는 30바이트
2. 테이블명 컬럼명으로 예약어는 사용할 수없다
3. 테이블명 컬럼명으로 문자, 숫자, _*, $, # 을 사용할 수 있지만 첫 글자는 문자만 올 수 있음 
4. 한 테이블에 사용한 컬럼은 255개*/

CREATE TABLE ex2_1(
    col1 CHAR(10)
    ,col2 VARCHAR2(10) -- 컬럼은 ,로 구분
    --하나의 컬럼에는 하나의 타입과 사이즈를 가짐.
    );
    --하나의 구문은 세미콜론으로 구분됨
  
  
  --데이터 삽입  
INSERT INTO ex2_1(col1, col2)

VALUES('abc', 'abc'); --문자열은 ''<-- 작은 따옴표로 표시

 --SELECT 데이터 조회
SELECT col1
    ,LENGTH(col1)
    ,col2
    ,LENGTH(col2)
FROM ex2_1;
--데이ㅓㅌ 조작어 (DML, data manipulation Lang)

FROM * -- 전체 컬럼을 의미함

FROM employees;
SELECT emp_name
    ,email
FROM employees;

SELECT emp_name as nm
    ,hire_date hd
    ,salary 봉급
    ,department_id "부서 아이디"
FROM employees;

SELECT emp_name
    ,salary
    ,department_id
FROM employees
WHERE salary >= 12000
AND department_id = 90;

SELECT *
FROM departments
ORDER BY department_id DESC;


--첫번째로 먼저 정리됨
SELECT emp_name
    ,salary
FROM employees
ORDER BY salary, emp_name DESC;


-- 수식연산자 : + - *

SELECT employee_id      as 직원아이디
    ,emp_name           as 직원이름
    ,salary / 30        as 일당
    ,salary             as 월급
    ,salary - salary * 0.1 as 실수령액
    ,salary * 12        as 연봉
FROM employees;


--논리연산자
SELECT * FROM employees WHERE salary = 2600; --같다
SELECT * FROM employees WHERE salary <> 2600; --같지 않다
SELECT * FROM employees WHERE salary != 2600; --같지않다
SELECT * FROM employees WHERE salary < 2600; -- 미만
SELECT * FROM employees WHERE salary > 2600; -- 초과
SELECT * FROM employees WHERE salary <= 2600; -- 이하
SELECT * FROM employees WHERE salary >= 2600; -- 이상

--department 테이블에서 30 부서를 조회하기

SELECT *
FROM departments
WHERE department_id = 30
OR department_id = 60;


SELECT prod_name, prod_category, prod_min_price
FROM products
where prod_min_price >= 30
and prod_min_price <50 
ORDER BY prod_category, prod_min_price DESC;



SELECT cust_name, cust_gender
    ,CASE WHEN cust_gender = 'M' THEN '남자'
          WHEN cust_gender = 'F' THEN '여자'
    
    END AS gender
FROM customers;



SELECT employee_id
    ,emp_name
    ,CASE WHEN salary <= 5000 THEN 'C등급'
          WHEN salary > 5000 AND salary <= 15000 THEN 'B등급'
            ELSE 'A등급'
    END as grade
FROM employees;


-- BETWEEn AND 조건식
SELECT employee_id
    ,salary
FROM employees
WHERE salary BETWEEn 2000 AND 2500;


-- 조건식 in or 의 의미

SELECT employee_id, salary, department_id
FROM employees
WHERE department_id IN(90, 80, 10);

--문자열 연산자 || <-- +
SELECT emp_name || ':' || employee_id as 이름사번
FROM employees;


SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%'; -- A로 시작하는

SELECT emp_name
FROM employees
WHERE emp_name LIKE '%D'; -- D로 끝나는

SELECT emp_name
FROM employees
WHERE emp_name LIKE '%na%'; -- na가 포함되어 있



SELECT emp_name
FROM employees
WHERE department_id = :a;


SELECT emp_name
FROM employees
WHERE emp_name LIKE '%' ||:val||'%';



CREATE TABLE ex2_2(
nm VARCHAR2(20)
);

INSERT INTO ex2_2 VALUES('길동');
INSERT INTO ex2_2 VALUES('홍길동');
INSERT INTO ex2_2 VALUES('길동이');
INSERT INTO ex2_2 VALUES('홍길동상');

SELECT *
FROM ex2_2
WHERE nm LIKE '홍길_';

SELECT *
FROM ex2_2
WHERE nm LIKE '홍길__';


CREATE TABLE students(
stu_id VARCHAR2(12) /* 학번 */
, stu_grade NUMBER(1)/* 학년 */
, stu_semester NUMBER(1) /* 학기 */
, stu_name VARCHAR2(10) /* 학생 이름 */
, stu_birth VARCHAR2(10) /* 학생 생년월일 */
, stu_kor NUMBER(3) /* 국어 점수 */
, stu_eng NUMBER(3) /* 영어 점수 */
, stu_math NUMBER(3) /* 수학 점수 */
, CONSTRAINTS stu_pk PRIMARY KEY (stu_id, stu_grade, stu_semester)
);


select stu_name
    ,stu_grade
    ,(stu_kor + stu_eng +stu_math)/3 as avg
FROM students --1학년 김씨만 조회
WHERE stu_grade = 1
and (stu_kor + stu_eng +stu_math)/3 >= 90;



select cust_name, cust_gender, cust_city, cust_marital_status, cust_year_of_birth
FROM customers
WHERE cust_gender = 'F'
and cust_marital_status = 'single'
and cust_year_of_birth >= 1983
and cust_city like 'Los_Angeles'
ORDER BY cust_name, cust_year_of_birth DESC;


