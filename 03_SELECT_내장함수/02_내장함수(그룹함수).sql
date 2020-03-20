/* 내장함수 : 오라클 DBMS에서 제공하는 function
그룹함수 : 하나 이상의 행을 그룹으로 묶어서 연산
COUNT(*) : 데이터 갯수 조회(전체 컬럼에 대하여)
COUNT(컬럼명) : 데이터 갯수 조회(지정된 컬럼만 대상으로)
SUM(컬럼) : 합계 값 구하기
AVG(컬럼) : 평균 값 구하기
MAX(컬럼) : 최대 값 구하기
MIN(컬럼) : 최소 값 구하기
********************************/
SELECT COUNT(*) FROM BOOK; --BOOK 테이블의 데이터 건수 확인
SELECT * FROM BOOK;

SELECT * FROM CUSTOMER; --데이터 5건 조회
SELECT COUNT(*) FROM CUSTOMER; -- 5 조회
SELECT COUNT(NAME) FROM CUSTOMER; -- 5 조회
SELECT COUNT(PHONE) FROM CUSTOMER; --4건 조회 : NULL 값은 갯수에서 제외됨

--SUM(컬럼) : 컬럼의 합계 값 구하기
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500
SELECT SUM(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어'); --90000

--AVG(컬럼) : 컬럼의 평균 값 구하기
SELECT * FROM BOOK;
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어');

--MAX(컬럼) : 컬럼 값 중 최대 값 구하기
--MIN(컬럼) : 컬럼 값 중 최소 값 구하기
SELECT * FROM BOOK ORDER BY PRICE DESC;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
 WHERE PUBLISHER = '굿스포츠'
;
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
  FROM BOOK;
--------------------
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1
SELECT * FROM ORDERS WHERE CUSTID = 1;
--(실습) 
--1. 박지성의 총구매액(CUSTID = 1)
SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTID = 1;
SELECT '박지성' AS NAME, SUM(SALEPRICE) SUM_PRICE
  FROM ORDERS WHERE CUSTID = 1;
  
--2. 박지성이 구매한 도서의 수(COUNT)
SELECT COUNT(*) FROM ORDERS WHERE CUSTID = 1;

--3. 성이 '김'씨인 고객의 이름과 주소
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '김%';

--4. 성이 '박'씨이고 이름이 '성'으로 끝나는 고객의 이름과 주소
SELECT NAME, ADDRESS FROM CUSTOMER WHERE NAME LIKE '박%성';

--5. 책 제목이 '야구' 부터 '축구'까지를 검색하기
--   (단, '역도' 관련 도서는 제외 / 책제목으로 정렬)
SELECT * FROM BOOK
 WHERE BOOKNAME BETWEEN '야구' AND '축구'
   AND BOOKNAME NOT LIKE '%역도%'
;
SELECT * FROM BOOK
 WHERE BOOKNAME >= '야구' AND BOOKNAME < '축국'
 ORDER BY BOOKNAME 
;

