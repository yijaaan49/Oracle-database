/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
-- 사번(employee_id)이 100인 직원 정보 전체 보기
-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
-- 이름(first_name)이 john인 사원의 모든 정보 조회
-- 이름(first_name)이 john인 사원은 몇 명인가?
-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
-- 직종별 최대 월급여 검색
-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
-- 직종별 평균급여 이상인 직원 조회
**********************************************************/
-- 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT *
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = '100';
  
-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 15000;
 
-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 15000;
 
-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEES
 WHERE SALARY <= 10000
 ORDER BY SALARY DESC;
 
-- 이름(first_name)이 john인 사원의 모든 정보 조회
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'John';
 
-- 이름(first_name)이 john인 사원은 몇 명인가?
SELECT E.FIRST_NAME, COUNT(*)
  FROM EMPLOYEES E
GROUP BY E.FIRST_NAME
HAVING FIRST_NAME = 'John';

-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,' '||LAST_NAME), SALARY, HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE >= TO_DATE('20080101', 'YYYYMMDD') AND HIRE_DATE < TO_DATE('20090101', 'YYYYMMDD')
 ORDER BY HIRE_DATE;
  
-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT EMPLOYEE_ID, CONCAT(LAST_NAME,' '||FIRST_NAME), SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 20000 AND SALARY <= 30000;
 
-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT *
  FROM EMPLOYEES E
 WHERE NOT EXISTS (SELECT MANAGER_ID FROM EMPLOYEES WHERE MANAGER_ID = E.MANAGER_ID);

-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG';

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

-- 직종별 최대 월급여 검색
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;

-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
SELECT DISTINCT J.JOB_TITLE, MAX(E.SALARY)
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND (SELECT MAX(E.SALARY) FROM EMPLOYEES) >= 10000
GROUP BY J.JOB_TITLE
ORDER BY J.JOB_TITLE;
 
-- 직종별 평균급여 이상인 직원 조회
SELECT EMPLOYEE_ID, SALARY, 평균
FROM EMPLOYEES E, (SELECT JOB_ID, AVG(SALARY) 평균 FROM EMPLOYEES GROUP BY JOB_ID) A
WHERE E.JOB_ID = A.JOB_ID
AND E.SALARY >= A.평균;

-------------------------------------------------------------
-- 직종별 최대 월급여를 받는 직원의 사번, 성명, 월급여, 직종(직무)코드, 직종명 조회
SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME,' '||E.LAST_NAME), E.SALARY, E.JOB_ID, J.JOB_TITLE
  FROM EMPLOYEES E, JOBS J, (SELECT JOB_ID, MAX(SALARY) 최대 FROM EMPLOYEES GROUP BY JOB_ID) M
 WHERE E.JOB_ID = J.JOB_ID
   AND E.SALARY = M.최대;

--부서별 최대 월급여를 받는 직원의 사번, 성명, 월급여, 부서코드, 부서명 정보 조회
SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME,' '||E.LAST_NAME), E.SALARY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D, (SELECT DEPARTMENT_ID, MAX(SALARY) 최대 FROM EMPLOYEES GROUP BY DEPARTMENT_ID) M
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
   AND E.SALARY = M.최대;
   
--부서별 인원수, 급여합계, 평균급여, 가장 많은 급여, 가장 적은 급여 
--직원들의 매니저 이름을 함께 조회