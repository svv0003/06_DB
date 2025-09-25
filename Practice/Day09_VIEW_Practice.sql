-- ========================================
-- MySQL 기반: 온라인 쇼핑몰 데이터베이스
-- ========================================

CREATE DATABASE IF NOT EXISTS online_shop;
USE online_shop;

-- ========================================
-- LEVEL 
-- ========================================

-- 문제 1-1: CATEGORY 테이블 생성
/*
조건:
- category_id: 자동증가 기본키
- category_name: 카테고리명 (50자, NULL 불가, 중복 불가)
- description: 설명 (TEXT)
- is_active: 활성상태 (BOOLEAN, 기본값 TRUE)
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
*/
CREATE TABLE IF NOT EXISTS category (
	category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



-- 문제 1-2: CUSTOMER 테이블 생성
/*
조건:
- customer_id: 자동증가 기본키
- username: 사용자명 (30자, NULL 불가, 중복 불가)
- email: 이메일 (100자, NULL 불가, 중복 불가)
- password: 비밀번호 (255자, NULL 불가)
- full_name: 실명 (50자, NULL 불가)
- phone: 전화번호 (20자)
- birth_date: 생년월일 (DATE)
- gender: 성별 (ENUM: 'M', 'F', 'OTHER')
- point: 적립금 (정수, 기본값 0, 0 이상)
- grade: 등급 (VARCHAR(20), 기본값 'BRONZE')
- is_active: 활성상태 (BOOLEAN, 기본값 TRUE)
- join_date: 가입일 (TIMESTAMP, 기본값 현재시간)
- last_login: 마지막 로그인 (TIMESTAMP)
*/
CREATE TABLE IF NOT EXISTS customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'OTHER'),
    point INT DEFAULT 0 CHECK (point >= 0),
    grade VARCHAR(20) DEFAULT 'BRONZE',
    is_active BOOLEAN DEFAULT TRUE,
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);



-- 문제 1-3: PRODUCT 테이블 생성
/*
조건:
- product_id: 자동증가 기본키
- product_name: 상품명 (100자, NULL 불가)
- category_id: 카테고리ID (정수, 외래키)
- price: 가격 (정수, NULL 불가, 0 이상)
- discount_rate: 할인율 (DECIMAL(5,2), 기본값 0.00, 0~100 사이)
- stock_quantity: 재고수량 (정수, 기본값 0, 0 이상)
- description: 상품설명 (TEXT)
- brand: 브랜드 (50자)
- weight: 무게 (DECIMAL(8,2))
- status: 상태 (ENUM: 'AVAILABLE', 'OUT_OF_STOCK', 'DISCONTINUED', 기본값 'AVAILABLE')
- created_at: 등록시간 (TIMESTAMP, 기본값 현재시간)
- updated_at: 수정시간 (TIMESTAMP, 기본값 현재시간, 수정시 자동 업데이트)
*/
CREATE TABLE IF NOT EXISTS product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price INT NOT NULL CHECK (price >= 0),
    discount_rate DECIMAL(5,2) DEFAULT 0.00 CHECK (discount_rate >= 0 AND discount_rate <= 100),
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0),
    description TEXT,
    brand VARCHAR(50),
    weight DECIMAL(8,2),
    status ENUM('AVAILABLE', 'OUT_OF_STOCK', 'DISCONTINUED') DEFAULT 'AVAILABLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);




-- 문제 1-4: INSERT
-- CATEGORY 테이블에 다음 데이터를 삽입하세요
/*
1. 전자제품, '스마트폰, 노트북, 태블릿 등', TRUE
2. 의류, '남성복, 여성복, 아동복', TRUE
3. 도서, '소설, 전문서적, 교육서적', TRUE
4. 스포츠/레저, '운동용품, 아웃도어 장비', TRUE
5. 식품, '신선식품, 가공식품', FALSE
*/
INSERT INTO category (category_name, description, is_active)
		VALUES ('전자제품', '스마트폰, 노트북, 태블릿 등', TRUE),
				('의류', '남성복, 여성복, 아동복', TRUE),
                ('도서', '소설, 전문서적, 교육서적', TRUE),
				('스포츠/레저', '운동용품, 아웃도어 장비', TRUE),
				('식품', '신선식품, 가공식품', FALSE);
SELECT * FROM category;


-- CUSTOMER 테이블에 다음 데이터를 삽입하세요
/*
1. hong123, hong@email.com, password123, 홍길동, 010-1111-2222, 1990-05-15, M, 5000, GOLD
2. kim_user, kim@email.com, mypass456, 김영희, 010-3333-4444, 1995-08-20, F, 3000, SILVER  
3. park2024, park@email.com, secure789, 박민수, 010-5555-6666, 1988-12-03, M, 10000, PLATINUM
4. lee_shop, lee@email.com, password999, 이수진, 010-7777-8888, 2000-03-10, F, 1500, BRONZE
5. choi_buy, choi@email.com, pass1234, 최준호, NULL, 1992-07-25, M, 0, BRONZE
*/
INSERT INTO customer (username, email, password, full_name, phone, birth_date, gender, point, grade)
VALUES	('hong123', 'hong@email.com', 'password123', '홍길동', '010-1111-2222', '1990-05-15', 'M', 5000, 'GOLD'),
		('kim_user', 'kim@email.com', 'mypass456', '김영희', '010-3333-4444', '1995-08-20', 'F', 3000, 'SILVER'),
		('park2024', 'park@email.com', 'secure789', '박민수', '010-5555-6666', '1988-12-03', 'M', 10000, 'PLATINUM'),
		('lee_shop', 'lee@email.com', 'password999', '이수진', '010-7777-8888', '2000-03-10', 'F', 1500, 'BRONZE'),
		('choi_buy', 'choi@email.com', 'pass1234', '최준호', NULL, '1992-07-25', 'M', 0, 'BRONZE');
SELECT * FROM customer;


-- PRODUCT 테이블에 다음 데이터를 삽입하세요
/*
1. iPhone 15 Pro, 카테고리1, 1200000, 5.00, 50, '최신 아이폰 모델', 'Apple', 200.00, AVAILABLE
2. 삼성 갤럭시 북, 카테고리1, 1500000, 10.00, 30, '고성능 노트북', 'Samsung', 1500.00, AVAILABLE
3. 남성 정장, 카테고리2, 200000, 20.00, 100, '비즈니스 정장', 'Hugo Boss', NULL, AVAILABLE
4. 운동화, 카테고리4, 150000, 15.00, 0, '러닝화', 'Nike', 300.00, OUT_OF_STOCK
5. 요리책, 카테고리3, 25000, 0.00, 200, '집밥 요리 레시피', '맛있는책', 500.00, AVAILABLE
*/
INSERT INTO product (product_name, category_id, price, discount_rate, stock_quantity, description, brand, weight, status)
VALUES	('iPhone 15 Pro', 1, 1200000, 5.00, 50, '최신 아이폰 모델', 'Apple', 200.00, 'AVAILABLE'),
		('삼성 갤럭시 북', 1, 1500000, 10.00, 30, '고성능 노트북', 'Samsung', 1500.00, 'AVAILABLE'),
		('남성 정장', 2, 200000, 20.00, 100, '비즈니스 정장', 'Hugo Boss', NULL, 'AVAILABLE'),
		('운동화', 4, 150000, 15.00, 0, '러닝화', 'Nike', 300.00, 'OUT_OF_STOCK'),
		('요리책', 4, 25000, 0.00, 200, '집밥 요리 레시피', '맛있는책', 500.00, 'AVAILABLE');
SELECT * FROM product;


/*
ALTER TABLE category AUTO_INCREMENT = 1;
ALTER TABLE customer AUTO_INCREMENT = 1;
ALTER TABLE product AUTO_INCREMENT = 1;
*/




-- 문제 1: 상품 및 카테고리 정보 조회 VIEW 생성
-- 요구사항: PRODUCT 테이블의 상품명(product_name)과 CATEGORY 테이블의 카테고리명(category_name)을 함께 볼 수 있는 V_PRODUCT_CATEGORY 라는 이름의 VIEW를 생성하세요.
-- 힌트: PRODUCT 테이블과 CATEGORY 테이블을 category_id로 JOIN 해야 합니다.
CREATE OR REPLACE VIEW V_PRODUCT_CATEGORY
AS SELECT p.product_name, c.category_name
FROM product p
JOIN category c
ON p.category_id = c.category_id;
SELECT * FROM V_PRODUCT_CATEGORY;




-- 문제 2: 우수 고객 정보 필터링 VIEW 생성
-- 요구사항: CUSTOMER 테이블에서 등급(grade)이 'GOLD' 이상('GOLD', 'PLATINUM')이고, 현재 활성 상태(is_active)인 고객들의 정보만 필터링하는 V_VIP_CUSTOMERS 라는 VIEW를 생성하세요. VIEW에는 고객의 사용자명(username), 이메일(email), 등급(grade), 적립금(point)이 포함되어야 합니다.
-- 힌트: WHERE 절을 사용하여 두 가지 조건을 동시에 만족하는 데이터를 선택하세요. IN 연산자를 활용하면 등급 조건을 쉽게 처리할 수 있습니다.
CREATE OR REPLACE VIEW V_VIP_CUSTOMERS
AS SELECT username, email, grade, point
FROM customer
WHERE grade IN ('GOLD', 'PLATINUM')
AND is_active = TRUE;
SELECT * FROM V_VIP_CUSTOMERS;


-- 문제 3: 상품 할인 가격 계산 VIEW 생성
-- 요구사항: PRODUCT 테이블의 상품명(product_name), 원래 가격(price), 할인율(discount_rate)을 사용하여 실제 판매 가격을 계산한 discounted_price 컬럼을 포함하는 V_PRODUCT_SALE_PRICE VIEW를 생성하세요.
-- 힌트: price * (1 - discount_rate / 100) 수식을 사용하여 할인된 가격을 계산할 수 있습니다. AS를 사용해 계산된 컬럼의 이름을 지정해주세요.
CREATE OR REPLACE VIEW V_PRODUCT_SALE_PRICE
AS SELECT product_name, price, concat(discount_rate, '%'), price * (1 - discount_rate / 100) 'discounted_price'
FROM product;
SELECT * FROM V_PRODUCT_SALE_PRICE;


-- 문제 4: 카테고리별 상품 통계 VIEW 생성
-- 요구사항: 각 카테고리별로 몇 개의 상품이 등록되어 있는지, 그리고 평균 가격은 얼마인지 계산하는 V_CATEGORY_STATS VIEW를 생성하세요. VIEW에는 카테고리명(category_name), 해당 카테고리의 상품 수(product_count), 평균 가격(avg_price)이 포함되어야 합니다.
-- 힌트: GROUP BY를 사용하여 카테고리별로 그룹화하고, COUNT()와 AVG() 집계 함수를 사용해야 합니다.
CREATE OR REPLACE VIEW V_CATEGORY_STATS
AS SELECT c.category_name, count(p.product_id) 'product_count', floor(avg(p.price)) 'avg_price'
FROM product P
JOIN category C
ON c.category_id = p.category_id
GROUP BY category_name;
SELECT * FROM V_CATEGORY_STATS;


/********************

TCL		트랜젝션 제어 언어
트랜잭션	업무, 처리
		DB의 논리적 연산 단위

Oracle은 기본적으로 Auto Commit 비활성화
-> COMMIT 명시적으로 실행해야 변경 사항이 영구적으로 저장된다.

MySQL은 기본적으로 Auto Commit 활성화
-> 각 DML 구문 실행될 때마다 자동으로 COMMIT 된다.

START TRANSACTION ; 또는 SET autocommit = 0; 먼저 실행하기.

COMMIT		메모리 버퍼 (트랜잭션)에 임시 저장된 데이터 변경 사항을 DB에 반영한다.
			메모장, 포토샵 등에서 이미지나 글자를 저장하기 전 단계.
            Commit은 메모장, 포토샵 등에 작성한 이미지나 글자 데이터를 DB에 저장하는 역할.
            
ROLLBACK	메모리 버퍼 (트랜잭션)에 임시 저장된 데이터 변경 사항을 삭제하고, 마지막 COMMIT 상태로 돌아간다.
			기존에 작업한 데이터를 지우고, 마지막에 저장한 상태로 되돌아간다.
            
SAVEPOINT	트랜잭션 내에 저장 지점을 정의하며, ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌
			지정한 SAVEPOINT까지만 일부 되돌아간다.
            
            SAVEPOINT 포인트명1;
            ...
			SAVEPOINT 포인트명2;
			...
			SAVEPOINT 포인트명3;
            
            ROLLBACK TO SAVEPOINT 포인트명2;		포인트명2 지점까지 데이터 변경사항 삭제한다.
												포인트명3 저장 내역은 사라진다.
            
사용 예시
계좌이체 시 계좌 하나는 차감하고, 다른 하나는 추가된다.
성공적으로 마친다면 이 거래를 확정한다. COMMIT
실패한다면 COMMIT 하지 않고, ROLLBACK 하여 없던 일로 되돌린다.

온라인 쇼핑 주문 : 재고 감소 + 주문 내역 생성 + 포인트 적립
항공권 / 숙소 예약 : 좌석 예약 + 결제 정보 기록 + 예약자 정보 생성

복잡하고 긴 작업 중 일부만 되돌리고 싶을 때 SAVEPOINT 사용해서 중간 지점까지 되돌리기.
       
********************/








