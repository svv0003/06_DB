/*
DDL
데이터를 정의하는 언어.
개체를 생성, 수정, 삭제하는 SQL 명령어.

ALTER
수정 가능한 것	: 컬럼 		(추가/수정/삭제)
			  제약 조건	(추가/삭제)
			  명칭 변경	(테이블, 컬럼, 제약 조건)
              
테이블을 수정하는 경우
ALTER TABLE 테이블명 ADD|MODIFY|DROP 수정내용;

1) 제약 조건 추가/삭제
* 작성법 중 대괄호 [] 생략 가능 (개발자 선택 사항)

MySQL는 안 되는 경우가 더 많다.
제약 조건 추가 : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약 조건명] 제약 조건(컬럼명) [REFERENCES 테이블명[(컬럼명)];
제약 조건 삭제 : ALTER TABLE 테이블명 DROP CONSTRAINT 제약 조건명

ON UPDATE 조건 : 레코드 수정 시 기본값으로 컬럼 데이터 모두 수정한다.
ON UPDATE CURRENT_TIMESTAMP : 특정 컬럼의 데이터가 수정될 경우 자동으로 시간 업데이트되는 설정.

*/



CREATE TABLE department (
    dept_id VARCHAR(10),
    dept_title VARCHAR(35),
    location_id VARCHAR(10)
);

INSERT INTO department VALUES 
('D1', '인사관리부', 'L1'),
('D2', '회계관리부', 'L2'),  
('D3', '마케팅부', 'L3'),
('D4', '국내영업부', 'L4'),
('D5', '해외영업1부', 'L5');

CREATE TABLE employee (
    emp_id INT,
    emp_name VARCHAR(30),
    emp_no VARCHAR(14),
    email VARCHAR(30),
    phone VARCHAR(12),
    dept_code VARCHAR(10),
    job_code VARCHAR(10),
    sal_level VARCHAR(2),
    salary INT,
    bonus DECIMAL(2,1),
    manager_id INT,
    hire_date DATE,
    ent_date DATE,
    ent_yn CHAR(1) DEFAULT 'N'
);

CREATE TABLE location (
    local_code VARCHAR(10),
    local_name VARCHAR(40)
);

INSERT INTO location VALUES 
('L1', 'ASIA1'),
('L2', 'ASIA2'),
('L3', 'ASIA3'),
('L4', 'AMERICA'),
('L5', 'EUROPE');

CREATE TABLE job (
    job_code VARCHAR(10),
    job_name VARCHAR(35)
);

INSERT INTO job VALUES 
('J1', '대표'),
('J2', '부사장'),
('J3', '부장'),
('J4', '차장'),
('J5', '과장'),
('J6', '대리'),
('J7', '사원');

CREATE TABLE sal_grade (
    sal_level VARCHAR(2),
    min_sal INT,
    max_sal INT
);

INSERT INTO sal_grade VALUES 
('S1', 6000000, 10000000),
('S2', 5000000, 5999999),
('S3', 4000000, 4999999),
('S4', 3000000, 3999999),
('S5', 2000000, 2999999),
('S6', 1000000, 1999999);




-- 1. 제약 조건 추가하기.
-- 부서 테이블에 PK 추가하기.
-- 			어떤 작업을 할 것인지 선택하기.
-- 									 작업에 해당하는 명칭 설정하기.
-- DROP
-- CREATE							  테이블명
-- ALTER							  테이블명
ALTER TABLE department ADD CONSTRAINT dept_pk PRIMARY KEY(dept_id);
-- 테이블에 제약 조건만 추가한 것.
-- > 데이터 타입은 기존에 생성할 때 작성했기 때문에 필요하지 않다.
-- CONSTRAINT는 필수가 아니며 선택 가능하다.

ALTER TABLE department MODIFY dept_id VARCHAR(10) PRIMARY KEY;
-- 컬럼 자체를 전체적으로 수정한 것.
-- > 데이터 타입을 반드시 명시해야 한다.
-- 컬럼 속성과 제약 조건을 동시에 변경할 때 사용한다.

-- -- > 단순히 제약 조건만 추가한다?	-> ADD
-- -- > 제약 조건 자체를 다시 세팅한다? -> MODIFY
-- -- -- > 테이블 자체를 DROP, CREATE 하기에는 부담이 크고, 컬럼 하나의 자료형, 제약 조건을 교체할 때 사용한다.


-- department 테이블에 UNIQUE 제약 조건을 dept_title에 추가하기.
ALTER TABLE department ADD UNIQUE(dept_title);

-- CHECK 제약 조건을 IN 사용하여 다수의 LOCATION_ID에 추가하기.
ALTER TABLE department ADD CHECK(location_id IN('L1', 'L2', 'L3', 'L4', 'L5'));

-- employee 테이블에 dept_id 참조하는 dept_code 외래키를 추가하기.
ALTER TABLE employee ADD FOREIGN KEY(dept_code) REFERENCES department(dept_id);



-- CONSTRAINT 제약조건명
-- 테이블 자체에서 컬럼에 제약 조건을 추가하는 것이기 때문에 CONSTRAINT 테이블 레벨로 기본키를 추가한 것이다.
-- MYSQL에서는 컬럼 레벨에서 CHECK 이외에는 모두 제약 조건명 사용 불가능하다!




-- employee 테이블에 NOT NULL 제약조건을 emp_name에 추가
ALTER TABLE employee MODIFY emp_name VARCHAR(30) NOT NULL;
-- employee 테이블에 NOT NULL 제약조건을 emp_no에 추가
ALTER TABLE employee MODIFY emp_no VARCHAR(14) NOT NULL;
-- department 테이블에 mgr_id 컬럼을 INT 타입으로 추가
ALTER TABLE department ADD mgr_id INT;
-- department 테이블에 create_date 컬럼을 TIMESTAMP 타입으로 기본값 CURRENT_TIMESTAMP로 추가
ALTER TABLE department ADD create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;


-- NOT NULL 제약 조건은 ADD를 사용해서 추가할 수 없다.
-- ADD 추가 가능한 제약 조건은 PK, FK, UNIQUE, CHECK, 자료형(INT, VARCHAR, ...), 새 컬럼명 등
-- NOT NULL은 제약 조건이 아니라 컬럼의 속성으로 취급되며, 컬럼 속성 변경을 할 때는 MODIFY를 사용해야 한다.
-- 새로운 컬럼을 추가할 때는 ADD COLUMN 예약어를 사용한다.
-- 기존 컬럼을 삭제할 때는 DROP COLUMN 예약어를 사용한다.
-- 컬럼명을 수정할 때는 RENAME COLUMN + TO 예약어를 사용한다.

-- ADD, DROP만 사용해도 컬럼 수정 가능하지만 MySQL만 예외적인 것이다.
-- > 다른 SQL은 COLUMN을 필수로 작성해야 한다.

-- department 테이블에서 create_date 컬럼 삭제하기.
ALTER TABLE department DROP create_date;

-- 특정 컬럼명 변경하기.
ALTER TABLE department RENAME COLUMN dept_title TO dept_name;



-- 테이블 삭제
-- 다수의 SQL : DROP TABLE 테이블명 [CASECADE CONSTRAINTS] ;
-- MySQL    : DROP TABLE 테이블명 ;
--            외래키 활성화/비활성화 후 부모테이블 삭제 여부 결정된다.

DROP TABLE BOOK;
-- Error Code: 3730.
-- ORDER_DETAIL 테이블에서 외래키를 통해 참조되고 있기 때문에 삭제 불가능하다.

-- 방법 세 가지
-- 자식 -> 부모 순서대로 삭제하거나
-- 외래키 제약 조건만 삭제하거나
-- 외래키 체크 임시 비활성화를 통해 삭제한다.

-- 방법 1번
DROP TABLE order_detail;
DROP TABLE book;

-- practice_db에 존재하는 테이블 삭제하기
-- customer, department, employee, product 삭제하기.
USE practice_db;
DROP TABLE customer;
DROP TABLE department;
DROP TABLE employee;
DROP TABLE product;
DROP DATABASE practice_db;

-- bookstore ~ 스노우까지 모두 삭제하기.
DROP DATABASE bookstore;
DROP DATABASE chun_university;
DROP DATABASE delivery_app;
DROP DATABASE delivery_db;
DROP DATABASE 네이버;
DROP DATABASE 라인;
DROP DATABASE 스노우;
DROP DATABASE employee_management;

















