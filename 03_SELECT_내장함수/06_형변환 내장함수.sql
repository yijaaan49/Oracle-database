/************************************************
내장함수 형변환 - 문자열 -> 날짜, 숫자 -> 문자열...
TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
TO_DATE : 날짜타입으로 전환(문자 -> 날짜)
TO_NUMBER : 숫자타입으로 전환(문자 -> 숫자)

      <- TO_NUMBER(문자)  -> TO_DATE(문자)
숫자형   ----    문자형   ----     날짜형
      -> TO_CHAR(숫자)   <- TO_CHAR(날짜)
************************************************
--날짜 -> 문자
TO_CHAR(날짜데이터, '출력형식')
<출력형식>
년도(YYYY, YY), 월(MM), 일(DD)
시간 : HH, HH12(12 시간제), HH24(24 시간제)
분(MI), 초(SS)
오전, 오후: AM, PM
년월일시분초 작성예) YYYY-MM-DD HH24:MI:SS
************************************************/
--TO_CHAR : 문자타입으로 전환(날짜 -> 문자, 숫자 -> 문자)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; --'2019-11-05'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD DAY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD DY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD(DY)') FROM DUAL; --2019.11.05(화)

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS') FROM DUAL;

--======================
/* TO_CHAR(숫자, '출력형식') : 숫자 -> 문자타입
<형식지정>
0(영) : 자리수를 나타내며, 자리수가 맞지 않을 경우 0을 표시
9(구) : 자리수를 나타내며, 자리수가 맞지 않을 경우 채우지 않음(표시안함)
L : 지역 통화 기호 표시
.(점) : 소수점
,(콤마) : 1000단위 구분 기호
---------------------------*/
SELECT 123000, TO_CHAR(123000), '123000', TO_NUMBER('123000') FROM DUAL;
SELECT 123000 + 10, TO_CHAR(123000) + 10
     , '123000' + 10, TO_NUMBER('123000') + 10 
  FROM DUAL;
SELECT TO_CHAR(123000, 'L999,999,999'), TO_CHAR(123000, 'L000,000,000')
  FROM DUAL;
SELECT TO_CHAR(1230.55, 'L999,999.999'), TO_CHAR(1230.55, 'L000,000.000')
  FROM DUAL;  

--TO_DATE : 날짜타입으로 전환(문자 -> 날짜)
SELECT '2019-11-05', TO_DATE('2019-11-05', 'YYYY-MM-DD') FROM DUAL;
SELECT '2019-11-05', TO_DATE('2019-11-05', 'YYYY-MM-DD') + 1 FROM DUAL;
SELECT '20191105', TO_DATE('20191105', 'YYYYMMDD') FROM DUAL;
SELECT '2019-11-05 14:57:30', 
       TO_DATE('2019-11-05 14:57:30', 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;
----------------------------
SELECT '0.현재날짜:'|| SYSDATE FROM DUAL
UNION
SELECT '1. 지금: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '2. 1일 후: ' || TO_CHAR(SYSDATE + 1, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '3. 1시간 후: ' || TO_CHAR(SYSDATE + 1/24, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '4. 1분 후: ' || TO_CHAR(SYSDATE + 1/24/60, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '5. 1초 후: ' || TO_CHAR(SYSDATE + 1/24/60/60, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '6. 1초 후: ' || TO_CHAR(SYSDATE + 1/(24*60*60), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
;
SELECT 24*60 AS "1일(분)", 24*60*60 AS "1일(초)" FROM DUAL;

--TO_NUMBER : 숫자타입으로 전환(문자 -> 숫자)
SELECT '12300', TO_NUMBER('12300') FROM DUAL;

SELECT '12300' * 100 FROM DUAL; --문자타입값 * 100 : 오라클에서 자동 형변환 처리
SELECT TO_NUMBER('12300') * 100 FROM DUAL; --숫자타입값 * 10











