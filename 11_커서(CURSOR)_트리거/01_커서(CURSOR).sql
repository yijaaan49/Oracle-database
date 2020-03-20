/* ******** CURSOR(커서) **************
데이터베이스 커서(Cursor)는 일련의 데이터에 순차적으로 액세스할 때 
검색 및 "현재 위치"를 포함하는 데이터 요소

묵시적커서 : SELECT, INSERT, UPDATE, DELETE 문장이 실행될 때
     DBMS가 CURSOR(커서)의 Open, Fetch, Close 자동 처리
명시적커서 : 프로그램내에서 명시적으로 커서(CURSOR)를 선언한 경우

<커서(CURSOR) 사용 절차>
1. 선언(CURSOR 커서명 IS SELECT문)
2. 커서오픈(OPEN 커서명)
3. 데이타추출(FETCH 커서명 INTO)
4. 커서닫기(CLOSE)
------------------------------------------
- SQL%ROWCOUNT : 행의 수
- SQL%FOUND : 1개 이상일 경우 (결과값이 있으면 true)
- SQL%NOTFOUND : 결과값이 하나도 없을때 true
- SQL%ISOPEN : 항상 false, 암시적 커서가 열려 있으면 true
**************************************/
--주문테이블(ORDERS)에 있는 전체 데이터를 가져와서 화면 출력
create or replace PROCEDURE DISP_ORDERS
AS
    --1. 커서선언(CURSOR 커서명 IS SELECT문)
    CURSOR C_ORDERS IS
    SELECT ORDERID
         , GET_CUSTNAME(CUSTID) AS CUSTNAME
         , GET_BOOKNAME(BOOKID) AS BOOKNAME
         , SALEPRICE, ORDERDATE
      FROM ORDERS
     ORDER BY ORDERID;

    --사용할 변수 선언
    V_ORDERID orders.orderid%TYPE;
    V_CUSTNAME customer.name%TYPE;
    V_BOOKNAME book.bookname%TYPE;
    V_SALEPRICE orders.saleprice%TYPE;
    V_ORDERDATE orders.orderdate%TYPE;
BEGIN
    --2. 커서오픈(OPEN 커서명)
    OPEN C_ORDERS;

    LOOP
        --3. 데이타추출(FETCH 커서명 INTO)
        FETCH C_ORDERS
        INTO v_orderid, v_custname, v_bookname, v_saleprice
           , v_orderdate;
        
        EXIT WHEN C_ORDERS%NOTFOUND; --커서에 데이터가 없으면 반복종료
        
        --커서에서 가져온 데이터 화면 출력
        DBMS_OUTPUT.PUT_LINE(v_orderid ||', '|| v_custname ||', '|| v_bookname
                ||', '|| v_saleprice ||', '|| v_orderdate);
    END LOOP;   
    --4. 커서닫기(CLOSE)
    CLOSE C_ORDERS;
END;
---------------------------------------
--FOR문을 이용한 커서(CURSOR) 사용
create or replace PROCEDURE DISP_ORDERS_FOR
AS
    --1. 커서선언(CURSOR 커서명 IS SELECT문)
    CURSOR C_ORDERS IS
    SELECT ORDERID
         , GET_CUSTNAME(CUSTID) AS CUSTNAME
         , GET_BOOKNAME(BOOKID) AS BOOKNAME
         , SALEPRICE, ORDERDATE
      FROM ORDERS
     ORDER BY ORDERID;

    --사용할 변수 선언
    V_ORDERID orders.orderid%TYPE;
    V_CUSTNAME customer.name%TYPE;
    V_BOOKNAME book.bookname%TYPE;
    V_SALEPRICE orders.saleprice%TYPE;
    V_ORDERDATE orders.orderdate%TYPE;
BEGIN
    --2. 커서오픈(OPEN 커서명)
    --3. 데이타추출(FETCH 커서명 INTO)
    --4. 커서닫기(CLOSE)
    FOR O IN C_ORDERS LOOP
        --커서에서 가져온 데이터 화면 출력
        DBMS_OUTPUT.PUT_LINE(O.orderid ||', '|| O.custname ||', '|| O.bookname
                ||', '|| O.saleprice ||', '|| O.orderdate);
    END LOOP;

END;












