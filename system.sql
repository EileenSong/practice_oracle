-- 주석 ctrl + /
-- 계정만들기 오라클 11g 이후에 계정명에 ##을 붙여야 함.
-- 예전 스타일로 계정만들기 위해 아래 스크립트를 실행해야 함.

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--실행문은 ; 단위로 인식함
--실행은 ctrl + etner or 위에 재생 버튼
-- 사용자명 : java , pw : oralce

CREATE USER java IDENTIFIED BY oracle;
--권한설정
GRANT CONNECT, RESOURCE TO java;
-- 테이블 스페이스 접근 권한 권한을 주면 접속이 안됨

GRANT UNLIMITED TABLESPACE TO java;




