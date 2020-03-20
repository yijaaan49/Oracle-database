/* �����Լ� : ����Ŭ DBMS���� �����ϴ� function
�׷��Լ� : �ϳ� �̻��� ���� �׷����� ��� ����
COUNT(*) : ������ ���� ��ȸ(��ü �÷��� ���Ͽ�)
COUNT(�÷���) : ������ ���� ��ȸ(������ �÷��� �������)
SUM(�÷�) : �հ� �� ���ϱ�
AVG(�÷�) : ��� �� ���ϱ�
MAX(�÷�) : �ִ� �� ���ϱ�
MIN(�÷�) : �ּ� �� ���ϱ�
********************************/
SELECT COUNT(*) FROM BOOK; --BOOK ���̺��� ������ �Ǽ� Ȯ��
SELECT * FROM BOOK;

SELECT * FROM CUSTOMER; --������ 5�� ��ȸ
SELECT COUNT(*) FROM CUSTOMER; -- 5 ��ȸ
SELECT COUNT(NAME) FROM CUSTOMER; -- 5 ��ȸ
SELECT COUNT(PHONE) FROM CUSTOMER; --4�� ��ȸ : NULL ���� �������� ���ܵ�

--SUM(�÷�) : �÷��� �հ� �� ���ϱ�
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500
SELECT SUM(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��'); --90000

--AVG(�÷�) : �÷��� ��� �� ���ϱ�
SELECT * FROM BOOK;
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��');

--MAX(�÷�) : �÷� �� �� �ִ� �� ���ϱ�
--MIN(�÷�) : �÷� �� �� �ּ� �� ���ϱ�
SELECT * FROM BOOK ORDER BY PRICE DESC;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
 WHERE PUBLISHER = '�½�����'
;
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
  FROM BOOK;
--------------------
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
SELECT * FROM ORDERS WHERE CUSTID = 1;
--(�ǽ�) 
--1. �������� �ѱ��ž�(CUSTID = 1)
SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTID = 1;
SELECT '������' AS NAME, SUM(SALEPRICE) SUM_PRICE
  FROM ORDERS WHERE CUSTID = 1;
  
--2. �������� ������ ������ ��(COUNT)
SELECT COUNT(*) FROM ORDERS WHERE CUSTID = 1;

--3. ���� '��'���� ���� �̸��� �ּ�
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '��%';

--4. ���� '��'���̰� �̸��� '��'���� ������ ���� �̸��� �ּ�
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '��%��';

--5. å ������ '�߱�' ���� '�౸'������ �˻��ϱ�
--   (��, '����' ���� ������ ���� / å�������� ����)
SELECT * FROM BOOK
 WHERE BOOKNAME BETWEEN '�߱�' AND '�౸'
   AND BOOKNAME NOT LIKE '%����%'
;
SELECT * FROM BOOK
 WHERE BOOKNAME >= '�߱�' AND BOOKNAME < '�౹'
 ORDER BY BOOKNAME 
;

