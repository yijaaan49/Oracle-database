/**** 비교구문(분기처리) IF문 
 IF (조건식) THEN ~ END IF;
 IF (조건식) THEN ~ ELSE ~ END IF;
 IF (조건식) THEN ~ ELSIF ~ ELSIF ~ ELSE ~ END IF;
*******************************/
 --홀짝 판별
 create or replace PROCEDURE PRC_IF (
    IN_NUM IN NUMBER
 ) AS
    V_STR VARCHAR2(100) := ' >>> ';
 BEGIN
    dbms_output.put_line('>> 입력값 : ' || IN_NUM);
    
    --짝수, 홀수 판별
    IF (MOD(IN_NUM, 2) = 0) THEN
        --dbms_output.put_line(IN_NUM ||' --> '|| '짝수입니다');
        V_STR := V_STR || '짝수입니다';
    ELSE
        --dbms_output.put_line(IN_NUM ||' --> '|| '홀수입니다');
        V_STR := V_STR || '홀수입니다';
    END IF;
    
    dbms_output.put_line(IN_NUM || V_STR);
 END;
 
 -----------------------------
 --4로 나눈 나머지 값 확인
 create or replace PROCEDURE PRC_IF2 (
    IN_NUM IN NUMBER
 ) AS
 BEGIN
    DBMS_OUTPUT.PUT_LINE('>> 입력값 : ' || IN_NUM);
    
    --4로 나눈 나머지 값 확인
    IF (MOD(IN_NUM, 4) = 0) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 0');
    ELSIF (MOD(IN_NUM, 4) = 1) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 1');
    ELSIF (MOD(IN_NUM, 4) = 2) THEN
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 2');
    ELSE
        DBMS_OUTPUT.PUT_LINE('>> 4로 나눈 나머지 3');
    END IF;
 END;
 
--====================================
--반복문 : FOR, WHILE
--FOR 문 사용
----FOR 변수 IN 초기값 .. 최종값 LOOP ~ END LOOP;

--숫자 하나(N)를 입력 받아서 합계출력(1~N 까지의 합)
CREATE OR REPLACE PROCEDURE PRC_FOR_SUM (
    IN_NUM IN NUMBER    
 ) AS
    V_SUM NUMBER := 0; --합계 값 저장 변수
BEGIN
    --입력받은 숫자까지의 합계 구하기
    DBMS_OUTPUT.PUT('1 부터 ' || IN_NUM || '까지의 합계 : ');
    
    --FOR문으로 반복 처리
    --FOR 변수 IN 초기값 .. 최종값 LOOP ~ END LOOP;
    FOR I IN 1 .. IN_NUM LOOP
        V_SUM := V_SUM + I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;

--===================
--WHILE 문
--WHILE (조건식) LOOP ~ END LOOP;
---------
--숫자 하나를 입력 받아 합계 출력(1~N 까지의 합)
CREATE OR REPLACE PROCEDURE PRC_WHILE_SUM (
    IN_NUM IN NUMBER
) AS
    V_SUM NUMBER := 0;
    I NUMBER := 1;
BEGIN
    --입력받은 숫자까지의 합계 구하기(1~N 까지의 합)
    DBMS_OUTPUT.PUT('1 부터 ' || IN_NUM || '까지의 합계 : ');
    
    --WHILE문
    WHILE (I <= IN_NUM) LOOP
        V_SUM := V_SUM + I;
        I := I + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;

--======================
/* (실습) 숫자를 하나 입력 받아서 0 ~ 숫자까지의 합계 구하기
프로시저명 : PRC_SUM_EVENODD
--입력한 값이 홀수면 홀수값만 더하고
--입력한 값이 짝수면 짝수값만 더해서
최종 결과를 화면에 출력
<출력형태>
-- 입력숫자 : 입력받은 값, 홀수/짝수, 합계 : 합계결과값
-- 출력예) 입력숫자: 4, 짝수, 합계 : 6
-- 출력예) 입력숫자: 5, 홀수, 합계 : 9
----------------------------------------

****************************/
 
 
 
 
 
 
 
 
 
 