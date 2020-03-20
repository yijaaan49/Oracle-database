/* 
HTTP 포트 번호 변경 8080 -> 8090 
*/
--DB 설치후 HTTP 포트번호 확인 : 8080
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL; --8080

--HTTP 포트 번호 8090으로 변경
exec dbms_xdb.sethttpport(8090);

--변경 후 HTTP 포트번호 확인 : 8090
SELECT DBMS_XDB.GETHTTPPORT() FROM DUAL; --8090





