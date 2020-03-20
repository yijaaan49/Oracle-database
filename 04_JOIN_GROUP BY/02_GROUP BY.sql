/* *************************
SELECT [* | DISTINCT] {�÷���, �÷���, ...}
  FROM ���̺��
[WHERE ������]
[GROUP BY {�÷���, ....}
    [HAVING ����] ] --GROUP BY ���� ���� ����
[ORDER BY {�÷��� [ASC | DESC], ....}] --ASC : ��������(�⺻/��������)
                                      --DESC : ��������
***************************/
--GROUP BY : �����͸� �׷����ؼ� ó���� ��� ���
--GROUP BY ���� ����ϸ� SELECT �׸��� GROUP BY ���� ���� �÷�
----�Ǵ� �׷��Լ�(COUNT, SUM, AVG, MAX, MIN)�� ����� �� �ִ�.
--============================================
--���Ű����� ���űݾ��� �հ踦 ���Ͻÿ�
SELECT CUSTID, SUM(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
SELECT * FROM ORDERS WHERE CUSTID = 2;
------------
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;
----
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC
;
---
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY 2 DESC
;
---------
--�ֹ�(�Ǹ�)���̺��� ���� ������ ��ȸ(�Ǽ�,�հ�,���,�ּ�,�ִ�ݾ�)
SELECT CUSTID, COUNT(*), SUM(SALEPRICE),
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
---
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
;
----------------------------------
--(�ǽ�) ���� �������� ���� ������ ��ȸ(�Ǽ�,�հ�,���,�ּ�,�ִ�ݾ�)
----�߽ż�, ��̶� �� 2�� ��ȸ
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME IN ('�߽ż�', '��̶�')
 GROUP BY C.NAME
;
----------
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 HAVING C.NAME IN ('�߽ż�', '��̶�')
;
--------------------------------------
--HAVING �� : GROUP BY �� ���ؼ� ������� �����Ϳ��� �˻����� �ο�
--HAVAING ���� �ܵ����� ���� �� ���� �ݵ�� GROUP BY ���� �Բ� ���
-----------------
--3�� �̻� ������ ���� ��ȸ
SELECT C.NAME, COUNT(*)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) >= 3
;
----------------------
--������ å�߿� 20000�� �̻��� å�� ������ ����� ��赥����
----(�Ǽ�,�հ�,���,�ּ�,�ִ�ݾ�)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       AVG(O.SALEPRICE),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING MAX(O.SALEPRICE) >= 20000
;
----------------
--���� : WHERE���� ���Ǵ� ã�� ����(���̺� ������ ����)
----HAVING ������ ���Ǵ� ������ �׷��ε� ����Ÿ �������� �˻�
----(������� �ٸ��� ó���ǹǷ� ã�� �����Ͱ� �������� ��Ȯ�� Ȯ���� ó��)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       AVG(O.SALEPRICE),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--select *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE >= 20000
 GROUP BY C.NAME
;
-------------------------
--(�ǽ�) ���ΰ� GROUP BY ~ HAVING ������ ����ؼ� ó��
--1. ���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, ������, �ְ� ���ϱ�
--2. ������ �ֹ��� ������ �Ѽ���, ���Ǹž� ���ϱ�
--3. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
--4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� ����
--5. ������ �ֹ��� �Ǽ�, �հ�ݾ�, ��ձݾ��� ���ϰ�(3�� ���� ���� ������ ��� �˻�)
---------------------------
--1. ���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, ������, �ְ� ���ϱ�
SELECT COUNT(*) AS "TOTAL COUNT",
       SUM(SALEPRICE) AS "�Ǹž� �հ�",
       AVG(SALEPRICE) "��հ�",
       MIN(SALEPRICE) "������",
       MAX(SALEPRICE) "�ְ�"
  FROM ORDERS
;
--2. ������ �ֹ��� ������ �Ѽ���, ���Ǹž� ���ϱ�
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE) AS SUM_PRICE
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 --ORDER BY SUM(O.SALEPRICE) DESC
 --ORDER BY 3 DESC
 ORDER BY SUM_PRICE DESC
;
--3. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
SELECT C.NAME, O.SALEPRICE, B.BOOKNAME
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID
   AND O.BOOKID = B.BOOKID
;
--4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� ����
SELECT C.NAME, SUM(O.SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME
;
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;
--5. ������ �ֹ��� �Ǽ�, �հ�ݾ�, ��ձݾ��� ���ϰ�(3�� ���� ���� ������ ��� �˻�)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), TRUNC(AVG(O.SALEPRICE))
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) < 3
;
--(����) �� �� �� �ǵ� ���� ���� ����� ����?




