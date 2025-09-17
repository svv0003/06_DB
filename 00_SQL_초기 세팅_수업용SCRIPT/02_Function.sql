/****************************

함수		: 컬럼값 | 지정된 값을 읽어 연산한 결과를 변환하는 것.

단일행 함수	: N개의 행의 컬럼 값을 전달하여 N개의 결과를 반환한다.
그룹 함수		: N개의 행의 컬럼 값을 전달하여 1개의 결과를 반환한다.
			  (그룹의 수가 늘어나면 그룹의 수만큼 결과를 반환한다.)

함수는 SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절에서 사용 가능하다.

****************************/

-- 단일행 함수
-- 문자열 관련 함수

-- LENGTH (문자열|컬럼명)	: 문자열 길이를 반환한다.
SELECT 'HELLO WORLD', length('HELLO WORLD');

-- employees 테이블에서 이메일 길이가 12 이하인 사원을 길이 오름차순으로 정렬하기.
SELECT full_name, email, length(email) '이메일 총 길이'
FROM employees
WHERE length(email) > 12
ORDER BY '이메일 총 길이' asc; 


-- LOCATE (검색할문자열, 문자열)
-- LOCATE (검색할문자열, 문자열, 시작위치)
-- 검색할 문자열 위치를 반환하며, 1부터 시작하고, 없다면 0 출력한다.
-- Oracle에서는 INSTR() 함수.

-- 5번째부터 검색하기.
SELECT 'AABBBCCCCBBBAA', locate('B', 'AABBBCCCCBBBAA', 5);

-- 1번째부터 검색하기.
SELECT 'AABBBCCCCBBBAA', locate('B', 'AABBBCCCCBBBAA');

-- employees 테이블에서 email의 '@' 위치 조회하기.
SELECT email, locate('@', email)
FROM employees;


-- SUBSTRING (문자열, 시작위치)
-- SUBSTRING (문자열, 시작위치, 길이)
-- 문자열을 시작위치부터 지정된 길이만큼 반환한다.
-- Oracle에서는 SUBSTR() 함수.

-- 시작위치, 자를 길이 지정 O
SELECT substring("ABCDE", 2, 3);
-- 시작위치, 자를 길이 지정 X
SELECT substring("ABCDE", 2);

-- employees 테이블에서 사원명, 이메일 (@ 앞까지만)을 이메일 오름차순으로 조회하기.
SELECT full_name '이름',
substring(email, 1, locate('@', email)-1) '아이디',
substring(email, 1, locate('@', email)) '아이디@',
substring(email, locate('@', email)+1) '도메인',
substring(email, locate('@', email)) '@도메인'
FROM employees
ORDER BY '아이디';


-- REPLACE (문자열, 검색문자열, 대체문자열)
-- 문자열에서 지정한 문자열을 변경할 문자열로 대체하여 반환한다.
SELECT replace("ABCDE", "AB", "12");

-- departments 테이블에서 '부'를 '팀'으로 변경하기.
SELECT dept_name '기존 부서명', replace(dept_name, '부', '팀') '새로운 부서명'
FROM departments;



-- 숫자 관련 함수
-- MOD (숫자|컬럼명, 나눌 값)		: 나머지를 반환한다.
SELECT mod(105, 100);
-- ABS (숫자|컬럼명)				: 절대값을 반환한다.
SELECT abs(-10), abs(10);
-- CEIL (숫자|컬럼명)				: 올림 결과를 반환한다.
-- FLOOR (숫자|컬럼명)				: 내림 결과를 반환한다.
SELECT ceil(1.1), floor(1.1);
-- ROUND (숫자|컬럼명, 소수점위치)	: 반올림 결과를 반환한다.
-- ROUND (숫자|컬럼명)				: 소수점 첫째 자리 반올림 결과를 반환한다.
-- 								  양수는 지정 위치의 소수점 자리까지 표현하고,
-- 								  음수는 지정 위치의 정수 자리까지 표현한다.
SELECT        123.456,
		ROUND(123.456),		# 123
		ROUND(123.456, 0),	# 123
		ROUND(123.456, 1),	# 123.5
		ROUND(123.456, 2),	# 123.46
		ROUND(123.456, -1),	# 120
		ROUND(123.456, -2);	# 100



/****************************

N개의 행의 컬럼 값을 전달하여 1개의 결과를 반환한다.
그룹의 수가 늘어나면 그룹의 수만큼 결과를 반환한다.

SUM (숫자 컬럼명)		: 그룹 합계를 반환한다.
AVG (숫자 컬럼명)		: 그룹의 평균을 반환한다.
MAX (컬럼명)			: 최대값을 반환한다.
MIN (컬럼명)			: 최소값을 반환한다.
					
		날짜, 시간 비교	: 과거 < 미래
        문자열 비교	: 유니코드 순서 (A < Z)

COUNT (*)				: 조회된 모든 행의 개수를 반환한다.
COUNT (DISTINCT *)		: 조회된 모든 행에서 중복된 행을 제외한 행의 개수를 반환한다.
COUNT (컬럼명)			: 지정된 컬럼 값이 NULL이 아닌 행의 개수를 반환한다.
COUNT (DISTINCT 컬럼명)	: 지정된 컬럼 값이 NULL이 아니면서 중복된 행을 제외한 행의 개수를 반환한다.

****************************/

-- 모든 사원의 급여 합계 구하기.
SELECT sum(salary)
FROM employees;

-- 모든 활성 사원의 급여 합계 구하기.
SELECT sum(salary), employment_status
FROM employees
WHERE employment_status = 'Active';

-- 2020년 이후 입사자들의 급여 합계 조회하기.
SELECT sum(salary)
FROM employees
WHERE YEAR(hire_date) >= 2020;

-- 모든 사원의 평균 급여 구하기.
SELECT AVG(salary)
FROM employees;

-- 모든 활성 사원의 평균 급여 구하기.
-- 소수점 내림 처리하기.
SELECT FLOOR(AVG(salary))
FROM employees
WHERE employment_status = 'Active';

-- AS '급여 합계', AS '평균 급여'을 이용해서 모두 조회하기.
SELECT sum(salary) '급여 합계', avg(salary) '평균 급여'
FROM employees;

-- 모든 사원 중 최초 입사일, 최근 입사일,
-- 이름 오름차순에서 제일 먼저 작성되는 이름과 마지막 이름을 구하기.
SELECT MIN(hire_date) '최초 입사일',
		MAX(hire_date) '최근 입사일',
        MIN(full_name) '가나다 순 첫번째',
        MAX(full_name) '가나다 순 마지막'
FROM employees
WHERE employment_status = 'Active';


-- employees 테이블에서 전체 활성 사원 수를 구하기.
SELECT count(*)
FROM employees
WHERE employment_status = 'Active';

-- employees 테이블에서 부서 코드가 DEV인 사원의 수를 구하기.
SELECT count(*)
FROM employees E
JOIN departments D
ON E.dept_id = D.dept_id
WHERE dept_code = 'dev';

-- employees 테이블에서 전화번호가 존재하는 사원의 수를 구하기.
SELECT count(*)
FROM employees
WHERE phone IS NOT NULL;

-- employees 테이블에서 NULL이 아닌 전화번호 존재하는 사원의 수를 구하기.
SELECT count(phone)
FROM employees;

-- employees 테이블에서 존재하는 부서코드 (dept_code)를 중복없이 구하기.
SELECT count(distinct D.dept_code)
FROM employees E
JOIN departments D
ON E.dept_id = D.dept_id;

-- employees 테이블에서 존재하는 부서id와 부서code를 중복없이 구하기.
SELECT count(distinct E.dept_id), count(distinct D.dept_id)
FROM employees E, departments D;


-- employees 테이블에서 부서 코드가 DEV인 사원의 수를 구하기.
-- WHERE절 사용하기.
SELECT count(distinct d.dept_code)
FROM employees E, departments D
WHERE E.dept_id = D.dept_id;

-- employees 테이블에서 남자 사원 수를 구하기.
SELECT count(*)
FROM employees
WHERE gender = 'm';





