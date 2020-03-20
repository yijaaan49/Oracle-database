CREATE TABLE STUDENT (
    ID VARCHAR2(20), 
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3,0),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2)
);
--------------------------------------------
SELECT * FROM STUDENT;
--������ �߰� : ������ �Է�(INSERT)
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019001', 'ȫ�浿', 100, 90, 80);

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019002', '������', 90, 90, 90);
COMMIT; --�����͸� ���� Ȯ��(DB�� ����)
ROLLBACK; --�۾����(���� COMMIT ��ġ�� ���� ���� �۾� ���)
----------------------------------
--���� : ������ ����(UPDATE)
--������ �������� : 90 -> 88 ����
UPDATE STUDENT 
   SET KOR = 77, MATH = 88 
WHERE NAME = '������';
SELECT * FROM STUDENT;
-------------------------------
--���� : ������ ����(DELETE)
SELECT * FROM STUDENT WHERE NAME = '������';
DELETE FROM STUDENT WHERE ID = '2019002';


