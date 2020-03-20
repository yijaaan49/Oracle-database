/* ******** CURSOR(Ŀ��) **************
�����ͺ��̽� Ŀ��(Cursor)�� �Ϸ��� �����Ϳ� ���������� �׼����� �� 
�˻� �� "���� ��ġ"�� �����ϴ� ������ ���

������Ŀ�� : SELECT, INSERT, UPDATE, DELETE ������ ����� ��
     DBMS�� CURSOR(Ŀ��)�� Open, Fetch, Close �ڵ� ó��
�����Ŀ�� : ���α׷������� ��������� Ŀ��(CURSOR)�� ������ ���

<Ŀ��(CURSOR) ��� ����>
1. ����(CURSOR Ŀ���� IS SELECT��)
2. Ŀ������(OPEN Ŀ����)
3. ����Ÿ����(FETCH Ŀ���� INTO)
4. Ŀ���ݱ�(CLOSE)
------------------------------------------
- SQL%ROWCOUNT : ���� ��
- SQL%FOUND : 1�� �̻��� ��� (������� ������ true)
- SQL%NOTFOUND : ������� �ϳ��� ������ true
- SQL%ISOPEN : �׻� false, �Ͻ��� Ŀ���� ���� ������ true
**************************************/
--�ֹ����̺�(ORDERS)�� �ִ� ��ü �����͸� �����ͼ� ȭ�� ���
create or replace PROCEDURE DISP_ORDERS
AS
    --1. Ŀ������(CURSOR Ŀ���� IS SELECT��)
    CURSOR C_ORDERS IS
    SELECT ORDERID
         , GET_CUSTNAME(CUSTID) AS CUSTNAME
         , GET_BOOKNAME(BOOKID) AS BOOKNAME
         , SALEPRICE, ORDERDATE
      FROM ORDERS
     ORDER BY ORDERID;

    --����� ���� ����
    V_ORDERID orders.orderid%TYPE;
    V_CUSTNAME customer.name%TYPE;
    V_BOOKNAME book.bookname%TYPE;
    V_SALEPRICE orders.saleprice%TYPE;
    V_ORDERDATE orders.orderdate%TYPE;
BEGIN
    --2. Ŀ������(OPEN Ŀ����)
    OPEN C_ORDERS;

    LOOP
        --3. ����Ÿ����(FETCH Ŀ���� INTO)
        FETCH C_ORDERS
        INTO v_orderid, v_custname, v_bookname, v_saleprice
           , v_orderdate;
        
        EXIT WHEN C_ORDERS%NOTFOUND; --Ŀ���� �����Ͱ� ������ �ݺ�����
        
        --Ŀ������ ������ ������ ȭ�� ���
        DBMS_OUTPUT.PUT_LINE(v_orderid ||', '|| v_custname ||', '|| v_bookname
                ||', '|| v_saleprice ||', '|| v_orderdate);
    END LOOP;   
    --4. Ŀ���ݱ�(CLOSE)
    CLOSE C_ORDERS;
END;
---------------------------------------
--FOR���� �̿��� Ŀ��(CURSOR) ���
create or replace PROCEDURE DISP_ORDERS_FOR
AS
    --1. Ŀ������(CURSOR Ŀ���� IS SELECT��)
    CURSOR C_ORDERS IS
    SELECT ORDERID
         , GET_CUSTNAME(CUSTID) AS CUSTNAME
         , GET_BOOKNAME(BOOKID) AS BOOKNAME
         , SALEPRICE, ORDERDATE
      FROM ORDERS
     ORDER BY ORDERID;

    --����� ���� ����
    V_ORDERID orders.orderid%TYPE;
    V_CUSTNAME customer.name%TYPE;
    V_BOOKNAME book.bookname%TYPE;
    V_SALEPRICE orders.saleprice%TYPE;
    V_ORDERDATE orders.orderdate%TYPE;
BEGIN
    --2. Ŀ������(OPEN Ŀ����)
    --3. ����Ÿ����(FETCH Ŀ���� INTO)
    --4. Ŀ���ݱ�(CLOSE)
    FOR O IN C_ORDERS LOOP
        --Ŀ������ ������ ������ ȭ�� ���
        DBMS_OUTPUT.PUT_LINE(O.orderid ||', '|| O.custname ||', '|| O.bookname
                ||', '|| O.saleprice ||', '|| O.orderdate);
    END LOOP;

END;












