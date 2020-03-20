/* ** �ǽ����� : HR����(DB)���� �䱸���� �ذ� **********
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
-- ������ �ִ� ���޿� �˻�
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
-- ������ ��ձ޿� �̻��� ���� ��ȸ
-------
--������ �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, ����(����)�ڵ�, ������ ���� ��ȸ
--�μ��� �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, �μ��ڵ�, �μ��� ���� ��ȸ
--�μ��� �ο���, �޿��հ�, ��ձ޿�, ���� ���� �޿�, ���� ���� �޿� 
--�������� �Ŵ��� �̸��� �Բ� ��ȸ
**********************************************************/
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
SELECT * FROM EMPLOYEES WHERE employee_id = 100;

-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
SELECT * FROM employees WHERE SALARY >= 15000;

-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, hire_date, SALARY
  FROM employees 
 WHERE SALARY >= 15000;

-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
SELECT EMPLOYEE_ID, LAST_NAME, hire_date, SALARY
  FROM employees 
 WHERE SALARY <= 10000
 ORDER BY SALARY DESC
;
 
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
SELECT * FROM employees
 WHERE FIRST_NAME = 'John'
;
SELECT * FROM employees
 WHERE FIRST_NAME = INITCAP('john')
;
SELECT EMPLOYEE_ID, FIRST_NAME, UPPER(FIRST_NAME), UPPER('john') 
  FROM employees
 WHERE UPPER(FIRST_NAME) = UPPER('john')
;
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
SELECT COUNT(*) 
  FROM employees
 WHERE FIRST_NAME = INITCAP('john')
;
-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, 
       SALARY, HIRE_DATE
  FROM employees
 WHERE HIRE_DATE BETWEEN TO_DATE('2007/01/01', 'YYYY/MM/DD') 
                     AND TO_DATE('2007/12/31', 'YYYY/MM/DD')
 ORDER BY HIRE_DATE                    
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, 
       SALARY, HIRE_DATE
  FROM employees
 WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2007'
 ORDER BY HIRE_DATE                    
;
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, SALARY
  FROM employees
 WHERE SALARY >= 20000 AND  SALARY <= 30000
;
SELECT EMPLOYEE_ID, FIRST_NAME ||' '|| LAST_NAME AS FULLNAME, SALARY
  FROM employees
 WHERE SALARY BETWEEN 20000 AND 30000
;
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
SELECT * FROM employees WHERE MANAGER_ID IS NULL;

-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
SELECT MAX(SALARY) FROM employees
 WHERE JOB_ID = 'IT_PROG'
;
-- ����(JOB_ID)�� �ִ� ���޿� �˻�
SELECT JOB_ID, COUNT(*), SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY)
  FROM employees
 GROUP BY JOB_ID
 ORDER BY 4 DESC
;
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
SELECT JOB_ID, MAX(SALARY) MAX_SALARY
  FROM employees
 GROUP BY JOB_ID
 HAVING MAX(SALARY) >= 10000
 ORDER BY MAX_SALARY
;
SELECT *
  FROM (SELECT JOB_ID, MAX(SALARY) MAX_SALARY
          FROM employees
         GROUP BY JOB_ID
       ) A
 WHERE MAX_SALARY >= 10000
 ORDER BY MAX_SALARY
;    
-- ������ ��ձ޿� �̻��� ���� ��ȸ
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.JOB_ID
     , A.*
  FROM employees E,
       (SELECT JOB_ID, AVG(SALARY) AVG_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID
       ) A 
 WHERE E.JOB_ID = A.JOB_ID --��������
   AND SALARY >= A.AVG_SALARY --�˻�����(ã�� ����)
 ORDER BY E.JOB_ID, E.SALARY DESC
;
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.JOB_ID
     --, (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID) AVG_SALARY
  FROM employees E
 WHERE E.SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES
                     WHERE JOB_ID = E.JOB_ID)
;
-------
--������ �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, ����(����)�ڵ�, ������ ���� ��ȸ
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.JOB_ID
     , (SELECT JOB_TITLE FROM JOBS WHERE JOB_ID = E.JOB_ID) JOB_TITLE
     --, (SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = E.JOB_ID) MAX_SALARY
  FROM employees E
 WHERE E.SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES
                     WHERE JOB_ID = E.JOB_ID)
;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.JOB_ID
     , j.job_title
     , '------'
     , A.*
  FROM employees E,
       JOBS J,
       (SELECT JOB_ID, MAX(SALARY) MAX_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID
       ) A 
 WHERE E.JOB_ID = A.JOB_ID --��������
   AND E.JOB_ID = J.JOB_ID
   AND SALARY = A.MAX_SALARY --�˻�����(ã�� ����)
 ORDER BY E.JOB_ID, E.SALARY DESC
;
--�μ��� �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, �μ��ڵ�, �μ��� ���� ��ȸ
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, e.department_id
     , (SELECT department_name FROM DEPARTMENTS 
         WHERE department_id = e.department_id) AS DEPT_NAME
  FROM employees E
 WHERE E.SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES
                     WHERE department_id = E.department_id)
;
--�μ��� �ο���, �޿��հ�, ��ձ޿�, ���� ���� �޿�, ���� ���� �޿�
SELECT DEPARTMENT_ID, COUNT(*), SUM(SALARY), AVG(SALARY), 
       MAX(SALARY), MIN(SALARY)
  FROM employees
 GROUP BY DEPARTMENT_ID
;
--�������� �Ŵ��� �̸��� �Բ� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
     , (SELECT FIRST_NAME FROM EMPLOYEES 
         WHERE EMPLOYEE_ID = E.MANAGER_ID) AS MANAGER_NAME
  FROM EMPLOYEES E
;
---------
--JOIN��(SELF JOIN��)
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.MANAGER_ID
     , M.EMPLOYEE_ID AS M_EMPLOYEE_ID, M.FIRST_NAME M_FNAME
  FROM EMPLOYEES E,
       EMPLOYEES M
 WHERE E.MANAGER_ID = M.EMPLOYEE_ID
;



