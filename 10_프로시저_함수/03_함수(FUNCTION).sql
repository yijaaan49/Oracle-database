/* **** �Լ�(FUNCTION) *****
���� �� ����(RETURN)���� ������ �ִ� ���α׷�
--���� �� ������ ���� ���� �ʿ�
RETURN ����������
--���α׷� �������� �� ������ ���� �ʿ�
RETURN ���ϰ�;
**************************/
--�Ķ���� ������ BOOKID ���� �ް�, å����(BOOKNAME)�� �����޴� �Լ�
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER
) RETURN VARCHAR2 --������ ������ Ÿ��
AS
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
      FROM BOOK
     WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; --���ϰ� ����
END;
-----------------------
--�Լ�(FUNCTION) ���
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
  FROM BOOK;
----
SELECT GET_BOOKNAME(1) FROM DUAL;
----
SELECT O.*, GET_BOOKNAME(BOOKID) AS BOOKNAME
  FROM ORDERS O;
---------
SELECT O.*, GET_BOOKNAME(BOOKID) AS BOOKNAME
  FROM ORDERS O
 WHERE GET_BOOKNAME(BOOKID) = '�౸�� ����';

--===========================
--(�ǽ�) ��ID ���� ���޹޾�, ������ �����ִ� �Լ� �ۼ�(CUSTOMER ����)
--�Լ��� : GET_CUSTNAME
--�Լ� �ۼ��� ORDERS ���̺� �����͸� ��ȸ
----GET_BOOKNAME(), GET_CUSTNAME() �Լ� ��� �ֹ������� å����, ���� ��ȸ
SELECT O.*
     , GET_BOOKNAME(BOOKID) AS BOOK_NAME
     , GET_CUSTNAME(CUSTID) AS CUSTOMER_NAME
  FROM ORDERS O
;
