/* *************************
SELECT [* | DISTINCT] {컬럼명, 컬럼명, ...}
  FROM 테이블명
[WHERE 조건절]
[GROUP BY {컬럼명, ....}
    [HAVING 조건] ] --GROUP BY 절에 대한 조건
[ORDER BY {컬럼명 [ASC | DESC], ....}] --ASC : 오름차순(기본/생략가능)
                                      --DESC : 내림차순
***************************/
--GROUP BY : 데이터를 그룹핑해서 처리할 경우 사용
--GROUP BY 문을 사용하면 SELECT 항목은 GROUP BY 절에 사용된 컬럼
----또는 그룹함수(COUNT, SUM, AVG, MAX, MIN)만 사용할 수 있다.
--============================================
--구매고객별로 구매금액의 합계를 구하시오
SELECT CUSTID, SUM(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
SELECT * FROM ORDERS WHERE CUSTID = 2;
------------
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;
----
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC
;
---
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY 2 DESC
;
---------
--주문(판매)테이블의 고객별 데이터 조회(건수,합계,평균,최소,최대금액)
SELECT CUSTID, COUNT(*), SUM(SALEPRICE),
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
---
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
;
----------------------------------
--(실습) 고객명 기준으로 고객별 데이터 조회(건수,합계,평균,최소,최대금액)
----추신수, 장미란 고객 2명만 조회
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME IN ('추신수', '장미란')
 GROUP BY C.NAME
;
----------
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       TRUNC(AVG(O.SALEPRICE)), 
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--SELECT *
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 HAVING C.NAME IN ('추신수', '장미란')
;
--------------------------------------
--HAVING 절 : GROUP BY 에 의해서 만들어진 데이터에서 검색조건 부여
--HAVAING 절은 단독으로 쓰일 수 없고 반드시 GROUP BY 절과 함께 사용
-----------------
--3건 이상 구매한 고객만 조회
SELECT C.NAME, COUNT(*)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) >= 3
;
----------------------
--구매한 책중에 20000원 이상인 책을 구입한 사람의 통계데이터
----(건수,합계,평균,최소,최대금액)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       AVG(O.SALEPRICE),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING MAX(O.SALEPRICE) >= 20000
;
----------------
--주의 : WHERE절에 사용되는 찾을 조건(테이블 데이터 기준)
----HAVING 절에서 사용되는 조건은 그룹핑된 데이타 기준으로 검색
----(결과값이 다르게 처리되므로 찾을 데이터가 무엇인지 명확히 확인후 처리)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE),
       AVG(O.SALEPRICE),
       MIN(O.SALEPRICE), MAX(O.SALEPRICE)
--select *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE >= 20000
 GROUP BY C.NAME
;
-------------------------
--(실습) 조인과 GROUP BY ~ HAVING 구문을 사용해서 처리
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
--2. 고객별로 주문한 도서의 총수량, 총판매액 구하기
--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
--5. 고객별로 주문한 건수, 합계금액, 평균금액을 구하고(3권 보다 적게 구입한 사람 검색)
---------------------------
--1. 고객이 주문한 도서의 총판매건수, 판매액, 평균값, 최저가, 최고가 구하기
SELECT COUNT(*) AS "TOTAL COUNT",
       SUM(SALEPRICE) AS "판매액 합계",
       AVG(SALEPRICE) "평균값",
       MIN(SALEPRICE) "최저가",
       MAX(SALEPRICE) "최고가"
  FROM ORDERS
;
--2. 고객별로 주문한 도서의 총수량, 총판매액 구하기
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE) AS SUM_PRICE
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 --ORDER BY SUM(O.SALEPRICE) DESC
 --ORDER BY 3 DESC
 ORDER BY SUM_PRICE DESC
;
--3. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
SELECT C.NAME, O.SALEPRICE, B.BOOKNAME
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID
   AND O.BOOKID = B.BOOKID
;
--4. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객명으로 정렬
SELECT C.NAME, SUM(O.SALEPRICE)
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME
;
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;
--5. 고객별로 주문한 건수, 합계금액, 평균금액을 구하고(3권 보다 적게 구입한 사람 검색)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), TRUNC(AVG(O.SALEPRICE))
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) < 3
;
--(번외) 고객 중 한 권도 구입 안한 사람은 누구?




