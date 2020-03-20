/* ***********************
--INSERT ��
INSERT INTO ���̺��
       (�÷���1, �÷���2, ...., �÷���n)
VALUES (��1, ��2, ..., ��n);
*************************/
SELECT * FROM BOOK;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (30, '�ڹٶ� �����ΰ�', 'ITBOOK', 30000);
COMMIT;

INSERT INTO BOOK
VALUES (31, '�ڹٶ� �����ΰ�2', 'ITBOOK', 30000);
-------------
--�ϰ��Է� : ���̺��� �����͸� �̿��ؼ� ������ �Է�
INSERT INTO BOOK
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
  FROM imported_book
;
/********************************
--UPDATE ��
UPDATE ���̺��
   SET �÷���1 = ��1, �÷���2 = ��2, ..., �÷���n = ��n
WHERE ������� ã������
*********************************/
SELECT * FROM CUSTOMER;
--�ڼ��� �ּ� : '���ѹα� ����' -> '���ѹα� �λ�' ����(����)
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� �λ�'
 WHERE NAME = '�ڼ���'
;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
COMMIT;
--------
--�ڼ��� �ּ�, ��ȭ��ȣ : '���ѹα� ����', '010-1111-2222'
UPDATE CUSTOMER
   SET address = '���ѹα� ����',
       phone = '010-1111-2222'
 WHERE NAME = '�ڼ���'
;
-------------------
--�ڼ��� �ּ� ���� : �迬���� �ּҿ� �����ϰ� ����
SELECT ADDRESS FROM customer WHERE NAME = '�迬��';
SELECT ADDRESS FROM customer WHERE NAME = '�ڼ���';
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM customer WHERE NAME = '�迬��')
 WHERE NAME = '�ڼ���'
;
------
--�ڼ��� �ּ�, ��ȭ��ȣ ���� : �߽ż� ������ �����ϰ�
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM customer WHERE NAME = '�߽ż�')
     , PHONE = (SELECT PHONE FROM customer WHERE NAME = '�߽ż�')
 WHERE NAME = '�ڼ���'
;
---------------
/* ******************
DELETE ��
DELETE FROM ���̺��
 WHERE ���˻�����;
********************/
SELECT * FROM BOOK;
SELECT * FROM BOOK WHERE BOOKID = 30;
SELECT * FROM BOOK WHERE PRICE = 30000;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER)
VALUES (32, '�ڹٶ� �����ΰ�3', 'ITBOOK');

SELECT * FROM BOOK
--DELETE FROM BOOK
 WHERE BOOKNAME LIKE '�ڹ�%' AND PRICE IS NULL;

DELETE FROM BOOK WHERE BOOKID >= 30;
SELECT * FROM BOOK
--DELETE FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID FROM imported_book 
                   WHERE PUBLISHER = 'Pearson')
;
