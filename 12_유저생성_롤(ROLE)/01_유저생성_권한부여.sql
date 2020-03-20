/* ********* ����� ����, ���� *********
-- ����� ���� : CREATE USER
CREATE USER ����ڸ�(������) --"MDGUEST" 
IDENTIFIED BY ��й�ȣ --"mdguest"  
DEFAULT TABLESPACE ���̺����̽� --"USERS"
TEMPORARY TABLESPACE �ӽ��۾����̺����̽� --"TEMP";

-- ����� �뷮 ����(����)
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";

-- ����� ���� : ALTER USER 
ALTER USER ����ڸ�(������) IDENTIFIED BY ��й�ȣ;

-- ���Ѻο�(�� ��� ���� �ο�, �� �ο�)
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;

-- ����� ���� : DROP USER
DROP USER ������ [CASCADE];
--CASCADE : ���������� �����(����)�� ������ ��� ����Ÿ ����
*************************************/
--(�����ڰ���) �������� ������ ���� SYSTEM �������� �۾� ����
-- USER SQL
CREATE USER "MDGUEST" IDENTIFIED BY "mdguest"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";
-- QUOTAS
ALTER USER "MDGUEST" QUOTA UNLIMITED ON "USERS";
-- ROLES
GRANT "CONNECT" TO "MDGUEST" ;
GRANT "RESOURCE" TO "MDGUEST" ;
--------------------------------------
--CONNECT, RESOURCE ��(ROLE)�� �ִ� ���� Ȯ��
SELECT *
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE IN ('CONNECT', 'RESOURCE')
;
GRANT CONNECT, RESOURCE TO MDGUEST;
--=============================
/****** ���� �ο�(GRANT), ���� ���(REVOKE) **********************
GRANT ���� [ON ��ü] TO {�����|ROLE|PUBLIC,.., n} [WITH GRANT OPTION]
--PUBLIC�� ��� ����ڿ��� ������ �ǹ�

GRANT ���� TO �����; --������ ����ڿ��� �ο�
GRANT ���� ON ��ü TO �����; -��ü�� ���� ������ ����ڿ��� �ο�
-->> WITH GRANT OPTION :��ü�� ���� ������ ����ڿ��� �ο� 
-- ������ ���� ����ڰ� �ٸ� ����ڿ��� ���Ѻο��� �Ǹ� ����
GRANT ���� ON ��ü TO ����� WITH GRANT OPTION;
--------------------
-->>>���� ���(REVOKE)
REVOKE ���� [ON ��ü] FROM {�����|ROLE|PUBLIC,.., n} CASCADE
--CASCADE�� ����ڰ� �ٸ� ����ڿ��� �ο��� ���ѱ��� ��ҽ�Ŵ
  (Ȯ�� �� ���� �� �۾�)

REVOKE ���� FROM �����; --������ ����ڿ��� �ο�
REVOKE ���� ON ��ü FROM �����; -��ü�� ���� ������ ����ڿ��� �ο�
*************************************************/
--MDGUEST ���� MADANG.BOOK ������ �ο�(GRANT)
GRANT SELECT ON MADANG.BOOK TO MDGUEST;

--(MDGUEST����)SELECT������ ���� BOOK ���̺� ���ؼ���
SELECT * FROM MADANG.BOOK; --��밡��
UPDATE MADANG.BOOK SET PRICE = 0; --���Ѿ��� UPDATE����
DELETE FROM BOOK; --���Ѿ��� DELETE ����

SELECT * FROM MADANG.CUSTOMER;--������
--============================
--(SYSTEM) MDGUEST���� SELECT, UPDATE ���Ѻο�(CUSTOMER ���̺�)
GRANT SELECT, UPDATE ON MADANG.CUSTOMER TO MDGUEST;

--(MDGUEST) SELECT, UPDATE �۾� ����
--MADANG.CUSTOMER ���̺� SELECT, UPDATE ���� ���� ��
SELECT * FROM MADANG.CUSTOMER; --��ȸ����
UPDATE MADANG.CUSTOMER 
   SET PHONE = '010-1111-2222'
 WHERE NAME = '�ڼ���'
;
------------------------
--���� ȸ��(���) - REVOKE
--MADANG ������ ������ �ִ� BOOK ���̺� ���� SELECT���� ȸ��
REVOKE SELECT ON MADANG.BOOK FROM MDGUEST;

REVOKE SELECT, UPDATE ON MADANG.CUSTOMER FROM MDGUEST;











