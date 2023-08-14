
SELECT *
FROM tb_info;

--���̺� ��ü�� ����
SELECT count(*)
FROM tb_info;

--mbti �˰�ʹ�
SELECT mbti
    ,count(*) as cnt
FROM tb_info
GROUP BY mbti
ORDER BY 2 DESC;


/*�����Լ� : ��� �����͸� Ư�� �׷����� ���� ����
�׷쿡 ���� ����, ���, �ִ�, �ּڰ� ���� ���ϴ� �Լ�
COUNT(expr) �ο� ���� ��ȯ�ϴ� �����Լ�
*/

SELECT *
FROM employees;

SELECT COUNT(*) -- null ���� : ���̺��� ��ü ��
      ,COUNT(department_id) -- default : null�� ����
      ,COUNT(ALL department_id) -- �ߺ����� null x: null �� ����
      ,COUNT(DISTINCT department_id) -- �ߺ����� : �ߺ������ϰ� ���� 
      ,COUNT(employee_id)
FROM employees;

 
--�տ� �μ� ���̵� ���� �; ���ϱ׷��� �ƴϱ� ������(Ÿ�� ��Īx)
--GROUP BY�ؼ� �μ����� ����
SELECT SUM(salary)
    ,AVG(salary)
    ,ROUND(AVG(salary),2) --�Ҽ��� 2° �ڸ� ����
    ,MAX(salary)
    ,MIN(salary)
FROM employees
GROUP BY department_id
ORDER BY 1;

--50�� �μ��� �ִ�, �ּ� �޿��� ����ϼ���
SELECT MAX(salary)
      ,MIN(salary)
FROM employees
WHERE department_id = 50;

--ȸ�� ������ ȸ���� ���
--����(ȸ���� ��������)
SELECT mem_job
      ,COUNT(mem_id) as cnt
      ,COUNT(*) as cnt2
FROM member
GROUP BY mem_job
ORDER BY 2 DESC;

SELECT *
FROM kor_loan_status;

--2013�⵵ �Ⱓ�� ���� �� �ܾ�
SELECT period
    ,sum(loan_jan_amt) as ���ܾ�
FROM kor_loan_status
WHERE period like '2013%'
GROUP BY period
ORDER BY 2;

--2013�⵵ ������ �� ���� �ܾ�
SELECT REGION
    ,sum(loan_jan_amt) as ���ܾ�
FROM kor_loan_status
WHERE period like '2013%'
GROUP BY region
ORDER BY 2;

--2013�⵵ ������ /���������� �� ���� �ܾ�
--select ���� ���� �÷��� �����Լ��� �����ϰ�
--Group by ���� ���ԵǾ�� ��.
SELECT REGION
    ,gubun
    ,sum(loan_jan_amt) as ���ܾ�
FROM kor_loan_status
WHERE period like '2013%'
GROUP BY region, gubun
ORDER BY 1;



------------------------------------------------���ε�
--������ �հ�
SELECT substr(PERIOD, 1, 4) as �⵵
    ,region
    ,sum(loan_jan_amt) as ���ܾ� 
FROM kor_loan_status
GROUP BY substr(PERIOD, 1, 4), region
ORDER By 1;

--employees �������� ��� �⵵�� �������� ����Ͻÿ�.
SELECT *
FROM employees;


--������ Ÿ�� 
DESC employees;

SELECT TO_CHAR(hire_date, 'YYYY') as �Ի�⵵
    ,COUNT(employee_id) as ������
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 1;

--�׷��� ����� �����Ϳ� ���� �˻������� ������ Having
--�Ի������� 10�� �̻��� �⵵�� ������ 
SELECT TO_CHAR(hire_date, 'YYYY') as �Ի�⵵
    ,COUNT(employee_id) as ������
FROM employees

GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(employee_id) >= 10
ORDER BY 1;

-- select �� ���� ���� ����
--FROM -> where- >Group by => having -> select -=> order by
--�ۼ�����
--SELECT - FROM - WHERE -GROUP BY - HAVING - ORDER BY


--��� ������ ���ϸ��� ��� �ݾ�(������ 2°�ڸ� ����)
SELECT *
FROM member;

SELECT mem_job
    ,round(avg(mem_mileage), 2) as �Ѹ��ϸ���
FROM member
GROUP by mem_job
HAVING (round(avg(mem_mileage), 2)) >= 3000
ORDER By 2 DESC;







--������ ���ϸ����� �հ� ���ϸ��� ��ü �հ踦 ����Ͻÿ�

SELECT mem_job
    ,SUM(mem_mileage) as �հ�
FROM member
GROUP BY ROLLUP(mem_job);
--�Ѿ� ���ƿø� -> ���� ����� ���� ���


--products ��ǰ���̺��� ī�װ��� ��ǰ���� ��ü ��ǰ ���� ����ϼ���.
SELECT count(prod_category)
FROM products
GROUP BY ROLLUP(prod_category);


-- �Ѿ��� ���� �Ұ谡 ����
SELECT NVL(prod_category, '�� ��') as ī�װ�
    ,prod_subcategory as ����ī�װ�
    ,COUNT(prod_id) as ��ǰ��
FROM products
GROUP BY ROLLUP(prod_category, prod_subcategory);

--�Ʊ��Ѱ�
SELECT substr(PERIOD, 1, 4) as �⵵
    ,region
    ,sum(loan_jan_amt) as ���ܾ� 
FROM kor_loan_status
GROUP BY substr(PERIOD, 1, 4), region
ORDER By 1;


--�Ѿ��߰� ; ����, ��ü �հ谡 �߰��� �Ǿ ����
SELECT substr(PERIOD, 1, 4) as �⵵
    ,region
    ,sum(loan_jan_amt) as ���ܾ� 
FROM kor_loan_status
GROUP BY ROLLUP(substr(PERIOD, 1, 4), region)
ORDER By 1;





-----
SELECT cust_id
    ,cust_name
    ,cust_gender
    ,cust_year_of_birth
FROM customers;

--���� ������ �⵵�� ȸ������ ����Ͻÿ�

SELECT cust_id
    ,cust_name
    ,cust_gender
    ,cust_year_of_birth
FROM customers
GROUP BY cust_gender;


--������ �� Į���� ���� ��찡 ����
SELECT cust_year_of_birth  
    ,SUM(DECODE(cust_gender, 'M', 1, 0)) as ����
    ,SUM(DECODE(cust_gender, 'F', 1, 0)) as ����
FROM customers
GROUP BY ROLLUP(cust_year_of_birth)
ORDER BY 1;



SELECT *
FROM kor_loan_status;

-- ������, �⵵�� �ܾ�
SELECT region
    ,substr(period, 1, 4) as �⵵
    ,SUM(loan_jan_amt) as ���ܾ�
    --������ 2011�� AMT_2011
FROM kor_loan_status
GROUP BY substr(PERIOD, 1, 4), region
ORDER BY 1;
