/********** Ʈ����(TRIGGER) ******************
Ʈ����(TRIGGER) : Ư�� �̺�Ʈ�� DDL, DML ������ ����Ǿ��� ��,
   �ڵ������� � �Ϸ��� ����(Operation)�̳� ó���� �����ϵ��� �ϴ�
   ����Ÿ���̽� ��ü�� �ϳ�
  -�Ϲ������� ������ ���̺� ����Ÿ�� �߰�(NSERT), ����(DELETE), ����(UPDATE) �� ��,
    �ٸ� ���� ���迡 �ִ� ���̺��� ����Ÿ�� �ڵ������� ������ ��쿡 ���

CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
  BEFORE [OR AFTER]
  UPDATE [OR DELETE OR INSERT] ON ���̺��
  [FOR EACH ROW]
DECLARE
  ���������;
BEGIN
  ���α׷� ���� ������;
END;  
-------------------------------
<Ʈ���� ����ñ� ����>
BEFORE : ������ ó���� ����Ǳ� �� ����(INSERT, UPDATE, DELETE �� ������)
AFTER : ������ ó���� ����� �� ����(INSERT, UPDATE, DELETE �� ������)

�̺�Ʈ ���� ���� : INSERT, UPDATE, DELETE
�̺�Ʈ �߻� ���̺� ���� : ON ���̺��

<ó������ ����>
FOR EACH ROW : ����Ÿ ó���� �ǰ��� Ʈ���� ����. �� �ɼ��� ������ 
  �⺻���� ���� ���� Ʈ���ŷ� ����Ǹ� ������, �Ŀ� �ѹ����� Ʈ���� ����

DECLARE : ���� ���� �� ��� Ű����
--------------------
<�÷��� ���>
OLD.�÷��� : SQL �ݿ� ���� �÷� ����Ÿ�� �ǹ�
NEW.�÷��� : SQL �ݿ� ���� �÷� ����Ÿ�� �ǹ�
---------------------
<Ʈ���� ����, Ȱ��, ��Ȱ��>
- ���� : DROP TRIGGER Ʈ���Ÿ�;
- Ȱ�� : ALTER TRIGGER Ʈ���Ÿ� enable;
- ��Ȱ�� : ALTER TRIGGER Ʈ���Ÿ� disable;
*****************************************/
--BOOK ���̺� ���� �α�(LOG �̷�)�� ���� ���̺� �ۼ�
CREATE TABLE BOOK_LOG (
    BOOKID NUMBER(5),
    BOOKNAME VARCHAR2(100),
    PUBLISHER VARCHAR2(100),
    PRICE VARCHAR2(100),
    LOGDATE DATE DEFAULT SYSDATE,
    JOB_GUBUN VARCHAR2(100)
);
--Ʈ���� �ۼ�
--BOOK ���̺� �����Ͱ� �Է�(INSERT)�Ǹ� BOOK_LOG�� �̷� �����
--Ʈ���Ÿ� : AFTER_INSERT_BOOK
create or replace TRIGGER AFTER_INSERT_BOOK 
    AFTER INSERT ON BOOK 
    FOR EACH ROW
DECLARE
BEGIN
    --�̷� �����
    INSERT INTO BOOK_LOG
        (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
    VALUES (:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER,
            :NEW.PRICE, 'INSERT');
END;
--============================
--UPDATE Ʈ���� �ۼ� : AFTER_UPDATE_BOOK
--BOOK ���̺� �����Ͱ� ����(UPDATE)�Ǹ� �̷³����
CREATE OR REPLACE TRIGGER AFTER_UPDATE_BOOK 
    AFTER UPDATE ON BOOK --BOOK���̺� �����۾� �߻��� ����
    FOR EACH ROW --�����Ǵ� ��� �����Ϳ� ���Ͽ� Ʈ���� ����
BEGIN
    --�α� �����
    INSERT INTO BOOK_LOG
           (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
    VALUES (:NEW.BOOKID
         ,  :OLD.BOOKNAME ||' > ' || :NEW.BOOKNAME
         ,  :OLD.PUBLISHER ||' > '|| :NEW.PUBLISHER
         ,  :OLD.PRICE ||' > '|| :NEW.PRICE
         ,  'UPDATE');
END;
--------
SELECT * FROM BOOK WHERE BOOKID = 35;
UPDATE BOOK
   SET BOOKNAME = '�ڹٶ� �����ΰ�'
     , PRICE = 35000
 WHERE BOOKID = 35;
--=========================
--(�ǽ�) DELETE Ʈ���� �ۼ��ϰ� ���� �׽�Ʈ ����
--Ʈ���Ÿ� : AFTER_DELETE_BOOK
--������ BOOK ���̺� �����Ͱ� �����Ǹ� BOOK_LOG ���̺� �̷� �����
----------
create or replace TRIGGER AFTER_DELETE_BOOK 
    AFTER DELETE ON BOOK 
    FOR EACH ROW
DECLARE
BEGIN
    --�̷� �����
    INSERT INTO BOOK_LOG
        (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
    VALUES (:OLD.BOOKID, :OLD.BOOKNAME, :OLD.PUBLISHER,
            :OLD.PRICE, 'DELETE');
END;
------
INSERT INTO BOOK VALUES (36, '�����ͺ��̽� ������', 'ITBOOK', 30000);
SELECT * FROM BOOK WHERE BOOKID > 30;
--DELETE Ʈ���� ���ۿ��� Ȯ���� ���� ���� �۾� ����
DELETE FROM BOOK WHERE BOOKID > 30; 
--DELETE �α� ���Ҵ��� Ȯ��
SELECT * FROM BOOK_LOG;
--================================
--INSERT, UPDATE, DELETE �̺�Ʈ�� �߻��� �� ������ Ʈ����
create or replace TRIGGER TRIGGER_IUD
    AFTER INSERT OR UPDATE OR DELETE ON BOOK
    FOR EACH ROW
BEGIN
    --INSERT �̺�Ʈ �߻��� �α� �����
    IF INSERTING THEN
        INSERT INTO BOOK_LOG
            (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
        VALUES (:NEW.BOOKID, :NEW.BOOKNAME, :NEW.PUBLISHER,
                :NEW.PRICE, 'INSERT-IUD');
    END IF;
    --UPDATE �̺�Ʈ �߻��� �α� �����
    IF UPDATING THEN
        INSERT INTO BOOK_LOG
               (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
        VALUES (:NEW.BOOKID
             ,  :OLD.BOOKNAME ||' > ' || :NEW.BOOKNAME
             ,  :OLD.PUBLISHER ||' > '|| :NEW.PUBLISHER
             ,  :OLD.PRICE ||' > '|| :NEW.PRICE
             ,  'UPDATE-IUD');
    END IF;
    --DELETE �̺�Ʈ �߻��� �α� �����
    IF DELETING THEN
        INSERT INTO BOOK_LOG
            (BOOKID, BOOKNAME, PUBLISHER, PRICE, JOB_GUBUN)
        VALUES (:OLD.BOOKID, :OLD.BOOKNAME, :OLD.PUBLISHER,
                :OLD.PRICE, 'DELETE-IUD');    
    END IF;
END;
---------------------
SELECT * FROM BOOK;
INSERT INTO BOOK VALUES (40, '�����ͺ��̽� ������2', 'ITBOOK', 35000);
SELECT * FROM BOOK_LOG;
INSERT INTO BOOK VALUES (41, '�����ͺ��̽� ������3', 'ITBOOK', 40000);
----
UPDATE BOOK SET PUBLISHER = 'ITBOOKS', PRICE = 44000 
 WHERE BOOKID >= 40;
----
DELETE FROM BOOK WHERE BOOKID >= 40;









