-- 오라클 함수
-- 단일행 함수 : 각 행마다 반복적으로 적용되어 입력 받은 행의 개수만큼 결과를 반환
-- 그룹함수 :
-- 1. 문자 처리 함수
-- LENGTH, LENGTHB, INSTR(@의 위치 알려줌), SUBSTR(문자 자름), 
-- LPAD, RPAD(길이 정하고 나머지 채워줌), LTRIM, RTRIM, TRIM(공백제거)

-- ************* 문자 처리 함수 실습문제 ***************

-- 사원명에서 성만 중복없이 사전순으로 출력하세요.
SELECT DISTINCT SUBSTR(EMP_NAME, 1, 1) "사원 성" FROM EMPLOYEE ORDER BY 1 ASC;
-- SUBSTR(STRING, POSITION, [LENGTH]) : 컬럼이나 문자열에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 리턴하는 함수
-- DISTINCT : 중복 처리 함수. 컬럼에 포함된 중복 값을 한번씩만 표시 

-- employee 테이블에서 남자만 사원번호, 사원명, 주민번호, 연봉을 나타내세요.
-- 주민번호의 뒷6자리는 *처리하세요.
SELECT EMP_ID "사원번호", EMP_NAME "사원명", RPAD(SUBSTR(EMP_NO,1,8), 14, '*') "주민번호", (SALARY*12) "연봉" FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) IN (1, 3);
-- RPAD(SUBSTR(EMP_NO,1,8), 14, '*') > SUBSTR(EMP_NO, 1, 8) || '******' 이렇게 써도 됨! 방법은 많다. 

-- * DUAL : 한 열로 이루어진 특별한 가상 테이블. SYSDATE, USER, 산술연산과 같은 의사컬럼 선텍에 사용하도록 해준다.
--        결과값 조회할 때 많이 사용한다.
SELECT * FROM DUAL; -- VARCHAR2(1)로 'X'값이 존재한다.
SELECT RTRIM(LTRIM('  KH  ')) FROM DUAL;
SELECT TRIM('  KH  ') FROM DUAL;
SELECT LTRIM('123KB', '123') FROM DUAL; -- 왼쪽부터 삭제
SELECT RTRIM(LTRIM('123KB123', '123'), '123') FROM DUAL; -- 왼쪽 > 오른쪽
SELECT TRIM('Z' FROM 'ZZZZXXXXZZZ') FROM DUAL; -- TRIM은 양옆을 지울 수 있지만, 문자 하나에 대해서만 지울 수 있다.

-- 다음문자열에서 앞뒤 모든 숫자를 제거하세요.
-- '982341678934509hello89798739273402'
-- SELECT RTRIM(LTRIM('982341678934509hello89798739273402', '982341678934509'), '89798739273402') FROM DUAL;
SELECT RTRIM(LTRIM('982341678934509hello89798739273402', '0123456789'), '0123456789') FROM DUAL;

-- REPLACE
-- '서울시 강남구 역삼동' -> '삼성동'
SELECT REPLACE ('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;

-- EMPLOYEE 에서 EMAIL칼럼의 주소를 gmail.com으로 바꿔주세요.
SELECT REPLACE (EMAIL, SUBSTR(EMAIL, -8), 'gmail.com') FROM EMPLOYEE;


-- ************* 숫자 처리 함수 ***************

-- 2. 숫자 처리 함수
SELECT (SYSDATE-HIRE_DATE), FLOOR(SYSDATE-HIRE_DATE), CEIL(SYSDATE-HIRE_DATE), ROUND(SYSDATE-HIRE_DATE), TRUNC((SYSDATE-HIRE_DATE), 2)
FROM EMPLOYEE;
-- FLOOR : 버림
-- CEIL : 올림
-- ROUND : 반올림
-- TRUNC : 버림. 단, 소숫점 몇번째까지 를 지정해줄 수 있음 (지정하지 않으면 전체 버림)


-- ************* 날짜 처리 함수 ***************

-- 3. 날짜 처리 함수

--@실습문제
-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 3개월이 된 날짜를 조회하시오
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 3) FROM EMPLOYEE;

--@실습문제
--EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무 개월수를 조회하시오
--SELECT EMP_NAME, HIRE_DATE, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE), 1) FROM EMPLOYEE;
SELECT EMP_NAME, HIRE_DATE, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) FROM EMPLOYEE;

--@실습문제
--ex) EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사월의 마지막날을 조회하세요
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE) FROM EMPLOYEE;
-- LAST_DAY() : 마지막날
-- LAST_DAY() + 1 : 다음월 첫날

--@실습문제
--ex) EMPLOYEE 테이블에서 사원 이름, 입사 년도, 입사 월, 입사 일을 조회하시오.
--SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE) FROM EMPLOYEE;
SELECT EMP_NAME, 
EXTRACT(YEAR FROM HIRE_DATE)|| '년' || 
EXTRACT(MONTH FROM HIRE_DATE)|| '월' || 
EXTRACT(DAY FROM HIRE_DATE)|| '일'
FROM EMPLOYEE;

--@실습문제
/*
     오늘부로 일용자씨가 군대에 끌려갑니다.
     군복무 기간이 1년 6개월을 한다라고 가정하면
     첫번째,제대일자를 구하시고,
     두번째,제대일자까지 먹어야할 짬밥의 그룻수를 구합니다.
     (단, 1일 3끼를 먹는다고 한다.)
*/
SELECT ADD_MONTHS(SYSDATE, 18) "제대일자", ((ADD_MONTHS(SYSDATE, 18)-SYSDATE) * 3) "짭밥수" FROM DUAL;

-- **************** 형변환 함수 *************
-- 4. TO_CHAR, TO_DATE, TO_NUMBER

SELECT * FROM EMPLOYEE WHERE HIRE_DATE BETWEEN '10/01/01' AND '12/12/31';
SELECT * FROM EMPLOYEE WHERE HIRE_DATE BETWEEN TO_DATE('10/01/01') AND TO_DATE('12/12/31'); -- 자동 형변환

SELECT TO_DATE('20100101', 'YY/MM/DD') "TO_DATE" FROM DUAL;
-- 20100101을 YY/MM/DD의 형식으로 바꿔라

SELECT TO_NUMBER('1,000,000', '9,999,999') "TO_NUMBER" FROM DUAL;

SELECT '1,000,000' - '500,000' FROM DUAL; -- 작동 x
SELECT TO_NUMBER('1,000,000', '9,999,999') - TO_NUMBER('500,000', '999,999') "계산" FROM DUAL;


-- ************* 기타 함수 *********
-- 1. NVL (널 처리 함수)
SELECT BONUS*SALARY FROM EMPLOYEE;
SELECT NVL(BONUS, 0)*SALARY FROM EMPLOYEE;

--SELECT DEPT_CODE FROM EMPLOYEE;
--SELECT NVL(DEPT_CODE, 'D0') FROM EMPLOYEE;
SELECT DEPT_CODE FROM EMPLOYEE ORDER BY DEPT_CODE DESC;
SELECT NVL(DEPT_CODE, 'D0') FROM EMPLOYEE ORDER BY DEPT_CODE DESC; 

-- 2. DECODE (IF문)
-- DECODE(지정 항목, IF, 참, ELSE IF, 참, ,,, ELSE.)
-- 마지막에 짝이 안맞는 하나는 ELSE로, 해당하지 않는 모든 값을 치환한다.
-- 성별 표시하기
SELECT EMP_NAME, EMP_NO, SALARY, DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여', '기타') "성별" FROM EMPLOYEE;

-- 3. CASE (SWITCH문)
SELECT EMP_NAME, EMP_NO, SALARY, 
DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여', '3', '남', '4', '여', '기타') "성별(DECODE)",
CASE 
    WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남'
    WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여'
    WHEN SUBSTR(EMP_NO, 8, 1) = '3' THEN '남'
    WHEN SUBSTR(EMP_NO, 8, 1) = '4' THEN '여'
    ELSE '무'
END "성별(CASE)"
FROM EMPLOYEE;

COMMIT;