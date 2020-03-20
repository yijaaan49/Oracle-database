--��������(�μ�����, subquery)
--SQL��(SELECT, INSERT, UPDATE, DELETE) ���� �ִ� ������(SELECT)
--------------
--'������'�� ������ ������ �˻�
SELECT * FROM ORDERS;
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
SELECT * FROM ORDERS WHERE CUSTID = 1;

SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������')
;
SELECT C.NAME, O.*
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '������'
;
----
--������, �迬�ư� ������ ���� ��ȸ
SELECT CUSTID FROM CUSTOMER WHERE NAME IN ('������', '�迬��');
SELECT * FROM ORDERS
  WHERE CUSTID IN (SELECT CUSTID 
                     FROM CUSTOMER 
                    WHERE NAME IN ('������', '�迬��'));
-------------------------
--������ ���� ��� ������ �̸��� ���Ͻÿ�
SELECT MAX(PRICE) FROM BOOK; --35000
SELECT * FROM BOOK
  WHERE PRICE = 35000;
--
--���������� WHERE���� ���
SELECT * FROM BOOK
  WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
------------------
--���������� FROM���� ���
SELECT * 
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE
;
----
SELECT *
  FROM ORDERS O,
       (SELECT * FROM CUSTOMER WHERE NAME IN ('������', '�迬��')) C
 WHERE O.CUSTID = C.CUSTID
;
---------------------
--SELECT ���� �������� ���
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, --����
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME, --å����
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;
----------------------------
--�������� ������ å ���(����) ��ȸ
--�� ����SQL -> �߰� SQL -> �� �ٱ��� SQL�� ����
SELECT BOOKNAME
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID
                                      FROM CUSTOMER
                                     WHERE NAME = '������')
                  )
;
---------------------------
--�ǽ�(�������� ���)
--1. �� ���̶� ������ ������ �ִ� ���(��������, ���ι�)
--2. 20000�� �̻�Ǵ� å�� ������ �� ��� ��ȸ(��������, ���ι�)
--3. '���ѹ̵��' ���ǻ��� ������ ������ ���̸� ��ȸ(��������, ���ι�)
--4. ��ü å���� ��պ��� ��� å�� ��� ��ȸ(��������, ���ι�)
---------------------------
--1. �� ���̶� ������ ������ �ִ� ���(��������, ���ι�)
SELECT * FROM CUSTOMER;
SELECT * 
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT DISTINCT CUSTID FROM ORDERS)
;
--2. 20000�� �̻�Ǵ� å�� ������ �� ��� ��ȸ(��������, ���ι�)
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS 
                   WHERE SALEPRICE >= 20000);
--JOIN��
SELECT C.*
  FROM CUSTOMER C,
       (SELECT * FROM ORDERS WHERE SALEPRICE >= 20000) O
 WHERE C.CUSTID = O.CUSTID
;
SELECT C.*
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE > 20000
;

--3. '���ѹ̵��' ���ǻ��� ������ ������ ���̸� ��ȸ(��������, ���ι�)
SELECT * FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID FROM BOOK 
                                     WHERE PUBLISHER = '���ѹ̵��'));
---JOIN��
SELECT C.*
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID --��������
   AND B.PUBLISHER = '���ѹ̵��' --�˻�����
;
--SQL�� ������ ����
SELECT * FROM ORDERS WHERE CUSTID = 1; --������
SELECT * FROM BOOK WHERE BOOKID IN (1,3,2); --������ ����Ȯ��(������ OK)

SELECT * FROM BOOK WHERE PUBLISHER = '���ѹ̵��'; --���ѹ̵�� å��� 
SELECT * FROM ORDERS WHERE BOOKID IN (3,4); --���ѹ̵�� å������ ���(�����ϰ� �������̸� OK)

--4. ��ü å���� ��պ��� ��� å�� ��� ��ȸ(��������, ���ι�)
SELECT *
  FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK);
--JOIN��
SELECT *
  FROM BOOK B, --å���
       (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG --å ��հ���
 WHERE PRICE > AVG.AVG_PRICE
;



