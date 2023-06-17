SHOW USER;

-- 테이블 생성 (정의)
-- * 생성을 위해서는 우선 관리자 계정에서 권한을 부여해줘야함 (GRANT)
CREATE TABLE STUDENT_TBL (
    STUDENT_NAME VARCHAR2(20),
    STUDENT_AGE NUMBER, 
    STUDENT_GRADE NUMBER,
    STUDENT_ADDR VARCHAR2(100)
);

SELECT * FROM STUDENT_TBL ORDER BY STUDENT_NAME;

-- 정의된 테이블에 데이터 추가
INSERT INTO STUDENT_TBL VALUES('사용자', 44, 4, '경기도 부천시');
COMMIT; -- : CTRL+S 와 동일하다. ** 최종 저장 **

-- 추가된 데이터 수정
-- UPDATE 테이블명 SET (수정하고 싶은 테이블 칼럼명 = 값) WHERE (수정하고 싶은 데이터 특정)
-- 사용자의 AGE 44 > 56
UPDATE STUDENT_TBL SET STUDENT_AGE = 56 WHERE STUDENT_NAME = '사용자';
-- UPDATE STUDENT_TBL SET STUDENT_AGE = 56; -- where 절 없으면 모든 행의 값을 변경한다

-- 삭제
DELETE FROM STUDENT_TBL WHERE STUDENT_NAME = '일용자';
-- DELETE FROM STUDENT_TBL; -- where 절이 없으면 전체를 다 날려버림! 

-- 임시 상태에서 원상복구 : 롤백 (원복. ROLLBACK)
ROLLBACK;

--------------------------------------------------------------------------------------
-- ************************************ DDL *******************************************
-- 데이터 정의어 (Data Definition Language)
-- 테이블 생성, 수정, 삭제함
-- CREATE TABLE~, ALTER TABLE~, DROP TABLE~

-- STUDENT_TBL 을 삭제하라
DROP TABLE STUDENT_TBL; -- 롤백 불가. 테이블 전체를 삭제

-- STUDENT_TBL 을 생성하라
CREATE TABLE STUDENT_TBL (
    STUDENT_NAME VARCHAR2(20),
    STUDENT_AGE NUMBER, 
    STUDENT_GRADE NUMBER, 
    STUDENT_ADDR VARCHAR2(100)
);

SELECT * FROM STUDENT_TBL;

INSERT INTO STUDENT_TBL VALUES('일용자', 11, 1, '서울시 중구');
INSERT INTO STUDENT_TBL VALUES('이용자', 22, 2, '서울시 동대문구');
COMMIT;

UPDATE STUDENT_TBL SET STUDENT_AGE = 33 WHERE STUDENT_NAME = '일용자';
COMMIT;

DELETE FROM STUDENT_TBL WHERE STUDENT_NAME = '이용자';

-- 칼럼에 대한 데이터타입과 크기를 확인
-- : 스키마 확인
DESC STUDENT_TBL;
----------------------------------------------------------------------------
-- 실습
CREATE TABLE LESSON_TBL (
    LESSON_NO NUMBER, 
    MEMBER_ID VARCHAR2(15), 
    APPLY_PRICE VARCHAR2(60),
    APPLY_PLAN VARCHAR2(60),
    APPLY_CONTENT VARCHAR2(600),
    APPLY_DATE TIMESTAMP(6) -- TIMESTAMP : 시간
);

SELECT * FROM LESSON_TBL;

-- 칼럼에 대한 데이터타입과 크기를 확인
-- : 스키마 확인
DESC LESSON_TBL;

-- 테이블 삭제
DROP TABLE LESSON_TBL;

-- COMMENT
COMMENT ON COLUMN LESSON_TBL.LESSON_NO IS '레슨글 번호';
COMMENT ON COLUMN LESSON_TBL.MEMBER_ID IS '신청인ID';
COMMENT ON COLUMN LESSON_TBL.APPLY_PRICE IS '신청가격';
COMMENT ON COLUMN LESSON_TBL.APPLY_PLAN IS '신청일정';
COMMENT ON COLUMN LESSON_TBL.APPLY_CONTENT IS '신청내용';
COMMENT ON COLUMN LESSON_TBL.APPLY_DATE IS '신청일';
