-- DCL (Data Control Language), Grant, Revoke
-- 권한 부여, 권한 생성
GRANT CONNECT, RESOURCE TO KHUSER01; -- 관리자 계정으로 해야함

-- 관리자 계정
-- 1. SYS : 슈퍼관리자. 데이터베이스 생성/ 삭제 권한 있음 (sys 권한이 더 높다)
-- 로그인 옵션으로 반드시 AS SYSDBA로 지정
-- DATA DICTIONARY 보유하고 있음

-- 2. SYSTEM : 일반관리자. 데이버테이스 생성/ 삭제 권한 없음
-- 롤에 대한 권한의 종류 확인
SELECT * FROM ROLE_SYS_PRIVS; -- 롤에 부여된 시스템 권한
SELECT * FROM ROLE_TAB_PRIVS; -- 롤에 부여된 테이블 권한
SELECT * FROM USER_ROLE_PRIVS;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'CONNECT';
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'RESOURCE';
SELECT * FROM USER_SYS_PRIVS;


-- ************************** KH 계정 생성
CREATE TABLE COFFEE (
    PRODUCT_NAME VARCHAR2(20) PRIMARY KEY,
    PRICE NUMBER NOT NULL,
    COMPANY VARCHAR2(20) NOT NULL
);

INSERT INTO COFFEE VALUES('메가커피', 3700, 'MGC');
INSERT INTO COFFEE VALUES('아바라', 5600, '스타벅스');
INSERT INTO COFFEE VALUES('아아', 4700, '커피빈');
INSERT INTO COFFEE VALUES('티오피', 3000, '맥심');
SELECT * FROM COFFEE;
COMMIT; -- COMMIT을 하지 않으면 GRANT 받은 KHUSER02가 SELECT를 하더라도 INSERT된 행을 볼 수 없다. COMMIT 꼭 해주기

-- *********** 시스템 세션으로 실행 *************

GRANT SELECT ON KHUSER01.COFFEE TO KHUSER02;
GRANT INSERT ON KHUSER01.COFFEE TO KHUSER02;
-- GRANT를 성공했습니다. 권한 부여

-- *********** KHUSER02 세션으로 실행 *************

SELECT * FROM KHUSER01.COFFEE;
INSERT INTO KHUSER01.COFFEE VALUES('카누커피', 1500, '카누');
INSERT INTO KHUSER01.COFFEE VALUES('메머드커피', 1500, '메머드'); 
COMMIT; -- COMMIT을 해줘야 다른 곳에서도 수정된 내용을 볼 수 있음

-- *********** 시스템 세션으로 실행 *************

REVOKE SELECT ON KHUSER01.COFFEE FROM KHUSER02;
REVOKE INSERT ON KHUSER01.COFFEE FROM KHUSER02;
-- REVOKE를 성공했습니다. 권한 회수
