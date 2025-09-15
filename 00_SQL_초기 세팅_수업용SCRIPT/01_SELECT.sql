/*
SELECT (조회)
지정된 테이블에서 원하는 데이터를 선택하여 조회하는 SQL

1. 작성법
	: 지정 테이블의 일치하는 컬럼명의 값을 조회한다.
SELECT 컬럼명, 컬럼명 ...
FROM   테이블명;

2. 작성법
	: 테이블 내 모든 컬럼의 값을 조회한다.
SELECT *
FROM   테이블명;
*/

-- EMPLOYEE 테이블에서 사번, 이름, 이메일 조회하기.
SELECT emp_id, full_name, email
FROM employees;

SELECT emp_id, full_name, email FROM employees;

/*
SQL은 예약어를 기준으로 세로로 작성하는 경우가 많으며,
마침표를 사용하여 예약어 작성을 종료한다는 것을 표기한다.
*/

-- EMPLOYEE 테이블에서 이름 (full_name), 입사일 (hire_date)만 조회하기.
SELECT full_name, hire_date
FROM employees;

SELECT * FROM employees;


-- Departments 테이블의 모든 데이터 조회하기.
SELECT *
FROM Departments;
-- Departments 테이블에서 부서코드(dept_code), 부서명(dept_name) 조회하기.
SELECT dept_code, dept_name
FROM Departments;
-- employees 테이블에서 사번 (emp_id), 이름(full_name), 급여(salary) 조회하기.
SELECT emp_id, full_name, salary
FROM employees;
-- Training_programs 테이블에서 모든 데이터 조회하기.
select *
from training_programs;
-- Training_programs 테이블에서 프로그램명(program_name), 교육시간(duration_hours) 조회하기.
select program_name, duration_hours
from training_programs;


/****************************

컬럼 값 산술 연산자

컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

SELECT문 작성 시
컬럼명에 산술 연산을 직접 작성하면
조회 결과 (RESULT SET)에 연산 결과가 반영되어 조회된다.

****************************/

-- 1. Employees 테이블에서 모든 사원의 이름, 급여, 급여 +500만원을 설정할 때 인상 결과 조회하기.
select full_name, salary, salary + 5000000
from employees;

-- 2. Employees 테이블에서 모든 사원의 사번, 이름, 연봉 (급여*12) 조회하기.
select full_name, salary, salary*12
from employees;

-- 3. Training_programs 테이블에서 프로그램명, 교육시간, 하루 8시간 기준 교육일수 조회하기.
select program_name, duration_hours, duration_hours/8
from training_programs;


-- employees 테이블에서 이름, 급여, 세후급여 (80%) 조회하기.
select full_name, salary, salary*0.8
from employees;
-- positions 테이블 전체 조회하기.
select *
from positions;
-- positions 테이블에서 직급, 최소 급여, 최대 급여, 급여 차이 조회하기.
select position_name, min_salary, max_salary, max_salary - min_salary
from positions;
-- departments 테이블에서 부서, 예산, 예비 예산(+10%) 조회하기.
select dept_name, budget, budget*1.1
from departments;


-- 현재 날짜 확인하기.
-- (가상 테이블 필요 없음.)
/*
모든 SQL에는 DUAL 가상 테이블이 존재하기 때문에
MySQL에서는 FROM을 생략해도 자동으로 DUAL 가상 테이블을 사용한다.
*/
SELECT NOW(), current_timestamp();
SELECT NOW(), current_timestamp;
SELECT NOW(), current_timestamp
FROM dual;


CREATE DATABASE IF NOT EXISTS 네이버;
CREATE DATABASE IF NOT EXISTS 라인;
CREATE DATABASE IF NOT EXISTS 스노우;


USE 네이버;
USE 라인;
USE 스노우;


-- 날짜 데이터 연산하기 (+, - 만 가능)
-- > +1 == 1일 추가
-- > -1 == 1일 감소

-- 어제, 오늘, 내일, 모레 조회하기.
/*
SELECT NOW() - interval 1 day;
SELECT NOW() + interval 1 day;
*/
SELECT NOW() - interval 1 day, NOW() + interval 1 day;

SELECT NOW(),
		NOW() + interval 1 hour,
        NOW() + interval 1 minute,
        NOW() + interval 1 second;

SELECT '2025-09-15', STR_TO_DATE('2025-09-15', '%Y-%m-%d');

SELECT DATEDIFF('2025-09-14', '2025-09-15');    # -1
SELECT DATEDIFF('2025-09-15', '2025-09-14');	# 1

-- CURDATE() : 시간 정보를 제외한 년월일만 조회하는 함수
-- 근무일수 계산하기						  현재		 입사
SELECT full_name, hire_date, datediff(curdate(), hire_date)
FROM employees;


-- 컬럼 명칭 지정하기.
git init
git remote add origin https://github.com/svv0003/06_DB.git
git add .       
git commit -m "sql setting"
git push --set-upstream origin main



*/










