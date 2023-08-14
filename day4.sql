/*테이블수정*/

CREATE TABLE ex4_1(
    irum VARCHAR2(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
    ,reg_date DATE
    );
    
    --컬럼명수정    
ALTER TABLE ex4_1 RENAME COLUMN irum to nm;

    -- 타입 수정, 데이터가 있으면 주의 
ALTER TABLE ex4_1 MODIFY point NUMBER(10);

    --제약조건 추가
ALTER TABLE ex4_1 ADD CONSTRAINTS pk_ex4 PRIMARY KEY(nm);

    --컬럼추가
ALTER TABLE ex4_1 ADD hp VARCHAR2(20);

 --컬럼 삭제
ALTER TABLE ex4_1 DROP COLUMN hp; 



select *
from ex4_1;

-------------------------테이블 comment

COMMENT ON TABLE TB_INFO IS '우리반';
COMMENT ON COLUMN TB_INFO.info_no IS '출석번호';
COMMENT ON COLUMN TB_INFO.pc_no IS '컴퓨터번호';
COMMENT ON COLUMN TB_INFO.nm IS '학생이름';
COMMENT ON COLUMN TB_INFO.email IS '이메일';
COMMENT ON COLUMN TB_INFO.hobby IS '취미';
COMMENT ON COLUMN TB_INFO.mbti IS '브릭스유형지표';


--테이블코멘트
select *
from all_tab_comments
where owner = 'java';  


select *
FROM all_col_comments
where comments like '%이름%';

CREATE TABLE ex4_2(
    val1 VARCHAR2(10)
    ,val2 NUMBER
    ,val3 DATE
);
INSERT INTO ex4_2(val1, val2, val3)
VALUES('hi', 10, SYSDATE); --문자열 '' number 타입은 숫자
INSERT INTO ex4_2(val3, val2)
VALUES (SYSDATE, 10);

SELECT * FROM ex4_2;
--테이블 전체에 대해 데이터를 삽입할떄는 컬럼명 안써도 됨.

INSERT INTO ex4_2
VALUES('hello', 20, SYSDATE);
INSERT INTO ex4_2
VALUES(20, SYSDATE); -- 오류


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
--테이블 복사

CREATE TABLE ex4_4 AS
SELECT nm, email
FROM tb_info;

select *
from ex4_4;

SELECT *
FROM tb_info;

UPDATE tb_info
SET hobby ='공부'
WHERE nm = '송현지';


SELECT *
FROM ex4_4;
DELETE ex4_4; --전체 삭제

DELETE ex4_4
WHERE nm = '예준서';

select *
from tb_info;


SELECT DISTINCT *
From products;


--중복제거하고 데이터 보기
SELECT DISTINCT prod_category
From products;

--의사 컬럼(테이블에는 없지만 있는 것 처럼 사용
--오라클에만 있는 로 넘버
SELECT ROWNUM  
    ,emp_name
    ,email
FROM employees
WHERE ROWNUM <=10 ;
--그냥 10명만 조회하고싶다

--NULL (is null or is not null)
SELECT *
FROM employees
--where manager_id ='';
WHERE manager_id IS NULL;

SELECT *
FROM departments
WHERE department_id NOT IN (30, 60);



/*
oracle 데이터베이스 내장함수
문자관련
*/

SELECT LOWER('I LIKE Mac') as lowers
    ,UPPER('I LIKE Mac') as uppers
    ,INITCAP('I LIKE mac') as initcaps
FROM dual; -- 임시테이블


--대소문자 구별없이 검색하는 것
SELECT *
FROM employees
--한쪽으로 바꿔주면 대소문자 구별없이 가능
WHERE UPPER(emp_name) LIKE '%' || UPPER('donald')|| '%';

--문자열 붙이기
SELECT emp_name || '님'
FROM employees;

--substr(char, pos, len) 대상문자열 char의 pos번쨰부터
--len 길이만큼 자른 뒤 반환
--pos값으로 0이 오면 디폴ㄹ트 값 1, 즉 첫번째 문자열
--음수가 오면 문자열의 맨 끝에서 시작한 상대적 위치
--len 값이 생략되면 pos 번째 문자부터 나머지 모든 문자를 반환
SELECT SUBSTR('ABCD EFG', 1, 4)
      ,SUBSTR('ABCD EFG', -3, 3)
      ,SUBSTR('ABCD EFG', -3, 1)
      ,SUBSTR('ABCD EFG', 5)
FROM dual; 


--인덱스, 시작점 찾는 것
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약') --디폴트 1,1
      ,INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약', 5) --5번쨰 인덱스에서 찾기시작하겠다
      ,INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','만약', 1, 2) -- 처음부터 찾는데 2번째 나오는 인덱스 찾겠다
      ,INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면','나')
FROM dual;



select cust_name, cust_email, ID, DOMAIN
FROM customers;
--고객의 이메일 주소의 이름과 도메인을 분류히여 출력하세요.
-- id : %%, domain: $$

--하나의 함수로 보고 대입
SELECT INSTR(cust_email, '@'), cust_email --디폴트 1,1
     , substr(cust_email, 1, INSTR(cust_email, '@') -1) AS ID
     , substr(cust_email, INSTR(cust_email, '@') +1 ) AS DOMAIN
FROM customers;





--------------------
select *
from tb_info;


SELECT INSTR(MBTI, 'E') --디폴트 1,1
from tb_info;


SELECT NM, MBTI
    ,CASE WHEN INSTR(MBTI, 'E') = 1 THEN '외향형'
    ELSE '내향형'
    END AS 에너지방향
    
    ,CASE WHEN INSTR(MBTI, 'S') = 1 THEN '감각형'
    ELSE '직관형'
    END AS 인식방식
    
    ,CASE WHEN INSTR(MBTI, 'F') = 1 THEN '감정형'
    ELSE '사고형'
    END AS 판단형
    
    ,CASE WHEN INSTR(MBTI, 'E') = 1 THEN '자율형'
    ELSE '계획형'
    END AS 생활양식
FROM tb_info;

