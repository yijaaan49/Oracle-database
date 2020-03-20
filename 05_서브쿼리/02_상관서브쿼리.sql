 --�����������(���������� ���������� ���εǾ� ����)
 ------------------
 --���ǻ纰�� ���ǻ纰 ��� �������ݺ��� ��� ���� ����� ���Ͻÿ�
 SELECT * FROM BOOK ORDER BY PUBLISHER;
 ----�½����� ���ǻ� å �߿��� �½����� ���ǻ� å�� ��� �ݾ׺��� ��� ����
 SELECT * FROM BOOK WHERE PUBLISHER = '�½�����';
 SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '�½�����'; --7000
 SELECT *
   FROM BOOK
  WHERE PUBLISHER = '�½�����' 
    AND PRICE > (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '�½�����')
;
---- ������� ���Ƿ� ��� ���ǻ翡 ����
---- ����������� : ���� SELECT���� �����Ͱ� �ϳ� ó���� ������ �������̺� ����
-------���ؼ� �������� ������ ����Ǵ� ���·� ó��
SELECT B.*
     , (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = B.PUBLISHER) PUB_AVG
  FROM BOOK B
 WHERE PRICE >= (SELECT AVG(PRICE) FROM BOOK 
                 WHERE PUBLISHER = B.PUBLISHER)
;
--------------------
--JOIN������ ó��
--���ǻ纰 ��� ���� ����
SELECT PUBLISHER, AVG(PRICE)
  FROM BOOK
 GROUP BY PUBLISHER;
-----
SELECT *
  FROM BOOK B,
       (SELECT PUBLISHER, AVG(PRICE) AVG_PRICE
          FROM BOOK
         GROUP BY PUBLISHER
       ) AVG
 WHERE B.PUBLISHER = AVG.PUBLISHER --��������
   AND B.PRICE >= AVG.AVG_PRICE
;
--------------
--SELECT���� ���� �����������
SELECT O.*
     , (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) ����
     , (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) ������
  FROM ORDERS O
;
--------------------
--EXISTS : ���翩�� Ȯ�ν� ���(������ true)
--NOT EXISTS : �������� ���� �� true
SELECT *
  FROM BOOK
 WHERE BOOKNAME IN (SELECT BOOKNAME FROM BOOK
                     WHERE BOOKNAME LIKE '%�౸%')
; 
-------
SELECT B.*
  FROM BOOK B
 WHERE EXISTS (SELECT 1
                 FROM BOOK
                WHERE B.BOOKNAME LIKE '%�౸%');
-----------------
--�ֹ������� �ִ� ���� �̸��� ��ȭ��ȣ�� ���Ͻÿ�
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT DISTINCT CUSTID FROM ORDERS);
---- EXISTS ���
SELECT *
  FROM CUSTOMER C
 WHERE EXISTS (SELECT 1 FROM ORDERS WHERE CUSTID = C.CUSTID);
---- NOT EXISTS
SELECT *
  FROM CUSTOMER C
 WHERE NOT EXISTS (SELECT 1 FROM ORDERS WHERE CUSTID = C.CUSTID);
--=====================


