/* (�ǽ�) ���̺�� : TEST2
    NO : ����Ÿ�� 5�ڸ�, PRIMARY KEY ����
    ID : ����Ÿ�� 10�ڸ�(����10�ڸ�), ���� �ݵ�� ����
    NAME : �ѱ� 10�ڸ� ���尡����� ����, ���� �ݵ�� ����
    EMAIL : ����, ����, Ư������ ���� 30�ڸ� 
    ADDRESS : �ѱ� 100�ڸ�
    IDNUM : ����Ÿ�� ������ 7�ڸ�, �Ҽ��� 3�ڸ�(1234567.789)
    REGDATE : ��¥Ÿ��
*****************************/

CREATE TABLE TEST2  
(   
    NO NUMBER(5)PRIMARY KEY,
    ID VARCHAR2(10) NOT NULL,
    NAME NVARCHAR2(10) NOT NULL,
    EMAIL VARCHAR2(30),
    ADDRESS NVARCHAR2(100),
    IDNUM NUMBER(10,3),
    REGDATE DATE
);
ALTER TABLE TEST2 MODIFY(IDNUM NUMBER(10,3));

INSERT INTO TEST2 (NO,ID,NAME) VALUES('2','SIN','��������');
SELECT * FROM TEST2;
INSERT INTO TEST2 (NO) VALUES ('');
UPDATE TEST2 SET regdate=SYSDATE WHERE NO=2;
INSERT INTO TEST2 VALUES(3,'KIM','������','SOH445@NAVER.COM','����� ���α� ���Ϸ�130 1206ȣ','123452.8484',SYSDATE);
INSERT INTO TEST2 VALUES(22222,'TEST2','���̻�����ĥ�ȱ���','SOH445@NAVER.COM','����� ���α� ���Ϸ�130 1206ȣ','123452.7777',SYSDATE);
INSERT INTO TEST2 (NO,ID,NAME) VALUES('11','TEST4','ȫ�浿4');
--=============================
--Ư�����̺��� �����Ϳ� ���̺� ������ �Բ� ���� 
-- TEST2 == �����ؼ� TEST3 ����� 
CREATE TABLE TEST3
AS SELECT * FROM TEST2;

SELECT * FROM TEST2;
SELECT * FROM TEST3;
--Ư�����̺��� ������ (Ư�� �÷���)
--TEST => TEST4�� : �����ʹ� ���� ���� 
CREATE TABLE TEST4
AS SELECT NO,ID,NAME,EMAIL,REGDATE FROM TEST2 WHERE 1=2;
--���̺� ��ü ������ ���� 
SELECT * FROM TEST2;
DELETE FROM TEST2;
ROLLBACK; --DELETE ���� COMMIT���� ��� ROLLBACK���� �۾� ��� ���� 

TRUNCATE TABLE TEST2; --�ѹ��� ���� SHIFT ������ �����ѰŶ� ���� ROLLBACK �ε� ���� �Ұ��� �ӽ������ ���� ���� �ʰ� �ٷ� ���� 
ROLLBACK;

--DDL���� �ٷ� �ݿ� 
DROP TABLE TEST2;

--===========================
--���̺� ���� : �÷� �߰�, ����, ����
--DDL ALTER TABLE
--ADD : �÷��߰�
--MODIFY : ���� 
     --�÷� ������ ����->ũ�� :������ ����  --
     --�÷� ������ ū -> �۰� : ������ ���¿� ���� �ٸ� 
     
--RENEME COLUMN �������÷��� TO ���ο�����÷���
--DROP COLUMN : ���� 
--���̺� �� ���� ALTER TABLE ���������̺�� RENEME TO ������ ���̺� ��; 
--�÷��߰� :TEST3 TABLE ���̺� ADDCOL �÷� �߰� 
SELECT * FROM TEST3;
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);
--�÷� ���� : TEST3 ���̺��� ADDCOL -> VARCHAR2 (20);
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(15);--������ �ս� ���� 
--�����߻�: ����� ������ ���� �۰� �÷� ũ�⸦ ������ �����ͼս� �߻����� ó�� ����  
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(10);--���� �߻�

--�÷��� ���� : ADDCOL-> ADDCOL2
ALTER TABLE TEST3 RENAME COLUMN ADDCOL TO ADDCOL2;
--�÷����� 
ALTER TABLE TEST3 DROP COLUMN ADDCOL2;
