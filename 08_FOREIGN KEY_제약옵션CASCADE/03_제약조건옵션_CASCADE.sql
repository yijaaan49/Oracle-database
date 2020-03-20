/* **** �������� �ɼ� **********
CASCADE : �θ����̺��� ���������� ��Ȱ��ȭ (����) ��Ű�鼭
    �����ϰ� �ִ� �ڳ�(SUB) ���̺��� �������Ǳ��� ��Ȱ��ȭ(����)
*****************************/
--(�ǽ�) EMP02, EMP03 �ܷ�Ű(FOREIGN KEY) �̸� ���� ó��
---------EMP02 : EMP02_DEPTNO_FK, EMP03: EMP03_DEPTNO_FK
ALTER TABLE EMP02 DROP CONSTRAINT EMP02_DEPTNO_FK;
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

ALTER TABLE DEPT DROP CONSTRAINT SYS_C007041;
ALTER TABLE EMP03 ADD CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);

ALTER TABLE EMP01 DROP CONSTRAINT EMP01_DEPTNO_FK;
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(ID);
ALTER TABLE EMP01 
    ADD CONSTRAINT EMP01_DEPTNO_FK 
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);
--DEPT ���̺�(�θ����̺�)�� PRIMARY KEY DISABLE(��Ȱ��ȭ) ó��
--cannot disable constraint - dependencies exist
ALTER TABLE DEPT DISABLE PRIMARY KEY;

--���1 : �ڳ����̺��� ����Ű ��� ���� OR ��Ȱ��ȭ
ALTER TABLE EMP01 DROP CONSTRAINT EMP01_DEPTNO_FK; --DROP > DISABLE

ALTER TABLE DEPT DISABLE PRIMARY KEY; --�������̺��� �����Ƿ� ��ü ó����

--DEPT ���̺� PK ���� �� �ڳ����̺� �ܷ�Ű Ȱ��ȭ
ALTER TABLE DEPT ENABLE PRIMARY KEY;

ALTER TABLE EMP01 ADD CONSTRAINT EMP01_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT(ID);
ALTER TABLE EMP03 ADD CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);
ALTER TABLE EMP02 ADD CONSTRAINT EMP02_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);
----
ALTER TABLE DEPT DISABLE PRIMARY KEY; --���� �ܷ�Ű �־ ���� ó�� �ȵ�
--���2 : DEPT ���̺��� PK ��Ȱ��ȭ ��Ű�鼭 EMP01~03 �Բ� ��Ȱ��ȭ ó��
---------CASCADE �ɼ� ��� : �θ����̺� PK + �ڳ����̺� FK ���ÿ� ��Ȱ��ȭ ó��
ALTER TABLE DEPT DISABLE PRIMARY KEY CASCADE; --CASCADE �����ϰ� �ִ� �͵��� ����ó��
------------------------------------------------------
/* �������� �ɼ� : NO DELETE CASCADE
--���̺��� ���迡�� �θ����̺�(������) ������ 
  �ڳ����̺�(������)�� �Բ� ���� ó��
********************************/
CREATE TABLE C_TEST_MAIN (
    MAIN_PK NUMBER PRIMARY KEY,
    MAIN_DATA VARCHAR2(30)
    
);

CREATE TABLE C_TEST_SUB ( 
    SUB_PK NUMBER PRIMARY KEY,
    SUB_DATA VARCHAR2(30),
    SUB_FK NUMBER,
    CONSTRAINT C_TEST_SUB_FK FOREIGN KEY (SUB_FK)
    REFERENCES C_TEST_MAIN (MAIN_PK) ON DELETE CASCADE
);

------------------------------
INSERT INTO C_TEST_MAIN VALUES (11111, '1�� ���� ������');
INSERT INTO C_TEST_MAIN VALUES (22222, '2�� ���� ������');
INSERT INTO C_TEST_MAIN VALUES (33333, '3�� ���� ������');
COMMIT;
--
INSERT INTO C_TEST_SUB VALUES (1, '1�� SUB ������', 11111);
INSERT INTO C_TEST_SUB VALUES (2, '2�� SUB ������', 22222);
INSERT INTO C_TEST_SUB VALUES (3, '2�� SUB ������', 33333);
COMMIT;
---�������̺� ������ ����
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 11111;
COMMIT;
DELETE FROM C_TEST_MAIN WHERE MAIN_PK = 33333;
COMMIT;
SELECT * FROM C_TEST_MAIN;
SELECT * FROM C_TEST_SUB;

--=============

--���̺� ���� : �θ����̺� - �ڳ����̺� ���� ������ �θ����̺� ����
DROP TABLE C_TEST_MAIN ;
--���1 : �������̺��� ��� �����ϰ� �θ����̺��� ����ó��
DROP TABLE C_TEST_SUB;
DROP TABLE C_TEST_MAIN ;
--���2 : �������̺� �ִ� FK������ ��� �����Ŀ� �θ����̺� ����
-------FK ��Ȱ��ȭ (DISABLE) �������δ� �ȵȴ�.
ALTER TABLE C_TEST_SUB DROP CONSTRAINT C_TEST_SUB_FK;--�������� ����
DROP TABLE C_TEST_MAIN;
--���3 : �θ����̺� ������ CASCADE CONSTRAINTS �ɼ��� ���
------�������̺��� ��������(FK) ������ �θ����̺� (MAIN) ���� ó��
DROP TABLE C_TEST_MAIN CASCADE CONSTRAINTS; --�������̺� �������� ���ſ� ����ó�� 
--==========================================



