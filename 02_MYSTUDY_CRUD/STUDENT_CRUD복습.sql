SELECT * FROM STUDENT;
INSERT INTO STUDENT 
       (ID, NAME, KOR, ENG, MATH) 
VALUES ('2019001', '홍길동', 100, 90, 80);
INSERT INTO STUDENT
VALUES ('2019002', '김유신', 90, 80, 70, 0, 0);
INSERT INTO STUDENT
       (NAME, ID, KOR, ENG, MATH)
VALUES ('강감찬', '2019003', 95, 90, 80);
COMMIT;
----------------------
--수정 : 데이터 수정(UPDATE)
--강감찬 수학점수 80 -> 88 수정
UPDATE STUDENT
   SET MATH = 88
 WHERE NAME = '강감찬';
COMMIT;
SELECT * FROM STUDENT WHERE NAME = '강감찬';
--수정 : 김유신 -> 을지문덕 이름 변경
SELECT * FROM STUDENT WHERE NAME = '김유신';
SELECT * FROM STUDENT WHERE NAME = '을지문덕';
UPDATE STUDENT 
   SET NAME = '을지문덕' 
 WHERE NAME = '김유신'
;
UPDATE STUDENT 
   SET NAME = '을지문덕' 
 WHERE ID = '2019002';
----------------------
--삭제 : 데이터 삭제(DELETE)
--강감찬 삭제
SELECT * FROM STUDENT WHERE NAME = '강감찬';
DELETE FROM STUDENT WHERE NAME = '강감찬';


