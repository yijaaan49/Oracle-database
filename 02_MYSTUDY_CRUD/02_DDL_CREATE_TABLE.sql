/* *************************
����Ÿ ���Ǿ�
- DDL(Data Definition Language) : ����Ÿ�� �����ϴ� ���
- CREATE(����), DROP(����), ALTER(����)
- {}�ݺ�����, []��������, | �Ǵ�(����)
CREATE TABLE ���̺�� (
{�÷��� ����ŸŸ��
    [NOT NULL | UNIQUE | DEFAULT �⺻�� | CHECK üũ����]
}
    [PRIMARY KEY �÷���]
    {[FOREIGN KEY �÷��� REFERENCES ���̺��(�÷���)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
--------
�÷��� �⺻ ����Ÿ Ÿ��
VARCHAR2(n) : ���ڿ� ��������
CHAR(n) : ���ڿ� ��������
NUMBER(p, s) : ����Ÿ�� p:��ü����, s:�Ҽ������� �ڸ���
  ��) (5,2) : ������ 3�ڸ�, �Ҽ��� 2�ڸ� - ��ü 5�ڸ�
DATE : ��¥�� ��,��,�� �ð� �� ����

���ڿ� ó�� : UTF-8 ���·� ����
- ����, ���ĺ� ����, Ư������ : 1 byte ó��(Ű���� ���� ���ڵ�)
- �ѱ� : 3 byte ó��
***************************/
CREATE TABLE MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --UNIQUE + NOT NULL
    NAME VARCHAR2(30) NOT NULL, 
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(200)
);
-------------------
INSERT INTO MEMBER 
       (ID, NAME, PASSWORD)
VALUES ('hong', 'ȫ�浿', '1234');       

INSERT INTO MEMBER 
       (ID, NAME, PASSWORD)
VALUES ('hong2', 'ȫ�浿', '1234');
---
--cannot insert NULL into ("MYSTUDY"."MEMBER"."PASSWORD")
INSERT INTO MEMBER (ID, NAME) VALUES ('hong3', 'ȫ�浿3');
----
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('hong4', 'ȫ�浿4', '1234');
-------------------------------------
SELECT * FROM MEMBER;
--�÷��� ��������� ���� �ʰ� INSERT�� ����
--���̺� �ִ� ��� �÷��� ���Ͽ� ������� ������ �Է��ؾ� ��
INSERT INTO MEMBER
VALUES ('hong5', 'ȫ�浿5', '1234', '010-1111-1111', '�����');
INSERT INTO MEMBER
VALUES ('hong6', 'ȫ�浿5', '1234', '�����', '010-1111-1111');

INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS, PHONE)
VALUES ('hong7', 'ȫ�浿7', '1234', '�����', '010-1111-1111');
----------
--���� : hong6 ��ȭ��ȣ�� 010-2222-2222 �� ����
--���� : hong6 �ּҸ� '�λ�' ���� ����
SELECT * FROM MEMBER WHERE ID = 'hong6';
UPDATE MEMBER SET PHONE = '010-2222-2222' WHERE ID = 'hong6';
UPDATE MEMBER SET ADDRESS = '�λ�' WHERE ID = 'hong6';
UPDATE MEMBER
   SET PHONE = '010-2222-2222', ADDRESS = '�λ�'
 WHERE ID = 'hong6';
--���� : hong7 ������ ����
--���� : �̸��� ȫ�浿�� ��� ����
SELECT * FROM MEMBER WHERE ID = 'hong7';
DELETE FROM MEMBER WHERE ID = 'hong7';
select * from member where name = 'ȫ�浿';
delete from member where name = 'ȫ�浿';
commit;
--�Է� : ���̵�-hong8, �̸�-ȫ�浿8, ��ȣ-1111, �ּ�-����� ���ʱ�
--�˻�(��ȸ) : �̸��� ȫ�浿8�� ����� ���̵�, �̸�, �ּ� �����͸� ��ȸ
INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS)
VALUES ('hong8', 'ȫ�浿8', '1111', '����� ���ʱ�');
SELECT * FROM MEMBER WHERE ID = 'hong8';
SELECT ID, NAME, ADDRESS FROM MEMBER WHERE NAME = 'ȫ�浿8';
------------------------
INSERT INTO MEMBER
VALUES ('hong9', 'ȫ�浿9', '1234', '�����', '010-1111-1111');
--=====================================
--�÷� Ư���� Ȯ���ϱ� ���� ���̺�
CREATE TABLE TEST (
    NUM NUMBER(5,2), --��ü�ڸ��� 5, ������ 3, �Ҽ��� 2
    STR1 CHAR(10), --��������
    STR2 VARCHAR2(10), --��������
    DATE1 DATE --��¥������ : ����Ͻú���
);
INSERT INTO TEST VALUES (100.456, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.455, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE);
SELECT * FROM TEST;
SELECT '-' || STR1 ||'-', '-'||STR2||'-' FROM TEST; -- || : ���ڿ� ���̱� ��ȣ
INSERT INTO TEST VALUES (100.454, 'DEF', 'DEF  ', SYSDATE);
------------------------
SELECT * FROM TEST WHERE STR1 = STR2; --��ȸ�� ������ ����
SELECT * FROM TEST WHERE STR1 = 'ABC'; --����Ŭ������ ��ȸ��
SELECT * FROM TEST WHERE STR1 = 'ABC       '; --��� DB ����
SELECT * FROM TEST WHERE STR2 = 'DEF'; --'DEF' vs 'DEF  ' �ٸ�������
SELECT * FROM TEST WHERE STR2 = 'DEF  '; --������ ��ȸ��
-------
SELECT * FROM TEST WHERE NUM = 100.45; --NUMBER = NUMBER
SELECT * FROM TEST WHERE NUM = '100.45'; --����Ŭ ��ȸ�� NUMBER = VARCHAR
SELECT * FROM TEST WHERE NUM = '100.45A'; --ORA-01722: invalid number
------
INSERT INTO TEST (STR1, STR2) VALUES ('1234567890', '1234567890');
SELECT * FROM TEST WHERE STR1 = STR2;
SELECT '-' || STR1 ||'-', '-'||STR2||'-' FROM TEST;
--------------------------------
-- UTF-8 Ÿ������ ������ ����
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ABCDEFGHIJ');
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '���ѹα�');--�ѱ� 4 * 3byte = 12
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ȫ�浿');--3 * 3byte = 9

--===================================
-- NULL (��) : ���ڿ�('')�� �ƴϰ�, Ư�� ���� �ƴ� �����Ͱ� ���� ����
-- NULL�� ��ó���� �ȵ� : =, <>, !=, >, <, >=, <= ��ó�� �ǹ̰� ����
-- NULL ���� ���� ����� �׻� NULL(������ �ǹ̵� ����)
-- NULL ���� ���� ��ȸ�� IS NULL, IS NOT NULL �������θ� ��ȸ
-------------------
SELECT * FROM TEST WHERE NUM = NULL; --��ȸ�ȵ�(NULL���� �񱳿��� �ǹ̾���)
SELECT * FROM TEST WHERE NUM IS NULL;
SELECT * FROM TEST WHERE NUM <> NULL; --��ȸ�ȵ�
SELECT * FROM TEST WHERE NUM IS NOT NULL;

-- NULL ���� ���� ���
SELECT 100 + 200, 111 + 222 FROM DUAL; --DUAL ���̺� �ϸ� Dummy ���̺�
select * from dual;
SELECT NUM, NUM + 10 FROM TEST; --NULL���� ���� ����� �׻� NULL
-- ���Ľ� NULL
SELECT * FROM TEST ORDER BY STR2; --�⺻ �������� ����, ASC Ű���� ����
SELECT * FROM TEST ORDER BY STR2 DESC; --DESC : �������� ����
-- ���Ľ� ����Ŭ������ NULL ���� ���� ū ������ ó��(�� �������� ���)
-- NULL���� ���� ����ó�� : NULLS FIRST, NULLS LAST
SELECT * FROM TEST ORDER BY NUM;
SELECT * FROM TEST ORDER BY NUM DESC;
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; --NULL���� ��ó�� ǥ��
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST; --NULL���� �������� ǥ��
-----------------
SELECT NUM FROM TEST;
-- �����Լ� NVL(�÷�, ������) : �÷��� NULL�̸� ���������� ��ȯ
SELECT NUM, NUM + 10, NVL(NUM, 0), NVL(NUM, 0) + 10 FROM TEST;
----
INSERT INTO TEST (NUM, STR1, STR2) VALUES (200, '', NULL); --'' �� NULL ó����
SELECT * FROM TEST WHERE STR1 = ''; --������ ��ȸ �ȵ�
SELECT STR1, STR1 || '-�׽�Ʈ',
       NVL(STR1, '�������') || '-�׽�Ʈ'
  FROM TEST;
--=======================
