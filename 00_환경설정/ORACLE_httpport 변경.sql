/* 
HTTP ��Ʈ ��ȣ ���� 8080 -> 8090 
*/
--DB ��ġ�� HTTP ��Ʈ��ȣ Ȯ�� : 8080
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL; --8080

--HTTP ��Ʈ ��ȣ 8090���� ����
exec dbms_xdb.sethttpport(8090);

--���� �� HTTP ��Ʈ��ȣ Ȯ�� : 8090
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL; --8090





