/*
숫자타입(number)
number(p,s) 

앞에는 전체길이, s는 소수점 자리를 의미
p는 소수점 기준으로 모든 유효 숫자 자리수를 의미함
s는 소수점 자리수를 의미함 s는 디폴트 0 
s가 2이면 소수점 2자리까지 반올림
s가 음수이면 소수점 기준 왼쪽 자리수만큼 반올림 

*/

CREATE TABLE ex3_1(
    num1 number(3)        --정수 3자리
    ,num2 number(3,2)     --전체 정수 1자리, 소수점 2자리
    ,num3 number(5, -2)   -- 십의 자리까지 반올림.
);

INSERT INTO ex3_1(num1) values(0.7898);
INSERT INTO ex3_1(num1) values(99.5);
INSERT INTO ex3_1(num1) values(1004);   -- 오류

SELECT *
FROM ex3_1;

INSERT INTO ex3_1(num2) VALUES(0.7898);
INSERT INTO ex3_1(num2) values(1.23456);
INSERT INTO ex3_1(num2) values(32);   -- 오류

SELECT *
FROM ex3_1;


INSERT INTO ex3_1(num3) VALUES(12345.2345);
INSERT INTO ex3_1(num3) values(123459.2345);
INSERT INTO ex3_1(num3) values(123456798.2345);   -- 오류

SELECT *
FROM ex3_1;


-- 테이블 삭제
DROP TABLE ex3_1;

CREATE TABLE ex3_1(
    num1 number(3)        --정수 3자리
    ,num2 number(3,2)     --전체 정수 1자리, 소수점 2자리
    ,num3 number(5, -2)   -- 십의 자리까지 반올림.
);

--테이블 기본 속성 정보 조회
DESC ex3_1;


/*
날짜 데이터 타입(DATE, TIMESTAMP)
*/


CREATE TABLE ex3_2(
    date1 DATE
    ,date2 TIMESTAMP
    );
    
    
-- sysdate 현재시간 date 타입으로, systemstamp 
INSERT INTO ex3_2 VALUES(SYSDATE, SYSTIMESTAMP);
SELECT *
FROM ex3_2;




-- 디폴트 값으로 생성되게 해둠

CREATE TABLE ex3_3(
    user_id VARCHAR(100)
    ,create_dt DATE DEFAULT SYSDATE
    );

INSERT INTO ex3_3 (user_id) VALUES('a100');
SELECT *
FROM ex3_3;

/*
제약조건
NOT NULL 널을 허용하지 않겠다
UNIQUE 중복을 허용하지 않겠다.
CHECK 특정 데이터만 받겠다
PK, 기본키(하나의 테이블에 1개만 설정가능)
    한 행을 구분하는 식별자로 사용(PK로 설정하면 유니크+낫널)
FK, 외래키 다른테이블의 pk를 참조하는 키
*/

CREATE TABLE ex3_4(
    mem_id VARCHAR2(100) NOT NULL UNIQUE
    , mem_nm VARCHAR2(100)
    , mem_email VARCHAR2(100) NOT NULL
    , CONSTRAINT uq_ex3_4 UNIQUE(mem_email)
    );
    
INSERT INTO ex3_4(mem_id, mem_email) VALUES('a001', 'a001@gmail.com');
INSERT INTO ex3_4(mem_id, mem_email) VALUES('a001', 'a001@gmail.com'); -- 오류
INSERT INTO ex3_4(mem_nm) VALUES('팽수'); --오류 id,email notnull
SELECT *
FROM ex3_4;

SELECT *
FROM user_constraints;


CREATE TABLE ex3_5(
    nm varchar2(100)
    ,age number
    ,gender varchar2(1)
    ,CONSTRAINTS ck_ex3_5_age CHECK(age BETWEEN 1 AND 150)
    ,CONSTRAINTS ck_ex3_5_gender CHECK(gender IN('F', 'M'))
    );
    
    
INSERT INTO ex3_5 VALUES ('팽수', 10, 'M');
INSERT INTO ex3_5 VALUES ('팽수', 10, 'A'); -- 오류 f/ m check
INSERT INTO ex3_5 VALUES ('팽수', 151, 'M'); -- 오류 age 사이







/* FK는 참조 테이블의 컬럼은 기본키로 정의*/


--

CREATE TABLE dep(
    deptno NUMBER(3) CONSTRAINT dep_pk_deptno PRIMARY KEY ,
    deptname VARCHAR2(20) ,
    floor NUMBER(5)
);

CREATE TABLE emp(
    empno NUMBER(5) CONSTRAINT emp_pk_employee PRIMARY KEY ,
    empname VARCHAR2(20) ,
    title VARCHAR2(20) ,
    dno NUMBER(3) CONSTRAINT emp_fk_dno REFERENCES dep(deptno),
    salary NUMBER(10)
);
COMMIT;

INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (1, '영업', 8);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (2, '기획', 10);
INSERT INTO DEP (DEPTNO, DEPTNAME, FLOOR) VALUES (3, '개발', 9);


INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (2106, '김창섭', '대리', 2, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3426, '박영권', '과장', 3, 2500000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3011, '이수민', '부장', 1, 3000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (1003, '조민희', '대리', 1, 2000000);
INSERT INTO EMP (EMPNO, EMPNAME, TITLE, DNO, SALARY) VALUES (3427, '최종철', '사원', 3, 1500000);


SELECT *
FROM emp;
SELECT *
FROM dep;


SELECT emp.empname
    ,emp.title
    ,dep.deptname
FROM emp, dep
WHERE emp.dno = dep.deptno;

-- 제약조건도 제거 후 테이블 삭제
drop table dep cascade constraints;
