 SELECT * FROM BOOK;
 SELECT * FROM CUSTOMER;
 SELECT * FROM ORDERS;
 -------------------------
 --�������� ������ å�� �հ�ݾ�
 SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
 SELECT * FROM ORDERS WHERE CUSTID = 1;
 SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTID = 1;
 --��������(sub query)���
 SELECT * FROM ORDERS 
  WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
------------------------
--���̺� ����(join) ���
SELECT * FROM CUSTOMER WHERE CUSTID = 1;
SELECT * FROM ORDERS WHERE CUSTID = 1;

--CUSTOMER���̺�� ORDERS ���̺� ������ ���� ��ȸ
SELECT *
  FROM CUSTOMER, ORDERS --������ ���̺�
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --���� ����
 ;
-----
--���̺� ���� ��Ī ������� �����ϰ� ǥ��
SELECT *
  FROM CUSTOMER C, ORDERS O --���̺� ���� ��Ī ���
 WHERE C.CUSTID = O.CUSTID --��������
   AND C.NAME = '������' --WHERE ����(������ �˻� ����)
;
--ANSI ǥ�� ��������
SELECT *
  FROM CUSTOMER C 
       JOIN ORDERS O
       ON C.CUSTID = O.CUSTID --��������
 WHERE C.NAME = '������' --�˻�����
; 
-------------------
--�������� ������ �հ�ݾ�
SELECT SUM(O.SALEPRICE)
--SELECT *
  FROM CUSTOMER C, ORDERS O --������ ���̺�
 WHERE C.CUSTID = O.CUSTID --���ν� ����� ����
   AND C.NAME = '������' --������ �˻�����
;
-----------------------------
--���ε� �����Ϳ��� �÷� ��ȸ�� : ���̺��(��Ī).�÷��� ���·� ���
SELECT C.CUSTID, C.NAME, C.ADDRESS,
       O.CUSTID AS ORD_CUSTID, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O --�������̺�
 WHERE C.CUSTID = O.CUSTID --���� ����
   AND C.NAME = '������' --�˻�����
;
------------------------------
SELECT * FROM BOOK;
SELECT * FROM ORDERS;
--Ư�� ���ǻ翡�� ������ å�� �Ǹŵ� ����
SELECT O.ORDERID, O.BOOKID, B.BOOKNAME, B.PRICE, B.PUBLISHER,
       O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O --���ο� ������ ���̺� ���
 WHERE B.BOOKID = O.BOOKID --��������
   --AND B.PUBLISHER = '�̻�̵��' --�˻�����(ã�� ����)
   AND B.PUBLISHER LIKE '%�̵��'
 ORDER BY B.PUBLISHER, B.BOOKNAME
;
SELECT * FROM BOOK WHERE PUBLISHER = '�̻�̵��';
--=======================================
--(�����ذ�) ���̺� ������ ���ؼ� �����ذ�(���� SELECT���� ��� �ذ�)
--�ǽ� : '�߱��� ��Ź��'��� å�� �ȸ� ������ Ȯ��(å����, �Ǹűݾ�, �Ǹ�����)
--�ǽ� : '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ��
------
--�ǽ� : '�߽ż�'�� ������ å���� �������ڸ� Ȯ��(å��, ��������)
--�ǽ� : '�߽ż�'�� ������ �հ�ݾ��� Ȯ��
--�ǽ� : ������, �߽ż��� ������ ������ Ȯ��(�̸�, �Ǹűݾ�, �Ǹ�����)
--============================================
--�ǽ� : '�߱��� ��Ź��'��� å�� �ȸ� ������ Ȯ��(å����, �Ǹűݾ�, �Ǹ�����)
SELECT B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
--�ǽ� : '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ��
SELECT '�߱��� ��Ź�� �ǸŰǼ�', COUNT(*)
  FROM ORDERS O, BOOK B
 WHERE O.BOOKID = B.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
--�ǽ� : '�߽ż�'�� ������ å���� �������ڸ� Ȯ��(å��, ��������)
SELECT '�߽ż� ���Գ���', O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;
--�ǽ� : '�߽ż�'�� ������ �հ�ݾ��� Ȯ��
SELECT '�߽ż� �����հ�', SUM(SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;
--�ǽ� : ������, �߽ż��� ������ ������ Ȯ��(�̸�, �Ǹűݾ�, �Ǹ�����)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND (C.NAME = '������' OR C.NAME = '�߽ż�')
;
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME IN ('������','�߽ż�')
 ORDER BY C.NAME, O.ORDERDATE
;
--===========================
--3�� ���̺� ����
SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C --�������̺�
 WHERE B.BOOKID = O.BOOKID --�������� B = 0
   AND O.CUSTID = C.CUSTID --�������� O = C
 ORDER BY O.ORDERID
;
SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C --�������̺�
 WHERE O.BOOKID = B.BOOKID --�������� O = B
   AND O.CUSTID = C.CUSTID --�������� O = C
 ORDER BY O.ORDERID
;
------------------------
--3�� ���̺����� : ����, å����, �ǸŰ���, �Ǹ�����, ���ǻ��
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
;
--===================================
--(�ǽ�) BOOK, CUSTOMER, ORDERS ���̺� �����͸� ��ȸ
--��̶��� ������ å����, ���԰���, ��������, ���ǻ�
--��̶��� ������ å �߿� 2014-01-01 ~ 2014-07-08 ���� ������ ����
--'�߱��� ��Ź��'��� å�� ������ ����� �������ڸ� Ȯ��
--�߽ż�, ��̶��� ������ å����, ���Աݾ�, �������ڸ� Ȯ��
----(���� : ����, �������� ������)
---------------------------------------
--��̶��� ������ å����, ���԰���, ��������, ���ǻ�
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME = '��̶�'
;
--��̶��� ������ å �߿� 2014-01-01 ~ 2014-07-08 ���� ������ ����
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER 
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME = '��̶�'
   AND O.ORDERDATE BETWEEN TO_DATE('20140101', 'YYYYMMDD') 
                       AND TO_DATE('2014/07/08', 'YYYY/MM/DD')
;
SELECT ORDERDATE, TO_CHAR(ORDERDATE, 'YYYY-MM-DD HH24:MI:SS')
  FROM ORDERS
;
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME = '��̶�'
   AND O.ORDERDATE >= TO_DATE('20140101', 'YYYYMMDD')
   AND O.ORDERDATE < TO_DATE('2014/07/09', 'YYYY/MM/DD')
;
--'�߱��� ��Ź��'��� å�� ������ ����� �������ڸ� Ȯ��
SELECT C.NAME, O.ORDERDATE, B.BOOKNAME
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID
   AND O.CUSTID = C.CUSTID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
--�߽ż�, ��̶��� ������ å����, ���Աݾ�, �������ڸ� Ȯ��
----(���� : ����, �������� ������)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME IN ('�߽ż�', '��̶�')
 ORDER BY C.NAME, O.ORDERDATE
;
--=============================
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), 
       ROUND(AVG(O.SALEPRICE)),
       MAX(O.SALEPRICE), MIN(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
;








 