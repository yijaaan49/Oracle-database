SELECT * FROM STUDENT;
INSERT INTO STUDENT 
       (ID, NAME, KOR, ENG, MATH) 
VALUES ('2019001', 'ȫ�浿', 100, 90, 80);
INSERT INTO STUDENT
VALUES ('2019002', '������', 90, 80, 70, 0, 0);
INSERT INTO STUDENT
       (NAME, ID, KOR, ENG, MATH)
VALUES ('������', '2019003', 95, 90, 80);
COMMIT;
----------------------
--���� : ������ ����(UPDATE)
--������ �������� 80 -> 88 ����
UPDATE STUDENT
   SET MATH = 88
 WHERE NAME = '������';
COMMIT;
SELECT * FROM STUDENT WHERE NAME = '������';
--���� : ������ -> �������� �̸� ����
SELECT * FROM STUDENT WHERE NAME = '������';
SELECT * FROM STUDENT WHERE NAME = '��������';
UPDATE STUDENT 
   SET NAME = '��������' 
 WHERE NAME = '������'
;
UPDATE STUDENT 
   SET NAME = '��������' 
 WHERE ID = '2019002';
----------------------
--���� : ������ ����(DELETE)
--������ ����
SELECT * FROM STUDENT WHERE NAME = '������';
DELETE FROM STUDENT WHERE NAME = '������';


