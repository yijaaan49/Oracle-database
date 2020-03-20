--UNION, UNION ALL : ������ ó��
----��, ��ȸ�ϴ� �÷� �̸�, ����, ����, Ÿ���� ��ġ�ϵ��� �ۼ�
--UNION : �ߺ������ʹ� �ϳ��� ǥ���ϴ� ���·� ������
--UINON ALL : �ߺ������͵� ��� �����ؼ� ������
---------------------------
--UNION ��� ����
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
 ORDER BY NAME
;
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --��̶�, �߽ż�, �ڼ���
 ORDER BY NAME
;
---- UNION ���� ���ϱ�
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
UNION
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --��̶�, �߽ż�, �ڼ���
 ORDER BY NAME
;
---- UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --��̶�, �߽ż�, �ڼ���
-- ORDER BY NAME
;
---------------------
--MINUS : ������(���⿬��)
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
MINUS
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --��̶�, �߽ż�, �ڼ���
;
--------------------
-- INTERSECT : ������(�ߺ������� ��ȸ) - ���ι��� ����� ����� ����
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
INTERSECT
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --��̶�, �߽ż�, �ڼ���
;
-- JOIN��
SELECT A.*
  FROM (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (1, 2, 3) --������, �迬��, ��̶�
       ) A,
       (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (3, 4, 5) --��̶�, �߽ż�, �ڼ���
       ) B
WHERE A.CUSTID = B.CUSTID;






