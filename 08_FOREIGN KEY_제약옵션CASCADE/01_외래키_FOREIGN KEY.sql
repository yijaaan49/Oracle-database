/* **********************
--���̺� ������ �������� ����
----�÷��� �����ϸ鼭 �÷��������� �������� ����
--�ܷ�Ű(FOREIGN KEY) �������� ���� ����
--���� : �÷��� REFERENCES ������̺� (����÷�)
***************************/
SELECT * FROM DEPT;
--�÷��������� ��������(�ܷ�Ű) ����
CREATE TABLE EMP01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT(ID) --�ܷ�Ű ����
);
-----
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');

--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated 
--     - parent key not found
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40'); --DEPT ���̺� ���� ������('40')�� �Է¸���
--================================
--�����ͻ��� ���̺� USER_CONS_COLUMNS, USER_CONSTRAINTS ���
--�������� ��ȸ SQL
SELECT * FROM user_cons_columns;
SELECT * FROM user_constraints;
SELECT a.table_name, a.column_name, a.constraint_name
     , b.constraint_type
     , DECODE(b.constraint_type, 
              'P', 'PRIMARY KEY',
              'U', 'UNIQUE',
              'C', 'CHECK OR NOT NULL',
              'R', 'FOREIGN KEY') CONSTRINT_TYPE_DESC
  FROM user_cons_columns A, user_constraints B
 WHERE A.TABLE_NAME = B.TABLE_NAME
   AND a.constraint_name = b.constraint_name
   AND A.TABLE_NAME LIKE 'EMP%'
;
--===================================
--���̺� ���� ������� �������� ����
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --�⺻Ű(PRIMARY KEY) ����
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');

--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated 
--     - parent key not found
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');
-------------------------------------------
--�������Ǹ��� ��������� �����ؼ� ���
--���� : CONSTRAINT ���������̸� ������������
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO),
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10');

INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');

--==========================================
--�⺻Ű(PRIMARY KEY) ������ ����Ű ���
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --�г�
    BAN NUMBER(2), --��
    BUN NUMBER(2), --��ȣ
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
INSERT INTO HSCHOOL VALUES (1,1,1, 'ȫ�浿');
INSERT INTO HSCHOOL VALUES (1,1,2, 'ȫ�浿2');
INSERT INTO HSCHOOL VALUES (1,2,1, 'ȫ�浿3');
INSERT INTO HSCHOOL VALUES (2,1,1, 'ȫ�浿3');

--ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,1, '������');
--=============================================
/* **** �������� �߰�, ���� **********
--�������� �߰�
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� �������� (�÷���);

--�������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
************************************/




