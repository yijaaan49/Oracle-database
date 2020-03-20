/* *** DECODE, CASE : SQL�� ������ IF�� ����(CASE : ǥ��SQL)
--DECODE �Լ� : ����񱳸� ����
DECODE(���, �񱳰�, ���=�񱳰� ��� ó����, ���<>�񱳰� ó����);
DECODE(���, �񱳰�, DECODE(), DECODE());
DECODE(���, �񱳰�1, ó����1
          , �񱳰�2, ó����2
          ...
          , �񱳰�n, ó����n
          , ó����n+1)
**********************************/
SELECT * FROM CUSTOMER ORDER BY NAME;
--�̸��� �迬�Ƹ� '��~ �迬�ƴ�!!!' �ƴϸ� '�׳� ���' ���
SELECT NAME, DECODE(NAME, '�迬��','��~ �迬�ƴ�!!!', '�׳� ���')
 FROM CUSTOMER ORDER BY NAME;
--�̸��� �������̸� '�౸����', �ƴϸ� '�����'
SELECT NAME,
       DECODE(NAME, '������', '�౸����', '�����')
       FROM CUSTOMER
       ORDER BY NAME;
--�̸��� �迬�Ƹ� '�ǰܽ�������',  �ڼ����� '����', �������̸� '�౸'
--������ '�����'
SELECT NAME,
       DECODE(NAME, '�迬��', '�ǰܽ�������',
                    '�ڼ���', '����',
                    '������', '�౸',
                    '�����')
       FROM CUSTOMER
       ORDER BY NAME;
--------------------------------
--DECODE �� DECODE�� ���
SELECT NAME,
       DECODE(NAME, '�迬��', '�ǰܽ�������',
                     DECODE(NAME, '�ڼ���', '����',
                                DECODE(NAME, '������', '�౸', '�����')
                            )
             ) AS "�"
        FROM CUSTOMER
        ORDER BY NAME;

--===============================================
/***** CASE WHEN �� ************
����1 : SWITCH CASEó��(DECODE�� ó��)
CASE �÷�(���ذ�)
     WHEN �񱳰�1 THEN ��ġ�ϸ� ó���� ����
     WHEN �񱳰�2 THEN ��ġ�ϸ� ó���� ����
     ...
     WHEN �񱳰�n THEN ��ġ�ϸ� ó���� ����
     ELSE ���� ��ġ�ϴ� ��찡 ������ ������ ����
END
--------
����2 : IF THEN ELSE ó�� ���(�ε�� ó�� ����)
--CASE�� ���� ó�����忡�� CASE�ߺ� ��� ����
--�񱳱��� : =, <>, !=, >, <, >=, <=, AND, OR, NOT ��밡��
CASE WHEN �񱳱���
     THEN �񱳱��� ��� TRUE�� ��� ó������
     ELSE �񱳱��� ��� FALSE�� ��� ó������
END   
------
CASE WHEN �񱳱���(��: KOR > 90)
     THEN (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
     ELSE (CASE WHEN THEN (CASE WHEN THEN ELSE END) 
                     ELSE (CASE WHEN THEN ELSE END)
           END)
END   
-----
CASE WHEN �񱳱��� THEN ó������
     WHEN �񱳱��� THEN ó������
     ....
     ELSE ���� �񱳱����� �ش���� �ʴ� ��� ó������
END 
***************************/

SELECT * FROM CUSTOMER ORDER BY NAME;
--�̸��� �������̸� '�౸����' �ƴϸ� �������
SELECT NAME, CASE NAME WHEN '������' THEN '�������' ELSE '�����' END
FROM CUSTOMER
ORDER BY NAME;
--
SELECT NAME, 
        CASE NAME WHEN '������' 
            THEN '�������' 
            ELSE '�����' 
        END
FROM CUSTOMER
ORDER BY NAME;
-----
--�̸��� �迬�� -> �ǰܽ�������, �ڼ��� -> ����, ������ -> �౸, ������ �����
SELECT NAME,
    CASE NAME
        WHEN '�迬��' THEN '�ǰܽ�������'
        WHEN '������' THEN '����'
        WHEN '������' THEN '�౸'
        ELSE '�����'
    END
    FROM CUSTOMER 
    ORDER BY NAME;
    
    --���ڵ� ������ �Ѱ谡 �ִ�.
    -----------------
    -- BOOK ���̺����� �̿��� �� ó��
    SELECT * FROM BOOK ORDER BY PRICE;
    SELECT * FROM BOOK WHERE PRICE >=10000;
    
    --- ����(PRICE) �� 10000�̸��̸� �򰡸� ���. 10000~20000 : �����ϴ�
    -----200000���� ũ�� '�߽δ�', '30000 ����,
    SELECT B.*, CASE WHEN PRICE < 10000
                THEN '�δ�'
                ELSE CASE WHEN PRICE <=20000
                THEN '�����ϴ�'
                ELSE CASE WHEN PRICE <=30000
                THEN '��δ�'
                ELSE CASE WHEN PRICE >30000
                THEN '�ʹ���δ�'
                END
                END
                END
                END AS "������"
    FROM BOOK B;
    ---------------------------
    SELECT B.*,
    CASE WHEN PRICE < 10000 THEN '�δ�'
         WHEN PRICE <= 20000 THEN '�����ϴ�'
         WHEN PRICE <= 30000 THEN '��δ�'
    END AS "������"
    FROM BOOK B;
    
    