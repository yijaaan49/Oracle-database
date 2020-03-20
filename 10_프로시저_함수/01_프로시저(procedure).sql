--PL/SQL ���ν���(procedure)
SET SERVEROUT ON; --DBMS ���� ��� Ȯ���� ���� ����

DECLARE --��������
    V_EMPID NUMBER;
    V_NAME VARCHAR2(30);
BEGIN --���๮�� ����
    V_EMPID := 100; --ġȯ��(���Թ�) ��ȣ :=
    V_NAME := 'ȫ�浿';
    
    DBMS_OUTPUT.PUT_LINE(V_EMPID || ' ' || V_NAME);
END; --���๮�� ��

--=========================================
DECLARE
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
      FROM BOOK
     WHERE BOOKID = 6;
     
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||':'|| V_BOOKNAME
            ||':'|| V_PUBLISHER ||':'|| V_PRICE);
END;
-------------------------
/****** �������ν���(Stored procedure)
�Ű����� ����
--IN : �Է� �ޱ⸸ �ϴ� ����(�Ű�����)
--OUT : ��¸� �ϴ� ����(���� ���� �� ����, 
        ���ν��� ���� �� ȣ���� ������ ������ ���� ������ ����)
--IN OUT : �Էµ� �ް�, ���� ������ ���� ��µ� ��
*******************************/
CREATE OR REPLACE PROCEDURE BOOK_DISP
--�Ű����� ����� : ( )�ȿ� �ۼ�
(
    IN_BOOKID IN NUMBER
)
AS
--���� �����(AS �Ǵ� IS ~ BEGIN�� ����)
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
      FROM BOOK
     WHERE BOOKID = IN_BOOKID;
     
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||':'|| V_BOOKNAME
            ||':'|| V_PUBLISHER ||':'|| V_PRICE);
END;

-------------------
--���ν��� ���� : EXECUTE Ű����(��ɹ�) ���
EXECUTE BOOK_DISP(1);
EXEC BOOK_DISP(2);

--���ν��� ����
DROP PROCEDURE BOOK_DISP;

--===============================
--GET_BOOKINFO(IN, OUT, OUT, OUT)
CREATE OR REPLACE PROCEDURE GET_BOOKINFO (
    IN_BOOKID IN NUMBER,
    OUT_BOOKNAME OUT VARCHAR2,
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
    --%TYPE : ���̺��.�÷���%TYPE
    --���̺��� �÷��� ������ Ÿ������ ����(����ÿ��� ����)
    V_BOOKID BOOK.BOOKID%TYPE;
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
      INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
      FROM BOOK
     WHERE BOOKID = IN_BOOKID;
     
    --�����͸� ȣ���� ������ �����ϱ� ���� ������ ����
    OUT_BOOKNAME : = V_BOOKNAME;
    OUT_PUBLISHER := V_PUBLISHER;
    OUT_PRICE := V_PRICE;
     
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||':'|| V_BOOKNAME
            ||':'|| V_PUBLISHER ||':'|| V_PRICE);    
END;

----------------------------
--���ν��� OUT �Ű����� �� Ȯ��
create or replace PROCEDURE GET_BOOKINFO_TEST (
    IN_BOOKID IN NUMBER
) AS 
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER BOOK.PUBLISHER%TYPE;
    V_PRICE BOOK.PRICE%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�Է¹��� ��(ID) : ' || IN_BOOKID);
    
    -- GET_BOOKINFO ���ν��� ȣ��(����)
    GET_BOOKINFO(IN_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE);
    
    -- ������ ���� ���� ��(OUT) ȭ�� ���
    DBMS_OUTPUT.PUT_LINE('>>BOOKINFO_TEST��� - ' || IN_BOOKID 
            ||':'|| V_BOOKNAME ||':'|| V_PUBLISHER ||':'|| V_PRICE);  
    
END;

--================================
/* (�ǽ�) : �����̺�(CUSTOMER)�� �ִ� ������ ��ȸ ���ν��� �ۼ�
���ν����� : GET_CUST_INFO
�Է¹޴� �� : ��ID ��
ó�� : �Է¹��� ��ID�� �ش��ϴ� �����͸� ȭ�鿡 ���
---- ��ID, ����, �ּ�, ��ȭ��ȣ ���
*****************************/







