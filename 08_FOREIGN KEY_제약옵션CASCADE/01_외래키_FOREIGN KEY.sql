/* **********************
--테이블 생성시 제약조건 설정
----컬럼을 정의하면서 컬럼레벨에서 제약조건 지정
--외래키(FOREIGN KEY) 지정으로 관계 설정
--형태 : 컬럼명 REFERENCES 대상테이블 (대상컬럼)
***************************/
SELECT * FROM DEPT;
--컬럼레벨에서 제약조건(외래키) 설정
CREATE TABLE EMP01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT(ID) --외래키 설정
);
-----
SELECT * FROM EMP01;
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');

--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated 
--     - parent key not found
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40'); --DEPT 테이블에 없는 데이터('40')는 입력못함
--================================
--데이터사전 테이블 USER_CONS_COLUMNS, USER_CONSTRAINTS 사용
--제약조건 조회 SQL
SELECT * FROM user_cons_columns;
SELECT * FROM user_constraints;
SELECT a.table_name, a.column_name, a.constraint_name
     , b.constraint_type
     , DECODE(b.constraint_type, 
              'P', 'PRIMARY KEY',
              'U', 'UNIQUE',
              'C', 'CHECK OR NOT NULL',
              'R', 'FOREIGN KEY') CONSTRINT_TYPE_DESC
  FROM user_cons_columns A, user_constraints B
 WHERE A.TABLE_NAME = B.TABLE_NAME
   AND a.constraint_name = b.constraint_name
   AND A.TABLE_NAME LIKE 'EMP%'
;
--===================================
--테이블 레벨 방식으로 제약조건 지정
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --기본키(PRIMARY KEY) 설정
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');

--ORA-02291: integrity constraint (MADANG.SYS_C007035) violated 
--     - parent key not found
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40');
-------------------------------------------
--제약조건명을 명시적으로 선언해서 사용
--형태 : CONSTRAINT 제약조건이름 적용제약조건
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO),
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, '홍길동', '직무1', '10');

INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, '홍길동2', '직무2', '40');

--==========================================
--기본키(PRIMARY KEY) 설정시 복합키 사용
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --학년
    BAN NUMBER(2), --반
    BUN NUMBER(2), --번호
    NAME VARCHAR2(30),
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
INSERT INTO HSCHOOL VALUES (1,1,1, '홍길동');
INSERT INTO HSCHOOL VALUES (1,1,2, '홍길동2');
INSERT INTO HSCHOOL VALUES (1,2,1, '홍길동3');
INSERT INTO HSCHOOL VALUES (2,1,1, '홍길동3');

--ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,1, '강감찬');
--=============================================
/* **** 제약조건 추가, 삭제 **********
--제약조건 추가
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약형태 (컬럼명);

--제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;
************************************/




