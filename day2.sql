/*
�ּ�����
table
1. ���̺�� �÷����� �ִ�ũ��� 30����Ʈ
2. ���̺�� �÷������� ������ ����� ������
3. ���̺�� �÷������� ����, ����, _*, $, # �� ����� �� ������ ù ���ڴ� ���ڸ� �� �� ���� 
4. �� ���̺� ����� �÷��� 255��*/

CREATE TABLE ex2_1(
    col1 CHAR(10)
    ,col2 VARCHAR2(10) -- �÷��� ,�� ����
    --�ϳ��� �÷����� �ϳ��� Ÿ�԰� ����� ����.
    );
    --�ϳ��� ������ �����ݷ����� ���е�
  
  
  --������ ����  
INSERT INTO ex2_1(col1, col2)

VALUES('abc', 'abc'); --���ڿ��� ''<-- ���� ����ǥ�� ǥ��

 --SELECT ������ ��ȸ
SELECT col1
    ,LENGTH(col1)
    ,col2
    ,LENGTH(col2)
FROM ex2_1;
--���̤ä� ���۾� (DML, data manipulation Lang)

FROM * -- ��ü �÷��� �ǹ���

FROM employees;
SELECT emp_name
    ,email
FROM employees;

SELECT emp_name as nm
    ,hire_date hd
    ,salary ����
    ,department_id "�μ� ���̵�"
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


--ù��°�� ���� ������
SELECT emp_name
    ,salary
FROM employees
ORDER BY salary, emp_name DESC;


-- ���Ŀ����� : + - *

SELECT employee_id      as �������̵�
    ,emp_name           as �����̸�
    ,salary / 30        as �ϴ�
    ,salary             as ����
    ,salary - salary * 0.1 as �Ǽ��ɾ�
    ,salary * 12        as ����
FROM employees;


--��������
SELECT * FROM employees WHERE salary = 2600; --����
SELECT * FROM employees WHERE salary <> 2600; --���� �ʴ�
SELECT * FROM employees WHERE salary != 2600; --�����ʴ�
SELECT * FROM employees WHERE salary < 2600; -- �̸�
SELECT * FROM employees WHERE salary > 2600; -- �ʰ�
SELECT * FROM employees WHERE salary <= 2600; -- ����
SELECT * FROM employees WHERE salary >= 2600; -- �̻�

--department ���̺��� 30 �μ��� ��ȸ�ϱ�

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
    ,CASE WHEN cust_gender = 'M' THEN '����'
          WHEN cust_gender = 'F' THEN '����'
    
    END AS gender
FROM customers;



SELECT employee_id
    ,emp_name
    ,CASE WHEN salary <= 5000 THEN 'C���'
          WHEN salary > 5000 AND salary <= 15000 THEN 'B���'
            ELSE 'A���'
    END as grade
FROM employees;


-- BETWEEn AND ���ǽ�
SELECT employee_id
    ,salary
FROM employees
WHERE salary BETWEEn 2000 AND 2500;


-- ���ǽ� in or �� �ǹ�

SELECT employee_id, salary, department_id
FROM employees
WHERE department_id IN(90, 80, 10);

--���ڿ� ������ || <-- +
SELECT emp_name || ':' || employee_id as �̸����
FROM employees;


SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%'; -- A�� �����ϴ�

SELECT emp_name
FROM employees
WHERE emp_name LIKE '%D'; -- D�� ������

SELECT emp_name
FROM employees
WHERE emp_name LIKE '%na%'; -- na�� ���ԵǾ� ��



SELECT emp_name
FROM employees
WHERE department_id = :a;


SELECT emp_name
FROM employees
WHERE emp_name LIKE '%' ||:val||'%';



CREATE TABLE ex2_2(
nm VARCHAR2(20)
);

INSERT INTO ex2_2 VALUES('�浿');
INSERT INTO ex2_2 VALUES('ȫ�浿');
INSERT INTO ex2_2 VALUES('�浿��');
INSERT INTO ex2_2 VALUES('ȫ�浿��');

SELECT *
FROM ex2_2
WHERE nm LIKE 'ȫ��_';

SELECT *
FROM ex2_2
WHERE nm LIKE 'ȫ��__';


CREATE TABLE students(
stu_id VARCHAR2(12) /* �й� */
, stu_grade NUMBER(1)/* �г� */
, stu_semester NUMBER(1) /* �б� */
, stu_name VARCHAR2(10) /* �л� �̸� */
, stu_birth VARCHAR2(10) /* �л� ������� */
, stu_kor NUMBER(3) /* ���� ���� */
, stu_eng NUMBER(3) /* ���� ���� */
, stu_math NUMBER(3) /* ���� ���� */
, CONSTRAINTS stu_pk PRIMARY KEY (stu_id, stu_grade, stu_semester)
);


select stu_name
    ,stu_grade
    ,(stu_kor + stu_eng +stu_math)/3 as avg
FROM students --1�г� �达�� ��ȸ
WHERE stu_grade = 1
and (stu_kor + stu_eng +stu_math)/3 >= 90;



select cust_name, cust_gender, cust_city, cust_marital_status, cust_year_of_birth
FROM customers
WHERE cust_gender = 'F'
and cust_marital_status = 'single'
and cust_year_of_birth >= 1983
and cust_city like 'Los_Angeles'
ORDER BY cust_name, cust_year_of_birth DESC;


