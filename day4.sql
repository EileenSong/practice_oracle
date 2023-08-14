/*���̺����*/

CREATE TABLE ex4_1(
    irum VARCHAR2(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
    ,reg_date DATE
    );
    
    --�÷������    
ALTER TABLE ex4_1 RENAME COLUMN irum to nm;

    -- Ÿ�� ����, �����Ͱ� ������ ���� 
ALTER TABLE ex4_1 MODIFY point NUMBER(10);

    --�������� �߰�
ALTER TABLE ex4_1 ADD CONSTRAINTS pk_ex4 PRIMARY KEY(nm);

    --�÷��߰�
ALTER TABLE ex4_1 ADD hp VARCHAR2(20);

 --�÷� ����
ALTER TABLE ex4_1 DROP COLUMN hp; 



select *
from ex4_1;

-------------------------���̺� comment

COMMENT ON TABLE TB_INFO IS '�츮��';
COMMENT ON COLUMN TB_INFO.info_no IS '�⼮��ȣ';
COMMENT ON COLUMN TB_INFO.pc_no IS '��ǻ�͹�ȣ';
COMMENT ON COLUMN TB_INFO.nm IS '�л��̸�';
COMMENT ON COLUMN TB_INFO.email IS '�̸���';
COMMENT ON COLUMN TB_INFO.hobby IS '���';
COMMENT ON COLUMN TB_INFO.mbti IS '�긯��������ǥ';


--���̺��ڸ�Ʈ
select *
from all_tab_comments
where owner = 'java';  


select *
FROM all_col_comments
where comments like '%�̸�%';

CREATE TABLE ex4_2(
    val1 VARCHAR2(10)
    ,val2 NUMBER
    ,val3 DATE
);
INSERT INTO ex4_2(val1, val2, val3)
VALUES('hi', 10, SYSDATE); --���ڿ� '' number Ÿ���� ����
INSERT INTO ex4_2(val3, val2)
VALUES (SYSDATE, 10);

SELECT * FROM ex4_2;
--���̺� ��ü�� ���� �����͸� �����ҋ��� �÷��� �Ƚᵵ ��.

INSERT INTO ex4_2
VALUES('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES(20, SYSDATE); -- ����


CREATE TABLE ex4_3(
    emp_id number
    ,emp_name varchar2(1000)
);

--select ~ insert 
INSERT INTO ex4_3(emp_id, emp_name)
SELECT employee_id
    ,emp_name
FROM employees
WHERE salary> 5000;

select *
from ex4_3;
--���̺� ����

CREATE TABLE ex4_4 AS
SELECT nm, email
FROM tb_info;

select *
from ex4_4;

SELECT *
FROM tb_info;

UPDATE tb_info
SET hobby ='����'
WHERE nm = '������';


SELECT *
FROM ex4_4;
DELETE ex4_4; --��ü ����

DELETE ex4_4
WHERE nm = '���ؼ�';

select *
from tb_info;


SELECT DISTINCT *
From products;


--�ߺ������ϰ� ������ ����
SELECT DISTINCT prod_category
From products;

--�ǻ� �÷�(���̺��� ������ �ִ� �� ó�� ���
--����Ŭ���� �ִ� �� �ѹ�
SELECT ROWNUM  
    ,emp_name
    ,email
FROM employees
WHERE ROWNUM <=10 ;
--�׳� 10�� ��ȸ�ϰ�ʹ�

--NULL (is null or is not null)
SELECT *
FROM employees
--where manager_id ='';
WHERE manager_id IS NULL;

SELECT *
FROM departments
WHERE department_id NOT IN (30, 60);



/*
oracle �����ͺ��̽� �����Լ�
���ڰ���
*/

SELECT LOWER('I LIKE Mac') as lowers
    ,UPPER('I LIKE Mac') as uppers
    ,INITCAP('I LIKE mac') as initcaps
FROM dual; -- �ӽ����̺�


--��ҹ��� �������� �˻��ϴ� ��
SELECT *
FROM employees
--�������� �ٲ��ָ� ��ҹ��� �������� ����
WHERE UPPER(emp_name) LIKE '%' || UPPER('donald')|| '%';

--���ڿ� ���̱�
SELECT emp_name || '��'
FROM employees;

--substr(char, pos, len) ����ڿ� char�� pos��������
--len ���̸�ŭ �ڸ� �� ��ȯ
--pos������ 0�� ���� ������Ʈ �� 1, �� ù��° ���ڿ�
--������ ���� ���ڿ��� �� ������ ������ ����� ��ġ
--len ���� �����Ǹ� pos ��° ���ں��� ������ ��� ���ڸ� ��ȯ
SELECT SUBSTR('ABCD EFG', 1, 4)
      ,SUBSTR('ABCD EFG', -3, 3)
      ,SUBSTR('ABCD EFG', -3, 1)
      ,SUBSTR('ABCD EFG', 5)
FROM dual; 


--�ε���, ������ ã�� ��
SELECT INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����') --����Ʈ 1,1
      ,INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����', 5) --5���� �ε������� ã������ϰڴ�
      ,INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','����', 1, 2) -- ó������ ã�µ� 2��° ������ �ε��� ã�ڴ�
      ,INSTR('���� ���� �ܷο� ����, ���� ���� ���ο� ����','��')
FROM dual;



select cust_name, cust_email, ID, DOMAIN
FROM customers;
--���� �̸��� �ּ��� �̸��� �������� �з����� ����ϼ���.
-- id : %%, domain: $$

--�ϳ��� �Լ��� ���� ����
SELECT INSTR(cust_email, '@'), cust_email --����Ʈ 1,1
     , substr(cust_email, 1, INSTR(cust_email, '@') -1) AS ID
     , substr(cust_email, INSTR(cust_email, '@') +1 ) AS DOMAIN
FROM customers;





--------------------
select *
from tb_info;


SELECT INSTR(MBTI, 'E') --����Ʈ 1,1
from tb_info;


SELECT NM, MBTI
    ,CASE WHEN INSTR(MBTI, 'E') = 1 THEN '������'
    ELSE '������'
    END AS ����������
    
    ,CASE WHEN INSTR(MBTI, 'S') = 1 THEN '������'
    ELSE '������'
    END AS �νĹ��
    
    ,CASE WHEN INSTR(MBTI, 'F') = 1 THEN '������'
    ELSE '�����'
    END AS �Ǵ���
    
    ,CASE WHEN INSTR(MBTI, 'E') = 1 THEN '������'
    ELSE '��ȹ��'
    END AS ��Ȱ���
FROM tb_info;

