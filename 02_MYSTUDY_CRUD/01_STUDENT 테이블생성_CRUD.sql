CREATE TABLE STUDENT (
    ID VARCHAR2(20), 
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3,0),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2)
);
--------------------------------------------
SELECT * FROM STUDENT;
--데이터 추가 : 데이터 입력(INSERT)
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019001', '홍길동', 100, 90, 80);

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019002', '김유신', 90, 90, 90);
COMMIT; --데이터를 최종 확정(DB에 적용)
ROLLBACK; --작업취소(최종 COMMIT 위치로 부터 진행 작업 모두)
----------------------------------
--수정 : 데이터 수정(UPDATE)
--김유신 수학점수 : 90 -> 88 수정
UPDATE STUDENT 
   SET KOR = 77, MATH = 88 
WHERE NAME = '김유신';
SELECT * FROM STUDENT;
-------------------------------
--삭제 : 데이터 삭제(DELETE)
SELECT * FROM STUDENT WHERE NAME = '김유신';
DELETE FROM STUDENT WHERE ID = '2019002';


