/************************************************
�����Լ� ����ȯ - ���ڿ� -> ��¥, ���� -> ���ڿ�...
TO_CHAR : ����Ÿ������ ��ȯ(��¥ -> ����, ���� -> ����)
TO_DATE : ��¥Ÿ������ ��ȯ(���� -> ��¥)
TO_NUMBER : ����Ÿ������ ��ȯ(���� -> ����)

      <- TO_NUMBER(����)  -> TO_DATE(����)
������   ----    ������   ----     ��¥��
      -> TO_CHAR(����)   <- TO_CHAR(��¥)
************************************************
--��¥ -> ����
TO_CHAR(��¥������, '�������')
<�������>
�⵵(YYYY, YY), ��(MM), ��(DD)
�ð� : HH, HH12(12 �ð���), HH24(24 �ð���)
��(MI), ��(SS)
����, ����: AM, PM
����Ͻú��� �ۼ���) YYYY-MM-DD HH24:MI:SS
************************************************/
--TO_CHAR : ����Ÿ������ ��ȯ(��¥ -> ����, ���� -> ����)
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; --'2019-11-05'
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD DAY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD DY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY.MM.DD(DY)') FROM DUAL; --2019.11.05(ȭ)

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD PM HH:MI:SS') FROM DUAL;

--======================
/* TO_CHAR(����, '�������') : ���� -> ����Ÿ��
<��������>
0(��) : �ڸ����� ��Ÿ����, �ڸ����� ���� ���� ��� 0�� ǥ��
9(��) : �ڸ����� ��Ÿ����, �ڸ����� ���� ���� ��� ä���� ����(ǥ�þ���)
L : ���� ��ȭ ��ȣ ǥ��
.(��) : �Ҽ���
,(�޸�) : 1000���� ���� ��ȣ
---------------------------*/
SELECT 123000, TO_CHAR(123000), '123000', TO_NUMBER('123000') FROM DUAL;
SELECT 123000 + 10, TO_CHAR(123000) + 10
     , '123000' + 10, TO_NUMBER('123000') + 10 
  FROM DUAL;
SELECT TO_CHAR(123000, 'L999,999,999'), TO_CHAR(123000, 'L000,000,000')
  FROM DUAL;
SELECT TO_CHAR(1230.55, 'L999,999.999'), TO_CHAR(1230.55, 'L000,000.000')
  FROM DUAL;  

--TO_DATE : ��¥Ÿ������ ��ȯ(���� -> ��¥)
SELECT '2019-11-05', TO_DATE('2019-11-05', 'YYYY-MM-DD') FROM DUAL;
SELECT '2019-11-05', TO_DATE('2019-11-05', 'YYYY-MM-DD') + 1 FROM DUAL;
SELECT '20191105', TO_DATE('20191105', 'YYYYMMDD') FROM DUAL;
SELECT '2019-11-05 14:57:30', 
       TO_DATE('2019-11-05 14:57:30', 'YYYY-MM-DD HH24:MI:SS')
  FROM DUAL;
----------------------------
SELECT '0.���糯¥:'|| SYSDATE FROM DUAL
UNION
SELECT '1. ����: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '2. 1�� ��: ' || TO_CHAR(SYSDATE + 1, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '3. 1�ð� ��: ' || TO_CHAR(SYSDATE + 1/24, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '4. 1�� ��: ' || TO_CHAR(SYSDATE + 1/24/60, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '5. 1�� ��: ' || TO_CHAR(SYSDATE + 1/24/60/60, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
UNION
SELECT '6. 1�� ��: ' || TO_CHAR(SYSDATE + 1/(24*60*60), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL
;
SELECT 24*60 AS "1��(��)", 24*60*60 AS "1��(��)" FROM DUAL;

--TO_NUMBER : ����Ÿ������ ��ȯ(���� -> ����)
SELECT '12300', TO_NUMBER('12300') FROM DUAL;

SELECT '12300' * 100 FROM DUAL; --����Ÿ�԰� * 100 : ����Ŭ���� �ڵ� ����ȯ ó��
SELECT TO_NUMBER('12300') * 100 FROM DUAL; --����Ÿ�԰� * 10











