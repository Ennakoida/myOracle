-- @함수 최종실습문제
--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex)  홍길동 , hong@kh.or.kr   	  13

SELECT EMP_NAME, EMAIL, LENGTH(EMAIL) FROM EMPLOYEE;


--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh

SELECT EMP_NAME, SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) "아이디" FROM EMPLOYEE;


--3. 60년대에 태어난 직원명과 년생, 보너스 값을 출력하시오. 그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	    1962	    0.3
--	ex) 송은희	    1963  	    0

SELECT EMP_NAME "직원명", ('19' || SUBSTR(EMP_NO, 1, 2)) "년생", NVL(BONUS, 0) "보너스 값" FROM EMPLOYEE WHERE EMP_NO LIKE '6%';
-- WHERE SUBSTR(EMP_NO, 1, 2) BETWEEN 60 AND 69;


--4. '010' 핸드폰 번호를 쓰지 않는 사람의 전체 정보를 출력하시오.

SELECT * FROM EMPLOYEE WHERE PHONE NOT LIKE '010%';


--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년 12월
--	ex) 전지연		1997년 3월

SELECT EMP_NAME "직원명", (EXTRACT(YEAR FROM HIRE_DATE) || '년 ' || EXTRACT(MONTH FROM HIRE_DATE) || '월') "입사년월"  FROM EMPLOYEE;


--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서 출력 하시오
--	ex) 홍길동 771120-1******

SELECT EMP_NAME "직원명", RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*') "주민번호" FROM EMPLOYEE;


--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임

-- SELECT EMP_NAME "직원명", EMP_ID "직급코드", '￦' || TO_NUMBER((SALARY*12 + (SALARY*BONUS)), '99,999,999') "연봉(원)" FROM EMPLOYEE;
-- SELECT EMP_NAME "직원명", EMP_ID "직급코드", '￦' ||(SALARY*12 + (SALARY*NVL(BONUS, 1))) "연봉(원)" FROM EMPLOYEE;
SELECT EMP_NAME "직원명", EMP_ID "직급코드", TO_CHAR((SALARY*12 + (SALARY*NVL(BONUS, 1))), 'L99,999,999') "연봉(원)" FROM EMPLOYEE;
-- 000,000,000 으로도 표현할 수 있다. 단, 9로 표현하면 없는 자리는 표현하지 않지만 0은 없는 자리도 표현함
-- L : 해당 지역 통화 단위
/* ************* TO_CHAR 형식 문자 (숫자) *****************
Format		 예시			설명
,(comma)    	9,999		콤마 형식으로 변환
.(period)	    99.99		소수점 형식으로 변환
9           99999       해당자리의 숫자를 의미함. 값이 없을 경우 소수점이상은 공백, 소수점이하는 0으로 표시.
0		    09999		해당자리의 숫자를 의미함. 값이 없을 경우 0으로 표시. 숫자의 길이를 고정적으로 표시할 경우.
$		    $9999		$ 통화로 표시
L		    L9999		Local 통화로 표시(한국의 경우 \)
XXXX		XXXX		16진수로 표시
FM         FM1234.56    포맷9로부터 치환된 공백(앞) 및 소수점이하0을 제거
*/


--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회함.
--   사번 사원명 부서코드 입사일

SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D9') AND EXTRACT(YEAR FROM HIRE_DATE) = 2004;


--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림

SELECT EMP_NAME, HIRE_DATE, TRUNC(SYSDATE-HIRE_DATE),
-- 입사일에 개월차를 더한 날짜
ADD_MONTHS(HIRE_DATE, MONTHS_BETWEEN(SYSDATE, HIRE_DATE))
FROM EMPLOYEE;


--10. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
--	* 주민번호가 이상한 사람들은 제외시키고 진행 하도록(200,201,214 번 제외)
--	* HINT : NOT IN 사용

SELECT EMP_NAME "직원명", DEPT_CODE "부서코드",
--EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) || EXTRACT(MONTH FROM TO_DATE(SUBSTR(EMP_NO, 3, 2), 'MM')) || EXTRACT(DAY FROM TO_DATE(SUBSTR(EMP_NO, 5, 2), 'DD')) "생년월일",
-- 1900+TO_NUMBER(SUBSTR(EMP_NO, 1, 2))
'19' || SUBSTR(EMP_NO, 1, 2) || '년 ' || SUBSTR(EMP_NO, 3, 2) || '월 ' || SUBSTR(EMP_NO, 5, 2) || '일' "생년월일", 

--EXTRACT(YEAR FROM SYSDATE) - ('19' || SUBSTR(EMP_NO, 1, 2)) "나이(만)" 
-- EXTRACT(YEAR FROM SYSDATE) - (EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YY/MM/DD')) - 100) "나이(만)" 
-- ADD_YEARS(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YY/MM/DD'), YEARS_BETWEEN(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'YY/MM/DD'), SYSDATE)) "나이(만)" 
-- EXTRACT(YEAR FROM SYSDATE) - 1900 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2)))
EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO, 1, 2), 'RR')) "나이(만)"
FROM EMPLOYEE;

-- TO_DATE 의 YY : 2000년대...
-- RR : 50 이상 : 1900년대, 50미만 : 2000년대

-- EXTRACT(YEAR FROM SYSDATE) - 1900 + TO_NUMBER(SUBSTR(EMP_NO, 1, 2))) <<<< DECODE로 표현
-- EXTRACT(YEAR FROM SYSDATE) - ((DECODE(SUBSTR(EXP)NO, 8, 1), '1', 1900, '2'', 1900, '3', 2000, '4', 2000) + TO_NUMBER(SUBSTR(EMP_NO, 1, 2)))

/*
============================
형식	        의미
============================
YYYY	    년도표현(4자리)
YY	        년도 표현 (2자리)
RR          년도 표현 (2자리), 50이상 1900, 50 미만 2000
MONTH       월을 LOCALE설정에 맞게 출력(FULL)
MM	        월을숫자로표현  
MON	        월을 알파벳으로 표현(월요일아님)
DDD         365일 표현
DD	        날짜 표현	
D           요일을 숫자로 표현(1:일요일...) 
DAY	        요일 표현	  
DY	        요일을 약어로 표현	

HH HH12     시각
HH          시각(24시간)
MI
SS

AM PM A.M. P.M. 오전오후표기

FM          월, 일, 시,분, 초앞의 0을 제거함.
*/


--11. 사원명과, 부서명을 출력하세요.
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.

SELECT EMP_NAME "사원명", 
CASE 
    WHEN DEPT_CODE = 'D5' THEN '총무부'
    WHEN DEPT_CODE = 'D6' THEN '기획부'
    WHEN DEPT_CODE = 'D9' THEN '영업부'
END "부서명" 
FROM EMPLOYEE WHERE DEPT_CODE IN ('D5', 'D6', 'D9') ORDER BY DEPT_CODE ASC;

COMMIT;