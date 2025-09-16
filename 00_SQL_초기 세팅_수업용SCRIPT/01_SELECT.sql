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


/****************************

컬럼명 별칭 지정하기.

1. 컬럼명 AS 별칭		문자 O, 띄어쓰기 X, 특수문자 X
2. 컬럼명 AS '별칭'	문자 O, 띄어쓰기 O, 특수문자 O
3. 컬럼명 별칭			문자 O, 띄어쓰기 X, 특수문자 X
4. 컬럼명 '별칭'		문자 O, 띄어쓰기 O, 특수문자 O

' ' 또는
" " 또는 ` ` 사용 가능하다.
대소문자 구분한다.

****************************/

-- 별칭 이용해서 근무일수 계산하기
SELECT full_name, hire_date, datediff(curdate(), hire_date) AS `근무일수`
FROM employees;

-- 1. employees 테이블에서 사번, 이름, 이메일 조회하기. (AS 별칭 벡틱 `` 사용 X)
SELECT emp_code as 사번, full_name as 이름, email as 이메일
FROM employees;
/*
ceil()	: 소수점 아래 지우는 기능
*/
-- 2. employees 테이블에서 이름, 급여, 연봉(급여*12) 조회하기. (AS 별칭 벡틱 ``사용 O)
SELECT full_name AS `이름`, ceil(salary) AS `급여`, ceil(salary*12) AS `연봉`
FROM employees;
-- 3. positions 테이블에서 직급, 최소급여, 최대급여, 급여 차이 명칭으로 조회하기. (AS 별칭 벡틱 ``사용 O)
SELECT position_name AS "직급", ceil(min_salary) AS "최소 급여", ceil(max_salary) AS "최대 급여", ceil(max_salary - min_salary) AS "급여 차이" 
FROM positions;


-- training_programs 테이블에서 프로그램명, 교육시간, 교육일수 (8h) 기준 조회하기.
SELECT program_name AS `교육프로그램`,
duration_hours AS "총 교육시간",
round(duration_hours/8) AS 교육일수
FROM training_programs;



/****************************

DISTINCT (별개의, 전혀 다른)

-> 중복 제거
-> 조회 결과 집합 (RESULT SET)에서
	지정된 컬럼의 값이 중복인 경우
	이를 한 번만 표시할 때 사용한다.

****************************/

-- 1. employees 테이블에서 모든 사원의 부서코드 조회하기.
SELECT *
FROM employees;

SELECT dept_id
FROM employees;
-- 2. employees 테이블에서 사원이 존재하는 부서코드만 조회하기.
SELECT *
FROM departments;


-- 조회한 결과가 존재하지 않는다.
-- 조회 결과 : 0이 나온 순간
-- 에러가 아니다!!!!
SELECT distinct manager_id
FROM EMPLOYEES;


-- EMPLOYEES 테이블에서 사원 있는 부서 id만 중복 제거 후 조회하기.
SELECT distinct dept_id
FROM EMPLOYEES;


-- EMPLOYEES 테이블에서 존재하는 position_id 코드의 종류를 중복 없이 조회하기.
SELECT distinct position_id
FROM EMPLOYEES;



/****************************

WHERE 절

테이블에서 조건을 충족하는 행을 조회할 때 사용한다.
WHERE 절에서는 조건식 (T/F)만 작성한다.

비교 연산자 : >, >=, <, <=, =(같다), != (같지 않다), <> (같지 않다)
논리 연산자 : AND, OR, NOT

SELECT	컬럼명, 컬럼명 ...
FROM	DB명칭
WHERE	조건식;

****************************/

-- employees 테이블에서 급여가 300만원 초과하는 사원의 사번, 이름, 급여, 부서코드 조회하기.
SELECT emp_id, full_name, salary, dept_id
FROM employees
WHERE salary > 3000000;
/*
FROM 절에 지정된 테이블에서
WHERE 절로 행을 먼저 필터링 과정으로 걸러내고,
SELECT 절에 지정된 컬럼만 조회한다.
*/

-- employees 테이블에서 연봉이 5천만원 이하인 사원의 사번, 이름, 연봉 조회하기.
SELECT emp_id as 사번, full_name AS 이름, salary*12 AS "연봉"
FROM employees
where salary*12 > 50000000;

SELECT *
FROM employees;

-- employees 테이블에서 부서 코드가 2번이 아닌 사원의 이름, 부서코드, 전화번호 조회하기.
SELECT full_name AS 이름, dept_id as 부서코드, phone "전화번호"
FROM employees
where emp_id != 2;


/****************************

연결 연산자 CONCAT()

****************************/

SELECT CONCAT(emp_id, full_name) as 사변이름연결
from employees;



/****************************

LIKE

****************************/

-- employees 테이블에서 '김'씨인 사원의 사번, 이름 조회하기.
SELECT emp_id, full_name
FROM employees
WHERE first_name LIKE '김%';

-- employees 테이블에서 이름에 '장'이 포함된 사원의 사번, 이름 조회하기.
SELECT emp_id, full_name
FROM employees
WHERE full_name LIKE '%장%';

-- employees 테이블에서 전화번호가 02으로 시작하는 사원의 이름과 전화번호 조회하기.
SELECT full_name, phone
FROM employees
WHERE phone LIKE '02%';

-- employees 테이블에서 email 아이디가 3글자인 사원의 이름, 이메일 조회하기.
SELECT full_name, email
FROM employees
WHERE email LIKE '___@%';

-- employees 테이블에서 사원코드가 EMP로 시작하고,
-- EMP 포함해서 총 6자리인 사원 조회하기.
SELECT full_name, emp_code
FROM employees
WHERE emp_code LIKE 'EMP___';



/****************************

WHERE절
AND OR BETWEEN IN()

****************************/

-- employees 테이블에서 급여가 4000만 이상, 7000만 이하인 사원의 사번, 이름, 급여 조회하기.
SELECT emp_id, full_name, salary
FROM employees
-- WHERE salary >= 40000000 AND salary <= 70000000;
WHERE salary BETWEEN 40000000 AND 70000000;

-- employees 테이블에서 급여가 4000만 미만, 8000만 초과인 사원의 사번, 이름, 급여 조회하기.
SELECT emp_id, full_name, salary
FROM employees
-- WHERE salary NOT BETWEEN 40000000 AND 80000000;
WHERE salary < 40000000 OR salary > 80000000;

-- employees 테이블에서 입사일이 '2020-01-01' ~ '2020-12-31' 사이인 사원의 이름, 입사일 조회하기.
SELECT emp_id, full_name, hire_date
FROM employees
WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';

-- employees 테이블에서 생년월일이 1980년대인 사원 조회하기.
SELECT emp_id, full_name, date_of_birth
FROM employees
WHERE date_of_birth BETWEEN '1980-01-01' AND '1989-12-31';

-- employees 테이블에서 부서 ID가 4인 사원 중 급여가 4000만 ~ 7000만 사이인 사원의 사번, 이름, 급여 조회하기.
SELECT emp_id, full_name, salary
FROM employees
WHERE dept_id = 4 AND (salary BETWEEN 40000000 AND 70000000);

-- employees 테이블에서 부서코드 2, 4, 5인 사원의 이름, 부서코드, 급여 조회하기.
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id = 2 OR dept_id = 4 OR dept_id = 5;

-- 컬럼 값이 ( ) 내 값과 일치하면 TRUE
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id IN (2, 4, 5);

-- 컬럼 값이 ( ) 내 값과 일치하지 않으면 TRUE
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id NOT IN (2, 4, 5);
-- > dept_id가 NULL인 사원들도 제외된 후 조회된다.

-- 컬럼 값이 ( ) 내 값과 일치하면 TRUE
-- NULL 값을 갖는 사람들을 추가하기.
SELECT full_name, dept_id, salary
FROM employees
WHERE dept_id IN (2, 4, 5) OR dept_id IS NULL;



/****************************

ORDER BY

SELECT문의 조회 결과 (Result Set)을 정렬시키는 구문.
SELECT문에서 가장 마지막에 해석된다.

[작성법]
[3번] SELECT   컬럼명
[1번] FROM     테이블명
[2번] WHERE    조건식
[4번] ORDER BY 컬럼명 | 별칭 | 컬럼 순서 [오름/내림 차순]

기본 정렬은 오름차순.
ASC  : 오름차순 (Ascending)
DESC : 내림차순 (Descending)

****************************/

-- employees 테이블에서 모든 사원의 이름, 급여를 조회하고, 급여 기준으로 정렬하기.
SELECT full_name, salary
FROM employees
ORDER BY salary;

SELECT full_name, salary
FROM employees
ORDER BY salary ASC;

SELECT full_name, salary
FROM employees
ORDER BY salary DESC;

-- employees 테이블에서 급여가 300만원 ~ 600만원인 사람의 사번, 이름, 급여를 이름 순으로 조회하기.
SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 100000000
ORDER BY full_name DESC;

SELECT emp_id, full_name, salary
FROM employees
WHERE salary BETWEEN 40000000 AND 100000000
ORDER BY 2 DESC;
-- 2번째 컬럼으로 조회한다. (= full_name)

-- employees 테이블에서 이름, 연봉을 연봉 내림차순으로 조회하기.
SELECT full_name 이름, salary*12 연봉
FROM employees
ORDER BY salary*12 DESC;

SELECT full_name 이름, salary*12 연봉
FROM employees
ORDER BY 연봉 DESC;



/****************************

NULL 값 정렬 처리

기본적으로 NULL 값은 가장 작은 값으로 처리된다.
ASC   : NULL -> 최상위 존재
DESC  : NULL -> 최하위 존재

****************************/

-- employees 테이블에서 모든 사원의 이름, 전화번호를 phone 기준으로 오름차순 조회하기.
SELECT *
FROM employees
ORDER BY phone;

-- emplyees 테이블에서 이름, 부서id, 급여를 급여 내림차순 정렬하기.
SELECT full_name, dept_id, salary
FROM employees
ORDER BY salary DESC;




