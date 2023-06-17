-- "--"가 주석!
-- 관리자 입니다.
-- 실행 : ctrl+enter
show user;

-- 관리자는 계정을 생성할 수 있다.
-- 계정을 생성해서 데이터베이스를 동시에 사용하게 할 수 있다.
-- 계정을 생성하는 방법은 명령어 사용
CREATE USER KHUSER01 IDENTIFIED BY KHUSER01;
-- 계정을 만들었다고 해서 바로 접속가능한 것이 아님
-- 명령어의 끝은 항상 세미콜론; 으로 구분

-- 계정 만들 때
--CREATE USER KHUSER01 IDENTIFIED BY KHUSER01;
--GRANT CONNECT, RESOURCE TO KHUSER01;

-- 접속 권한 부여 필요
GRANT CONNECT TO KHUSER01; -- 부여 완료 (Grant을(를) 성공했습니다.)

-- 접속 권한이 부여됐다고 해서 바로 테이블을 생성할 수 있는 것은 아님
-- 객체 생성 권한 부여 필요
GRANT RESOURCE TO KHUSER01; -- 부여 완료 (Grant을(를) 성공했습니다.)
-- GRANT 부여 후, 다시 접속 해제 > 접속을 해주어야 권한이 제대로 부여가 된다.

SELECT USERNAME FROM ALL_USERS;
SELECT USERNAME, ACCOUNT_STATUS, LOCK_DATE FROM DBA_USERS;