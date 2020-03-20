/* ************************
��(VIEW) : �ѳ� �Ǵ� �� �̻��� ���̺�� ����
   ����Ÿ�� �κ������� ���̺��� ��ó�� ����ϴ� ��ü(�������̺�)
--��(VIEW) ������
CREATE [OR REPLACE] VIEW ���̸� [(�÷���Ī1, �÷���Ī2, ..., �÷���Īn)]
AS
SELECT ����
[�ɼ�];

--�б����� �ɼ� : WITH READ ONLY

--��(VIEW) ����
DROP VIEW ���̸�;
***************************/
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
--��(VIEW) �����
CREATE VIEW VW_BOOK
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%'
WITH READ ONLY;

SELECT * FROM VW_BOOK;
-----------
SELECT * FROM VW_BOOK WHERE PUBLISHER = '�½�����';
SELECT * 
  FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%') 
 WHERE PUBLISHER = '�½�����';
-------------------------------
--��(VIEW) ���� - �÷���Ī(alias) ���
CREATE VIEW VW_BOOK2 
    (BID, BNAME, PUB, PRICE)
AS
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
  FROM BOOK
 WHERE BOOKNAME LIKE '%�౸%'
;
--
SELECT * FROM VW_BOOK2;
--------------------------
CREATE VIEW VW_BOOK3
    (BNAME, PUB, PRICE)
AS
SELECT BOOKNAME, PUBLISHER, PRICE
  FROM BOOK
 WHERE BOOKNAME LIKE '%�౸%';
--=========================
--ORDERS ���̺� ����ؼ� VIEW �����
CREATE OR REPLACE VIEW VW_ORDERS
AS
SELECT O.ORDERID, B.BOOKNAME, B.PUBLISHER
     , C.NAME, C.PHONE, C.ADDRESS
     , B.PRICE, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
WITH READ ONLY
;
--DROP VIEW VW_ORDERS; --�����
SELECT * FROM VW_ORDERS;
SELECT ORDERID, NAME, BOOKNAME, SALEPRICE 
  FROM VW_ORDERS
 WHERE NAME IN ('�迬��', '��̶�')
 ORDER BY NAME
;
--====================
--(�ǽ�) �並 ����, ��ȸ, ����
--1. ����� - ���Ī : VW_ORD_ALL
---- �ֹ�(�Ǹ�)����, å����, ������ ��� ��ȸ�� �� �ִ� ���� �� 
--2. �̻�̵��� ������ å�� �Ǹŵ� å����, �Ǹűݾ�, �Ǹ��� ��ȸ
--3. �̻�̵��� ������ å �߿��� �߽ż�, ��̶��� ������ å ���� ��ȸ
---- ����׸� : ������ ����̸�, å����, ���ǻ�, ����(����), �ǸŰ�, �Ǹ�����
---- ���� : ������ ����̸�, �������� �ֱټ�
--4. �Ǹŵ� å�� ���Ͽ� �����ں� �Ǽ�, �հ�ݾ�, ��ձݾ�, �ְ�, ������ ��ȸ
--(����) ����� : VW_ORD_ALL ���� ó��
--================================
CREATE VIEW OB AS
SELECT O.BOOKID, B.BOOKID B_BOOKID
  FROM ORDERS O, BOOK B
 WHERE O.BOOKID = B.BOOKID
;






