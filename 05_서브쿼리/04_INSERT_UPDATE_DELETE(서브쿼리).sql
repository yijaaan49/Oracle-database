/* ***********************
--INSERT 문
INSERT INTO 테이블명
       (컬럼명1, 컬럼명2, ...., 컬럼명n)
VALUES (값1, 값2, ..., 값n);
*************************/
SELECT * FROM BOOK;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (30, '자바란 무엇인가', 'ITBOOK', 30000);
COMMIT;

INSERT INTO BOOK
VALUES (31, '자바란 무엇인가2', 'ITBOOK', 30000);
-------------
--일괄입력 : 테이블의 데이터를 이용해서 데이터 입력
INSERT INTO BOOK
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
  FROM imported_book
;
/********************************
--UPDATE 문
UPDATE 테이블명
   SET 컬럼명1 = 값1, 컬럼명2 = 값2, ..., 컬럼명n = 값n
WHERE 수정대상 찾을조건
*********************************/
SELECT * FROM CUSTOMER;
--박세리 주소 : '대한민국 대전' -> '대한민국 부산' 수정(변경)
UPDATE CUSTOMER
   SET ADDRESS = '대한민국 부산'
 WHERE NAME = '박세리'
;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';
COMMIT;
--------
--박세리 주소, 전화번호 : '대한민국 대전', '010-1111-2222'
UPDATE CUSTOMER
   SET address = '대한민국 대전',
       phone = '010-1111-2222'
 WHERE NAME = '박세리'
;
-------------------
--박세리 주소 수정 : 김연아의 주소와 동일하게 변경
SELECT ADDRESS FROM customer WHERE NAME = '김연아';
SELECT ADDRESS FROM customer WHERE NAME = '박세리';
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM customer WHERE NAME = '김연아')
 WHERE NAME = '박세리'
;
------
--박세리 주소, 전화번호 수정 : 추신수 정보와 동일하게
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM customer WHERE NAME = '추신수')
     , PHONE = (SELECT PHONE FROM customer WHERE NAME = '추신수')
 WHERE NAME = '박세리'
;
---------------
/* ******************
DELETE 문
DELETE FROM 테이블명
 WHERE 대상검색조건;
********************/
SELECT * FROM BOOK;
SELECT * FROM BOOK WHERE BOOKID = 30;
SELECT * FROM BOOK WHERE PRICE = 30000;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER)
VALUES (32, '자바란 무엇인가3', 'ITBOOK');

SELECT * FROM BOOK
--DELETE FROM BOOK
 WHERE BOOKNAME LIKE '자바%' AND PRICE IS NULL;

DELETE FROM BOOK WHERE BOOKID >= 30;
SELECT * FROM BOOK
--DELETE FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID FROM imported_book 
                   WHERE PUBLISHER = 'Pearson')
;
