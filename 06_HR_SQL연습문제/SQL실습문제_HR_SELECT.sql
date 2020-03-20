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
**********************************************************/
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
SELECT *
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = '100';
  
-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= 15000;
 
-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 15000;
 
-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEES
 WHERE SALARY <= 10000
 ORDER BY SALARY DESC;
 
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'John';
 
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
SELECT E.FIRST_NAME, COUNT(*)
  FROM EMPLOYEES E
GROUP BY E.FIRST_NAME
HAVING FIRST_NAME = 'John';

-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME,' '||LAST_NAME), SALARY, HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE >= TO_DATE('20080101', 'YYYYMMDD') AND HIRE_DATE < TO_DATE('20090101', 'YYYYMMDD')
 ORDER BY HIRE_DATE;
  
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, CONCAT(LAST_NAME,' '||FIRST_NAME), SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 20000 AND SALARY <= 30000;
 
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
SELECT *
  FROM EMPLOYEES E
 WHERE NOT EXISTS (SELECT MANAGER_ID FROM EMPLOYEES WHERE MANAGER_ID = E.MANAGER_ID);

-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
SELECT MAX(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG';

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

-- ������ �ִ� ���޿� �˻�
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID;

-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
SELECT DISTINCT J.JOB_TITLE, MAX(E.SALARY)
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND (SELECT MAX(E.SALARY) FROM EMPLOYEES) >= 10000
GROUP BY J.JOB_TITLE
ORDER BY J.JOB_TITLE;
 
-- ������ ��ձ޿� �̻��� ���� ��ȸ
SELECT EMPLOYEE_ID, SALARY, ���
FROM EMPLOYEES E, (SELECT JOB_ID, AVG(SALARY) ��� FROM EMPLOYEES GROUP BY JOB_ID) A
WHERE E.JOB_ID = A.JOB_ID
AND E.SALARY >= A.���;

-------------------------------------------------------------
-- ������ �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, ����(����)�ڵ�, ������ ��ȸ
SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME,' '||E.LAST_NAME), E.SALARY, E.JOB_ID, J.JOB_TITLE
  FROM EMPLOYEES E, JOBS J, (SELECT JOB_ID, MAX(SALARY) �ִ� FROM EMPLOYEES GROUP BY JOB_ID) M
 WHERE E.JOB_ID = J.JOB_ID
   AND E.SALARY = M.�ִ�;

--�μ��� �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, �μ��ڵ�, �μ��� ���� ��ȸ
SELECT E.EMPLOYEE_ID, CONCAT(E.FIRST_NAME,' '||E.LAST_NAME), E.SALARY, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
  FROM EMPLOYEES E, DEPARTMENTS D, (SELECT DEPARTMENT_ID, MAX(SALARY) �ִ� FROM EMPLOYEES GROUP BY DEPARTMENT_ID) M
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
   AND E.SALARY = M.�ִ�;
   
--�μ��� �ο���, �޿��հ�, ��ձ޿�, ���� ���� �޿�, ���� ���� �޿� 
--�������� �Ŵ��� �̸��� �Բ� ��ȸ