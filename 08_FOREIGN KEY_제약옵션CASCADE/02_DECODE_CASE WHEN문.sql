/* *** DECODE, CASE : SQL문 내에서 IF문 구현(CASE : 표준SQL)
--DECODE 함수 : 동등비교만 가능
DECODE(대상, 비교값, 대상=비교값 경우 처리문, 대상<>비교값 처리문);
DECODE(대상, 비교값, DECODE(), DECODE());
DECODE(대상, 비교값1, 처리문1
          , 비교값2, 처리문2
          ...
          , 비교값n, 처리문n
          , 처리문n+1)
**********************************/
SELECT * FROM CUSTOMER ORDER BY NAME;
--이름이 김연아면 '야~ 김연아다!!!' 아니면 '그냥 사람' 출력
SELECT NAME, DECODE(NAME, '김연아','야~ 김연아다!!!', '그냥 사람')
 FROM CUSTOMER ORDER BY NAME;
--이름이 박지성이면 '축구선수', 아니면 '운동선수'
SELECT NAME,
       DECODE(NAME, '박지성', '축구선수', '운동선수')
       FROM CUSTOMER
       ORDER BY NAME;
--이름이 김연아면 '피겨스케이팅',  박세리면 '골프', 박지성이면 '축구'
--나머지 '운동선수'
SELECT NAME,
       DECODE(NAME, '김연아', '피겨스케이팅',
                    '박세리', '골프',
                    '박지성', '축구',
                    '운동선수')
       FROM CUSTOMER
       ORDER BY NAME;
--------------------------------
--DECODE 문 DECODE문 사용
SELECT NAME,
       DECODE(NAME, '김연아', '피겨스케이팅',
                     DECODE(NAME, '박세리', '골프',
                                DECODE(NAME, '박지성', '축구', '운동선수')
                            )
             ) AS "운동"
        FROM CUSTOMER
        ORDER BY NAME;

--===============================================
/***** CASE WHEN 문 ************
형태1 : SWITCH CASE처럼(DECODE문 처럼)
CASE 컬럼(기준값)
     WHEN 비교값1 THEN 일치하면 처리할 구문
     WHEN 비교값2 THEN 일치하면 처리할 구문
     ...
     WHEN 비교값n THEN 일치하면 처리할 구문
     ELSE 위에 일치하는 경우가 없으면 실행할 구문
END
--------
형태2 : IF THEN ELSE 처럼 사용(부등비교 처리 가능)
--CASE문 내의 처리문장에는 CASE중복 사용 가능
--비교구문 : =, <>, !=, >, <, >=, <=, AND, OR, NOT 사용가능
CASE WHEN 비교구문
     THEN 비교구문 결과 TRUE인 경우 처리구문
     ELSE 비교구문 결과 FALSE인 경우 처리구문
END   
------
CASE WHEN 비교구문(예: KOR > 90)
     THEN (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
     ELSE (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
END   
-----
CASE WHEN 비교구문 THEN 처리구문
     WHEN 비교구문 THEN 처리구문
     ....
     ELSE 위의 비교구문에 해당되지 않는 경우 처리구문
END 
***************************/

SELECT * FROM CUSTOMER ORDER BY NAME;
--이름이 박지성이면 '축구선수' 아니면 운동동선수
SELECT NAME, CASE NAME WHEN '박지성' THEN '축수선수' ELSE '운동선수' END
FROM CUSTOMER
ORDER BY NAME;
--
SELECT NAME, 
        CASE NAME WHEN '박지성' 
            THEN '축수선수' 
            ELSE '운동선수' 
        END
FROM CUSTOMER
ORDER BY NAME;
-----
--이름이 김연아 -> 피겨스케이팅, 박세리 -> 골프, 박지성 -> 축구, 나머지 운동선수
SELECT NAME,
    CASE NAME
        WHEN '김연아' THEN '피겨스케이팅'
        WHEN '박지성' THEN '골프'
        WHEN '박지성' THEN '축구'
        ELSE '운동선수'
    END
    FROM CUSTOMER 
    ORDER BY NAME;
    
    --디코드 문장은 한계가 있다.
    -----------------
    -- BOOK 테이블가격을 이용한 비교 처리
    SELECT * FROM BOOK ORDER BY PRICE;
    SELECT * FROM BOOK WHERE PRICE >=10000;
    
    --- 가격(PRICE) 이 10000미만이면 평가를 사다. 10000~20000 : 적당하다
    -----200000보다 크럼 '삐싸다', '30000 보다,
    SELECT B.*, CASE WHEN PRICE < 10000
                THEN '싸다'
                ELSE CASE WHEN PRICE <=20000
                THEN '적당하다'
                ELSE CASE WHEN PRICE <=30000
                THEN '비싸다'
                ELSE CASE WHEN PRICE >30000
                THEN '너무비싸다'
                END
                END
                END
                END AS "가격평가"
    FROM BOOK B;
    ---------------------------
    SELECT B.*,
    CASE WHEN PRICE < 10000 THEN '싸다'
         WHEN PRICE <= 20000 THEN '적당하다'
         WHEN PRICE <= 30000 THEN '비싸다'
    END AS "가격평가"
    FROM BOOK B;
    
    