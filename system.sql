-- �ּ� ctrl + /
-- ��������� ����Ŭ 11g ���Ŀ� ������ ##�� �ٿ��� ��.
-- ���� ��Ÿ�Ϸ� ��������� ���� �Ʒ� ��ũ��Ʈ�� �����ؾ� ��.

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
--���๮�� ; ������ �ν���
--������ ctrl + etner or ���� ��� ��ư
-- ����ڸ� : java , pw : oralce

CREATE USER java IDENTIFIED BY oracle;
--���Ѽ���
GRANT CONNECT, RESOURCE TO java;
-- ���̺� �����̽� ���� ���� ������ �ָ� ������ �ȵ�

GRANT UNLIMITED TABLESPACE TO java;




