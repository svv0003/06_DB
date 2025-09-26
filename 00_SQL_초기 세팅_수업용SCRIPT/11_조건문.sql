DROP DATABASE IF EXISTS TJE;

CREATE DATABASE IF NOT EXISTS TJE;

USE TJE;

-- 직원 테이블
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    age INT,
    hire_date DATE,
    performance_score DECIMAL(3,1)
);

INSERT INTO employees VALUES
(1, '김철수', 'IT', 5500000, 28, '2020-03-15', 4.2),
(2, '이영희', 'HR', 4800000, 32, '2019-07-22', 3.8),
(3, '박민수', 'Sales', 6200000, 35, '2018-11-10', 4.5),
(4, '정수진', 'IT', 4200000, 25, '2021-01-08', 3.9),
(5, '홍길동', 'Finance', 5800000, 40, '2017-05-20', 4.1),
(6, '송미영', 'Sales', 3800000, 27, '2022-02-14', 3.5),
(7, '장동건', 'IT', 7200000, 45, '2015-09-03', 4.8),
(8, '김미나', 'HR', 5200000, 30, '2020-10-12', 4.0);

-- 제품 테이블
CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT,
    stock_quantity INT,
    supplier VARCHAR(30)
);

INSERT INTO products VALUES
(1, '노트북', 'Electronics', 1200000, 15, 'TechCorp'),
(2, '마우스', 'Electronics', 25000, 50, 'TechCorp'),
(3, '키보드', 'Electronics', 80000, 30, 'InputDevice'),
(4, '의자', 'Furniture', 150000, 8, 'ComfortSeats'),
(5, '책상', 'Furniture', 300000, 5, 'OfficeFurniture'),
(6, '모니터', 'Electronics', 450000, 12, 'DisplayTech'),
(7, '램프', 'Furniture', 75000, 20, 'LightingSolutions');



/********************

IF 함수
IF (조건식, TRUE 결과 값, FALSE 결과 값);

********************/

SELECT * FROM employees;

-- employees 테이블에서 급여에 따른 등급 분류하기.
SELECT emp_name, salary, IF(salary>=6000000, '고액 연봉', '평균 연봉') AS '연봉 상태'
FROM employees;

-- employees 테이블에서 나이에 따른 등급 분류하기.
SELECT emp_name, age, IF(age>=30, '30대 이후', '30대 이전') AS '30대 기준 분류'
FROM employees;

/********************

중첩 IF 함수
IF (조건식, TRUE 결과 값, FALSE 결과 값);

********************/

-- employees 테이블에서 나이에 따른 등급 분류하기.
SELECT emp_name, age, IF(age>=30, '30대 이후',
						IF(age>=20, '20대', '10대')) AS '20대, 30대 기준 분류'
FROM employees;


/********************

다양한 IF 활용

********************/

-- employees 테이블에서 성과급에 따른 결과 계산하기.
SELECT emp_name, salary, performance_score, salary + IF(performance_score >= 4.5, floor(salary * 0.1),
														IF(performance_score >= 4.0, floor(salary * 0.05), 0)) AS '월급 (성과급 포함)'
FROM employees;


SELECT * FROM products;
-- products 테이블에서 재고에 따른 결과 확인하기.
SELECT product_name, stock_quantity, if(stock_quantity>15, 'OK', if(stock_quantity>=5, '발주 필요', '긴급 발주')) AS '주문상태'
FROM products;



/********************

CASE 함수
ELSE 생략 가능.
BETWEEN, AND, OR 사용 가능.

CASE 컬럼명
	WHEN 값1		THEN 결과1
	WHEN 값1		THEN 결과1
	WHEN 값1		THEN 결과1
	ELSE 기본값
END


********************/

SELECT * FROM employees;
-- employees 테이블에서 부서별 한글명으로 변환하여 조회하기.
SELECT emp_name, department, CASE department
								WHEN 'IT' THEN '정보기술팀'
								WHEN 'HR' THEN '인사팀'
								WHEN 'Sales' THEN '영업팀'
								WHEN 'Finance' THEN '재무팀'
								END AS '부서'
FROM employees;

SELECT * FROM products;
-- products 테이블에서 카테고리 한글명으로 변환하여 조회하기.
SELECT product_name, category, CASE category
								WHEN 'Electronics' THEN '전자제품'
								WHEN 'Furniture' THEN '가구'
								END AS '카테고리'
FROM products;

-- products 테이블에서 공급업체별 등급 분류하기.
SELECT product_name, supplier, CASE supplier
								WHEN 'TechCorp' AND 'DisplayTech' THEN 'A급'
								WHEN 'InputDevice' THEN 'B급'
                                ELSE 'C급'
								END AS '공급업체 등급'
FROM products;

SELECT product_name, supplier, CASE 
								WHEN supplier IN ('TechCorp', 'DisplayTech') THEN 'A급'
								WHEN supplier = 'InputDevice' THEN 'B급'
								ELSE 'C급'
								END AS 공급업체등급
FROM products;



/********************

SEARCH CASE 함수

********************/

-- employees 테이블에서 나이 세대 분류하기.
SELECT emp_name, age, CASE
						WHEN age BETWEEN 20 AND 29 THEN 'MZ세대'
						WHEN age BETWEEN 30 AND 39 THEN '밀레니얼세대'
						WHEN age > 39 THEN 'X세대'
                        END AS '세대 분류'
FROM employees;


-- products 테이블에서 가격에 따른 등급 분류하기.
SELECT product_name, price, CASE
							WHEN price > 500000 THEN '고가형'
							WHEN price BETWEEN 100000 AND 500000 THEN '중가형'
							WHEN price < 100000 THEN '저가형'
							ELSE '분류 불가'
							END AS '가격 등급'
FROM products;


-- employees 테이블에서 급여, 성과 종합적으로 평가하여 등급 평가하기.
SELECT emp_name, salary, performance_score, CASE
											WHEN salary >= 6000000 AND performance_score >= 4.5 THEN '최우수'
											WHEN salary >= 5000000 AND performance_score >= 4	THEN '우수'
											WHEN salary >= 4000000 AND performance_score >= 3.5 THEN '보통'
											ELSE '개선 필요'
                                            END AS 종합평가
FROM employees;



/********************

Single Case 함수		정확한 값의 매칭이 필요할 때 사용하며,
					문자열이나 고정 값의 비교할 때 적합하다.
Searched Case 함수	복잡한 조건식이 필요할 때 사용한다.
					볌위 또는 복잡 조건 사용할 때 적합하다.
                    
BETWEEN, AND, OR, IN, 비교연산자 등 다양한 연산자를 사용하여 조건 설정 가능하다.

ELSE 절은 선택 사항이지만 NULL을 방지하기 위해 사용하는 것을 권장한다.

조건 작성 순서가 중요하고, 데이터 타입은 일치해야 한다.

WHEN 설정한 조건을 VIEW 테이블로 만들어주기도 한다.

********************/

-- employees 테이블에서 나이, 급여, 성과점수를 종합해서 승진 후보자를 선정하세요.
-- 승진 기준:
-- 35세 이상이면서 급여 550만원 이상이고 성과 4.2 이상 → 임원 후보
-- 30세 이상이면서 급여 500만원 이상이고 성과 4.0 이상 → 팀장 후보
-- 25세 이상이면서 급여 450만원 이상이고 성과 3.8 이상 → 선임 후보
-- 성과 3.5 미만 → 교육 필요
-- 그 외 → 현재 유지
-- 출력: 직원명, 나이, 급여, 성과점수, 승진구분
SELECT emp_name, age, salary, performance_score, CASE
													WHEN age >= 35 AND salary >= 5500000 AND performance_score >= 4.2 THEN '임원 후보'
													WHEN age >= 30 AND salary >= 5000000 AND performance_score >= 4.0 THEN '팀장 후보'
													WHEN age >= 25 AND salary >= 4500000 AND performance_score >= 3.8 THEN '선임 후보'
													WHEN performance_score < 3.5 THEN '교육 필요'
													ELSE '현재 유지'
                                                    END AS '승진 구분'
FROM employees;
