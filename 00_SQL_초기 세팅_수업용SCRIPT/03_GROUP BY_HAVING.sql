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








