/* **** 함수(FUNCTION) *****
실행 후 리턴(RETURN)값을 가지고 있는 프로그램
--리턴 할 데이터 유형 선언 필요
RETURN 데이터유형
--프로그램 마지막에 값 리턴할 문장 필요
RETURN 리턴값;
**************************/
--파라미터 값으로 BOOKID 값을 받고, 책제목(BOOKNAME)을 돌려받는 함수
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER
) RETURN VARCHAR2 --리턴할 데이터 타입
AS
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
      FROM BOOK
     WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; --리턴값 전달
END;
-----------------------
--함수(FUNCTION) 사용
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
 WHERE GET_BOOKNAME(BOOKID) = '축구의 역사';

--===========================
--(실습) 고객ID 값을 전달받아, 고객명을 돌려주는 함수 작성(CUSTOMER 참조)
--함수명 : GET_CUSTNAME
--함수 작성후 ORDERS 테이블 데이터를 조회
----GET_BOOKNAME(), GET_CUSTNAME() 함수 사용 주문정보와 책제목, 고객명 조회
SELECT O.*
     , GET_BOOKNAME(BOOKID) AS BOOK_NAME
     , GET_CUSTNAME(CUSTID) AS CUSTOMER_NAME
  FROM ORDERS O
;
