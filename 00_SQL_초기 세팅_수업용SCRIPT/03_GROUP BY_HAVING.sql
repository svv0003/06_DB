/****************************

SELECT문 해석 순서

5	SELECT		컬럼명
1	FROM		테이블명
2	WHERE		조건식
3	GROUP BY	그룹화 컬럼명
4	HAVING		그룹함수식 비교연산자 비교값
6	ORDER BY	컬럼명 ASC|DESC


GROUP BY
SELECT 절에 명시한 컬럼 중에서 그룹함수가 적용되지 않은 컬럼은
모두 다 GROUP BY 절에 작성되어야 한다.

****************************/

-- employees 테이블에서 부서별 보너스를 받는 사원 수를 조회하기.
SELECT dept_id, concat(count(*), ' 명')
FROM employees
GROUP BY dept_id;

-- employees 테이블에서 연봉 9천만원 이상인 사원 수를 부서별로 조회하기.
SELECT dept_id, concat(count(*), ' 명')
FROM employees
WHERE salary >= 90000000
GROUP BY dept_id;

-- 부서id, 부서별 급여 합계, 평균 급여, 인원수를 부서id 오름차순으로 정렬하기.
SELECT dept_id '부서 ID',
concat(floor(sum(salary)) , '원') '급여 합계',
concat(floor(avg(salary)), '원') '평균 급여',
concat(count(*), ' 명') '인원 수'
FROM employees
GROUP BY dept_id
ORDER BY dept_id;

SELECT dept_id '부서 ID',
concat(floor(sum(salary)) , '원') '급여 합계',
concat(floor(avg(salary)), '원') '평균 급여',
concat(count(*), ' 명') '인원 수'
FROM employees
GROUP BY `부서 ID`
ORDER BY `부서 ID`;
# GROUP BY 절에 홀따옴표와 쌍따옴표를 사용해서 별칭 작성하면 문자열로 인식해서 오류 발생한다.
# SELECT 절 이외에는 백틱 사용하도록 습관화하자.

-- 부서id가 4,5인 부서의 평균 급여를 조회하기.
SELECT dept_id '부서 ID',
concat(floor(avg(salary)), '원')'평균 급여',
concat(count(*), ' 명') '인원 수'
FROM employees
WHERE dept_id IN (4, 5)
GROUP BY dept_id
ORDER BY dept_id;

-- 직급별 2020년도 이후 입사자들의 급여 합계 조회하기.
SELECT position_id '직급',
concat(floor(sum(salary)) , '원') '급여 합계'
FROM employees
WHERE YEAR(hire_date) >= '2020'
GROUP BY position_id;





-- 부서별로 직급이 같은 사원의 급여 합계를 조회하고, 부서id 오름차순으로 정렬하기.
SELECT position_id, sum(salary) as '급여 합계'
FROM employees
GROUP BY position_id, dept_id
ORDER BY dept_id;

-- 부서별로 직급이 같은 직원의 수를 조회하고 부서ID, 직급ID 오름차순으로 정렬하기.
SELECT dept_id, position_id, count(*)
FROM employees
GROUP BY dept_id, position_id
ORDER BY dept_id, position_id;
/*
함수가 아닌 컬럼은 왠만하면 GROUP BY 내에 작성하기.

GROUP BY dept_id, position_id
- dept_id와 position_id의 조합을 기준으로 데이터를 묶는다.

ex)
	부서 10	직위 1
	부서 10	직위 2
    부서 20	직위 1
    ...
    
각 조합마다 count(*)로 몇 명의 직원이 존재하는지 계산하겠다.
ORDER BY dept_id, position_id 계산 결과를
부서ID -> 직급ID 순서로 오름차순 정렬시킨다.
부서로 정렬된 뒤, 그 안에서 직급별로 졍렬된다.
*/


-- 부서별 평균 급여를 조회하고, 부서id 오름차순으로 정렬하기.
SELECT dept_id '부서', concat(floor(avg(salary)), '원') as '평균 급여'
FROM employees
GROUP BY `부서`
ORDER BY `부서`;






/****************************

WHERE		: 지정된 테이블에서 조건을 만족하는 행만을 결과로 조회하도록 조건을 지정하는 구문
			  (태이블 내의 특정 행만 조회하겠다)
              
HAVING		: 그룹 함수로 구해오려는 그룹에 대한 조건을 지정하는 구문
			  그룹에 대한 조건 -> 어떤 그룹만 조회하겠다

HAVING 컬럼명 | 함수식 비교연산자 비교값

****************************/

USE employee_management;
SELECT * FROM departments;


-- 부서에서 예산 (budget)이 30000000 이상인 부서만 조회하여 부서코드 오름차순으로 정렬하기.
SELECT dept_code, budget
FROM departments
-- WHERE budget > 30000000
GROUP BY dept_code
HAVING avg(budget) >= 30000000
ORDER BY dept_id;

-- 직원이 2명 이상인 부서 조회하기.
SELECT * FROM employees;
SELECT dept_id 부서, count(*) 인원수
FROM employees
	-- 그룹 함수를 잘못 사용했을 때 나타나는 문제
	-- WHERE count(*) >= 2;		# Error Code: 1111. Invalid use of group function
-- dept_id 그룹에서 총 인원이 2명인 부서 아이디만 조회된다.
GROUP BY dept_id
HAVING count(*)>=2;


/*
WHERE : 개별 급여가 5천만원 이상인 직원 찾기.
WHERE salary >= 50000000

HAVING : 그룹의 평균 급여가 5천만원 이상인 부서 찾기.
HAVING avg(salary) >= 50000000

GROUP BY + HAVING : 집계 함수 (SUM, AVG, MAX, MIN, COUNT 등)
					특정 그룹의 숫자 데이터를 활용하여 조건별 조회할 때 사용한다.
*/

-- 평균 급여가 7천만원 이상인 부서 조회하기.
SELECT dept_id '부서ID', concat(floor(avg(salary)), '원') '평균 급여'
FROM employees
GROUP BY dept_id
HAVING avg(salary) >= 70000000;


-- 급여 합계가 1억 5천만원 이상인 부서 조회하기.
SELECT dept_id '부서ID', concat(floor(sum(salary)), '원') '급여 합계'
FROM employees
GROUP BY dept_id
HAVING sum(salary) >= 150000000;


-- 평균 급여가 8천만원 이상인 부서의 이름 조회하기.
SELECT d.dept_name 부서명 , concat(floor(avg(E.salary)), '원') '평균 급여'
-- FROM employees E
-- JOIN departments D
-- ON E.dept_id = D.dept_id
FROM employees E, departments D
WHERE E.dept_id = D.dept_id
GROUP BY D.dept_name
HAVING avg(E.salary) >= 80000000;




/****************************

수업용 Script 2

stores
가게번호	가게명	카테고리		평점		배달비
id		name	category	rating	delivery_fee

menus
메뉴번호	가게번호		메뉴		설명				가격		주문량
id		store_id	name	description		price	is_popular

****************************/
USE delivery_app;
SELECT * FROM stores;
SELECT * FROM menus;

-- 각 카테고리별 가게가 몇 개씩 존재하는지 확인하기.
SELECT category 카테고리, count(*) 가게수
FROM stores
GROUP BY category
ORDER BY 가게수 desc;

-- 각 카테고리별 평균 배달비 구하기.
SELECT category, AVG(delivery_fee)
FROM stores
# 집계 함수는 NULL을 무시하지만 NULL을 제외하는 조건식을 작성해도 가능하다.
# WHERE delivery_fee IS NOT NULL
GROUP BY category;



-- 평점 4.5 이상인 가게만 골라서 카테고리별 개수 구하기.
SELECT category 카테고리, count(*)
FROM stores
WHERE rating >= 4.5
GROUP BY category;

SELECT category, count(*)
FROM stores
GROUP BY category
HAVING avg(rating) >= 4.5;

-- 배달비가 NULL이 아닌 가게들만 카테고리별 평균 평점 구하기.
SELECT category 카테고리, round(avg(rating), 2) '평균 평점'
FROM stores
WHERE delivery_fee IS NOT NULL
GROUP BY category;

-- 가게가 3개 이산인 카테고리만 개수 기준 내림차순으로 정렬하기.
SELECT category 카테고리, count(*) 가게수
FROM stores
GROUP BY category
HAVING count(*) >= 3
ORDER BY 가게수 desc;

-- 평균 배달비가 3천원 이상인 카테고리 구하기.
SELECT category 카테고리, floor(avg(delivery_fee)) '평균 배달비'
FROM stores
WHERE delivery_fee IS NOT NULL
GROUP BY category
HAVING `평균 배달비` >= 3000;

-- 가게별로 메뉴 개수 조회하기.
SELECT store_id '가게 번호', count(*) '메뉴 개수'
FROM menus
GROUP BY `가게 번호`;

-- 가게명, 카테고리 메뉴 개수 조회하기.
SELECT S.name 가게명, S.category 카테고리, count(*) '메뉴 개수'
FROM stores S
JOIN menus M
ON S.id = M.store_id
GROUP BY 가게명, 카테고리;

SELECT S.name 가게명, S.category 카테고리, count(*) '메뉴 개수'
FROM stores S
JOIN menus M
ON S.id = M.store_id
GROUP BY S.id;





SELECT count(*) '메뉴 개수'
FROM stores S, menus M
WHERE S.id = M.store_id;

SELECT S.name 가게명, S.category 카테고리, count(*) '메뉴 개수'
FROM stores S, menus M
WHERE S.id = M.store_id
GROUP BY S.id;

SELECT S.category 카테고리, count(*) '메뉴 개수'
FROM stores S, menus M
WHERE S.id = M.store_id
GROUP BY S.category;

SELECT S.name 가게명, S.category 카테고리, count(*) '메뉴 개수'
FROM stores S, menus M
WHERE S.id = M.store_id
GROUP BY S.name;





SELECT menus.id, menus.store_id, menus.name, menus.description, menus.price, menus.is_popular
FROM menus, stores
WHERE menus.store_id = stores.id;










