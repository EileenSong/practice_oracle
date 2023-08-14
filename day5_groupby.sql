
SELECT *
FROM tb_info;

--테이블 전체의 갯수
SELECT count(*)
FROM tb_info;

--mbti 알고싶다
SELECT mbti
    ,count(*) as cnt
FROM tb_info
GROUP BY mbti
ORDER BY 2 DESC;


/*집계함수 : 대상 데이터를 특정 그룹으로 묶은 다음
그룹에 대한 총합, 평균, 최댓값, 최솟값 등을 구하는 함수
COUNT(expr) 로우 수를 반환하는 집계함수
*/

SELECT *
FROM employees;

SELECT COUNT(*) -- null 포함 : 테이블의 전체 행
      ,COUNT(department_id) -- default : null값 빼고
      ,COUNT(ALL department_id) -- 중복포함 null x: null 값 빼고
      ,COUNT(DISTINCT department_id) -- 중복제거 : 중복제거하고 갯수 
      ,COUNT(employee_id)
FROM employees;

 
--앞에 부서 아이디를 쓰고 싶어도 단일그룹이 아니기 때문에(타입 매칭x)
--GROUP BY해서 부서별로 봐줌
SELECT SUM(salary)
    ,AVG(salary)
    ,ROUND(AVG(salary),2) --소수점 2째 자리 까지
    ,MAX(salary)
    ,MIN(salary)
FROM employees
GROUP BY department_id
ORDER BY 1;

--50번 부서의 최대, 최소 급여를 출력하세요
SELECT MAX(salary)
      ,MIN(salary)
FROM employees
WHERE department_id = 50;

--회원 직업별 회원수 출력
--정렬(회원수 내림차순)
SELECT mem_job
      ,COUNT(mem_id) as cnt
      ,COUNT(*) as cnt2
FROM member
GROUP BY mem_job
ORDER BY 2 DESC;

SELECT *
FROM kor_loan_status;

--2013년도 기간별 대출 총 잔액
SELECT period
    ,sum(loan_jan_amt) as 총잔액
FROM kor_loan_status
WHERE period like '2013%'
GROUP BY period
ORDER BY 2;

--2013년도 지역별 총 대출 잔액
SELECT REGION
    ,sum(loan_jan_amt) as 총잔액
FROM kor_loan_status
WHERE period like '2013%'
GROUP BY region
ORDER BY 2;

--2013년도 지역별 /대출종류별 총 대출 잔액
--select 절에 오는 컬럼은 집계함수를 제외하고
--Group by 절에 포함되어야 함.
SELECT REGION
    ,gubun
    ,sum(loan_jan_amt) as 총잔액
FROM kor_loan_status
WHERE period like '2013%'
GROUP BY region, gubun
ORDER BY 1;



------------------------------------------------업로드
--연도별 합계
SELECT substr(PERIOD, 1, 4) as 년도
    ,region
    ,sum(loan_jan_amt) as 총잔액 
FROM kor_loan_status
GROUP BY substr(PERIOD, 1, 4), region
ORDER By 1;

--employees 직원들의 고용 년도별 직원수를 출력하시오.
SELECT *
FROM employees;


--데이터 타입 
DESC employees;

SELECT TO_CHAR(hire_date, 'YYYY') as 입사년도
    ,COUNT(employee_id) as 직원수
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY')
ORDER BY 1;

--그룹핑 대상의 데이터에 대해 검색조건을 쓰려면 Having
--입사직원이 10명 이상인 년도와 직원수 
SELECT TO_CHAR(hire_date, 'YYYY') as 입사년도
    ,COUNT(employee_id) as 직원수
FROM employees

GROUP BY TO_CHAR(hire_date, 'YYYY')
HAVING COUNT(employee_id) >= 10
ORDER BY 1;

-- select 문 논리적 실행 순서
--FROM -> where- >Group by => having -> select -=> order by
--작성순서
--SELECT - FROM - WHERE -GROUP BY - HAVING - ORDER BY


--멤버 직업별 마일리지 평균 금액(수수점 2째자리 까지)
SELECT *
FROM member;

SELECT mem_job
    ,round(avg(mem_mileage), 2) as 총마일리지
FROM member
GROUP by mem_job
HAVING (round(avg(mem_mileage), 2)) >= 3000
ORDER By 2 DESC;







--직업별 마일리지의 합계 마일리지 전체 합계를 출력하시오

SELECT mem_job
    ,SUM(mem_mileage) as 합계
FROM member
GROUP BY ROLLUP(mem_job);
--롤업 말아올림 -> 집계 결과의 합을 출력


--products 상품테이블의 카테고리별 상품수와 전체 상품 수를 출력하세요.
SELECT count(prod_category)
FROM products
GROUP BY ROLLUP(prod_category);


-- 롤업이 들어가면 소계가 나옴
SELECT NVL(prod_category, '합 계') as 카테고리
    ,prod_subcategory as 서브카테고리
    ,COUNT(prod_id) as 상품수
FROM products
GROUP BY ROLLUP(prod_category, prod_subcategory);

--아까한것
SELECT substr(PERIOD, 1, 4) as 년도
    ,region
    ,sum(loan_jan_amt) as 총잔액 
FROM kor_loan_status
GROUP BY substr(PERIOD, 1, 4), region
ORDER By 1;


--롤업추가 ; 연도, 전체 합계가 추가가 되어서 나옴
SELECT substr(PERIOD, 1, 4) as 년도
    ,region
    ,sum(loan_jan_amt) as 총잔액 
FROM kor_loan_status
GROUP BY ROLLUP(substr(PERIOD, 1, 4), region)
ORDER By 1;





-----
SELECT cust_id
    ,cust_name
    ,cust_gender
    ,cust_year_of_birth
FROM customers;

--남녀 구분한 년도별 회원수를 출력하시오

SELECT cust_id
    ,cust_name
    ,cust_gender
    ,cust_year_of_birth
FROM customers
GROUP BY cust_gender;


--집계할 때 칼럼을 쓰는 경우가 많다
SELECT cust_year_of_birth  
    ,SUM(DECODE(cust_gender, 'M', 1, 0)) as 남자
    ,SUM(DECODE(cust_gender, 'F', 1, 0)) as 여자
FROM customers
GROUP BY ROLLUP(cust_year_of_birth)
ORDER BY 1;



SELECT *
FROM kor_loan_status;

-- 지역별, 년도별 잔액
SELECT region
    ,substr(period, 1, 4) as 년도
    ,SUM(loan_jan_amt) as 총잔액
    --강원의 2011을 AMT_2011
FROM kor_loan_status
GROUP BY substr(PERIOD, 1, 4), region
ORDER BY 1;
