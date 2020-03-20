--서브쿼리(부속질의, subquery)
--SQL문(SELECT, INSERT, UPDATE, DELETE) 내에 있는 쿼리문(SELECT)
--------------
--'박지성'이 구입한 내역을 검색
SELECT * FROM ORDERS;
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1
SELECT * FROM ORDERS WHERE CUSTID = 1;

SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성')
;
SELECT C.NAME, O.*
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '박지성'
;
----
--박지성, 김연아가 구매한 내역 조회
SELECT CUSTID FROM CUSTOMER WHERE NAME IN ('박지성', '김연아');
SELECT * FROM ORDERS
  WHERE CUSTID IN (SELECT CUSTID 
                     FROM CUSTOMER 
                    WHERE NAME IN ('박지성', '김연아'));
-------------------------
--정가가 가장 비싼 도서의 이름을 구하시오
SELECT MAX(PRICE) FROM BOOK; --35000
SELECT * FROM BOOK
  WHERE PRICE = 35000;
--
--서브쿼리를 WHERE절에 사용
SELECT * FROM BOOK
  WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
------------------
--서브쿼리를 FROM절에 사용
SELECT * 
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE
;
----
SELECT *
  FROM ORDERS O,
       (SELECT * FROM CUSTOMER WHERE NAME IN ('박지성', '김연아')) C
 WHERE O.CUSTID = C.CUSTID
;
---------------------
--SELECT 절에 서브쿼리 사용
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, --고객명
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME, --책제목
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;
----------------------------
--박지성이 구매한 책 목록(제목) 조회
--맨 안쪽SQL -> 중간 SQL -> 맨 바깥쪽 SQL문 실행
SELECT BOOKNAME
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID
                                      FROM CUSTOMER
                                     WHERE NAME = '박지성')
                  )
;
---------------------------
--실습(서브쿼리 사용)
--1. 한 번이라도 구매한 내역이 있는 사람(서브쿼리, 조인문)
--2. 20000원 이상되는 책을 구입한 고객 명단 조회(서브쿼리, 조인문)
--3. '대한미디어' 출판사의 도서를 구매한 고객이름 조회(서브쿼리, 조인문)
--4. 전체 책가격 평균보다 비싼 책의 목록 조회(서브쿼리, 조인문)
---------------------------
--1. 한 번이라도 구매한 내역이 있는 사람(서브쿼리, 조인문)
SELECT * FROM CUSTOMER;
SELECT * 
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT DISTINCT CUSTID FROM ORDERS)
;
--2. 20000원 이상되는 책을 구입한 고객 명단 조회(서브쿼리, 조인문)
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS 
                   WHERE SALEPRICE >= 20000);
--JOIN문
SELECT C.*
  FROM CUSTOMER C,
       (SELECT * FROM ORDERS WHERE SALEPRICE >= 20000) O
 WHERE C.CUSTID = O.CUSTID
;
SELECT C.*
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE > 20000
;

--3. '대한미디어' 출판사의 도서를 구매한 고객이름 조회(서브쿼리, 조인문)
SELECT * FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID FROM BOOK 
                                     WHERE PUBLISHER = '대한미디어'));
---JOIN문
SELECT C.*
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID --조인조건
   AND B.PUBLISHER = '대한미디어' --검색조건
;
--SQL문 데이터 검증
SELECT * FROM ORDERS WHERE CUSTID = 1; --박지성
SELECT * FROM BOOK WHERE BOOKID IN (1,3,2); --박지성 유무확인(있으면 OK)

SELECT * FROM BOOK WHERE PUBLISHER = '대한미디어'; --대한미디어 책목록 
SELECT * FROM ORDERS WHERE BOOKID IN (3,4); --대한미디어 책구입한 사람(유일하게 박지성이면 OK)

--4. 전체 책가격 평균보다 비싼 책의 목록 조회(서브쿼리, 조인문)
SELECT *
  FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK);
--JOIN문
SELECT *
  FROM BOOK B, --책목록
       (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG --책 평균가격
 WHERE PRICE > AVG.AVG_PRICE
;



