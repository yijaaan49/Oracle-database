--(����) �� �� �� �ǵ� ���� ���� ����� ����?
-->CUSTOMER ���̺� �ְ�, ORDERS ���̺� ���� ���
-------------
--MINUS : ������ ó��
SELECT CUSTID FROM CUSTOMER
MINUS
SELECT CUSTID FROM ORDERS;
--------------
--��������(SUB QUERY)
SELECT *
  FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
 ;
 SELECT DISTINCT CUSTID FROM ORDERS;
----------------------------
--�ܺ�����(OUTER JOIN)
--��������
SELECT DISTINCT C.*
  FROM CUSTOMER C, ORDERS O --�������̺�
 WHERE C.CUSTID = O.CUSTID --��������
;
--LEFT OUTER JOIN
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
-------------------
--����(JOIN, INNER JOIN, ��������) : �������̺� ��ο� �����ϴ� ������ �˻�
--�ܺ�����(OUTER JOIN) : ��� �� �� ���̺� �����Ͱ� �������� �ʴ� ������ �˻�
----��� ������ ǥ���ϰ�, ��ġ���� �ʴ� �����Ϳ� ���� ��ȸ ó���� �� ���
-----------------------------
CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES ('10', '�ѹ���');
INSERT INTO DEPT VALUES ('20', '�޿���');
INSERT INTO DEPT VALUES ('30', 'IT��');
COMMIT;
----
CREATE TABLE DEPT_1 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT_1 VALUES ('10', '�ѹ���');
INSERT INTO DEPT_1 VALUES ('20', '�޿���');
COMMIT;
---
CREATE TABLE DEPT_2 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT_2 VALUES ('10', '�ѹ���');
INSERT INTO DEPT_2 VALUES ('30', 'IT��');
COMMIT;
---------------------
SELECT * FROM DEPT;
SELECT * FROM DEPT_1;
SELECT * FROM DEPT_2;
----
--DEPT = DEPT_1
SELECT *
  FROM DEPT D, DEPT_1 D1
 WHERE D.ID = D1.ID
;
--
SELECT * 
  FROM DEPT D, DEPT_2 D2
 WHERE D.ID = D2.ID
;
-------------
--DEPT ���� �ְ�, DEPT_1 ���� ���� ������(�μ�) ��ȸ
--LEFT OUTER JOIN : ���� ���̺��� ���� 
---- ��ü ������ ǥ���ϰ� ������ ������ NULL ǥ��
SELECT *
  FROM DEPT D, DEPT_1 D1
 WHERE D.ID = D1.ID(+)
;
---�������� �ִ� ������ ��ȸ
SELECT *
  FROM DEPT D, DEPT_1 D1 --���� ���̺�(�۾� ��� ���̺�)
 WHERE D.ID = D1.ID(+) --��������
   AND D1.ID IS NULL --�˻�����
;
---- ANSI ǥ�� SQL
SELECT *
  FROM DEPT D
       LEFT OUTER JOIN DEPT_1 D1
       ON D.ID = D1.ID --��������
 WHERE D1.ID IS NULL --�˻�����
;
---------
--RIGHT OUTER JOIN : ���� ���̺��� ����
SELECT *
  FROM DEPT_1 D1, DEPT D
 WHERE D1.ID(+) = D.ID
   AND D1.ID IS NULL
;
--- ANSI ǥ�� SQL
SELECT *
  FROM DEPT_1 D1
       RIGHT OUTER JOIN DEPT D
       ON D1.ID = D.ID
 WHERE D1.ID IS NULL
;   
--------------------------
--(�ǽ�)DEPT_1, DEPT_2 ���̺��� ����ؼ�
--DEPT_1���� �ְ�, DEPT_2���� ���� ������ ã��
SELECT *
  FROM DEPT_1 D1, DEPT_2 D2
 WHERE D1.ID = D2.ID(+) --������ �ִ� D1���̺� ����
   AND D2.ID IS NULL
;
SELECT *
  FROM DEPT_1 D1 LEFT OUTER JOIN DEPT_2 D2
       ON D1.ID = D2.ID
 WHERE D2.ID IS NULL
;
--DEPT_2���� �ְ�, DEPT_1���� ���� ������ ã��
SELECT *
  FROM DEPT_1 D1, DEPT_2 D2
 WHERE D1.ID(+) = D2.ID --������ �ִ� D2���̺� ����
   AND D1.ID IS NULL
;
SELECT *
  FROM DEPT_1 D1 RIGHT OUTER JOIN DEPT_2 D2
       ON D1.ID = D2.ID
 WHERE D1.ID IS NULL
;
-----------------------------
--FULL OUTER JOIN : ���� ���̺� �ִ� ������ ��� ǥ��(������ NULL)
--ANSI ǥ�� SQL 
SELECT *
  FROM DEPT_1 D1 
       FULL OUTER JOIN DEPT_2 D2
       ON D1.ID = D2.ID
;
--����Ŭ OUTER JOIN ����� (+) ���ʿ� ������ �ȵ�
SELECT *
  FROM DEPT_1 D1, DEPT_2 D2
 WHERE D1.ID(+) = D2.ID(+)
;






