CREATE DATABASE practice_db;
USE practice_db;


-- 1. 데이터베이스 생성 및 사용
-- 힌트: CREATE DATABASE, USE
CREATE DATABASE _________;
USE _________;

-- 2. BOOK 테이블 생성
-- 힌트: BOOK_ID(PK), TITLE(필수), AUTHOR, PRICE(1원이상), STOCK(기본값0, 0이상)
CREATE TABLE BOOK(
    BOOK_ID   VARCHAR(10) PRIMARY KEY ,
    TITLE VARCHAR(100) NOT NULL,
    AUTHOR VARCHAR(50),
    PRICE INT CHECK (PRICE>0),
    STOCK INT DEFAULT 0 CHECK (STOCK>=0)
);

-- 3. 데이터 삽입 (3권의 책)
-- 힌트: B001, B002, B003
INSERT INTO BOOK VALUES ('B001', 'TITLE1', 'AUTHOR1', 1, 0);
INSERT INTO BOOK VALUES ('B002', 'TITLE2', 'AUTHOR2', 10500, 33);
INSERT INTO BOOK VALUES ('B003', 'TITLE3', 'AUTHOR3', 12800, 29);

-- 4. 컬럼 추가
-- 힌트: ALTER TABLE ADD, CATEGORY 컬럼 추가
ALTER TABLE BOOK ADD COLUMN CATEGORY VARCHAR(30) DEFAULT 'Literature';

-- 5. 데이터 수정
-- 힌트: UPDATE SET WHERE
UPDATE BOOK SET CATEGORY = 'IT도서' WHERE book_id = 'B001';

-- 6. CUSTOMER 테이블 생성
-- 힌트: CUSTOMER_ID(PK), NAME(필수), EMAIL(중복불가)
CREATE TABLE CUSTOMER(
    CUSTOMER_ID VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(20) NOT NULL,
    EMAIL VARCHAR(50) UNIQUE
);

-- 7. ORDER_DETAIL 테이블 생성 (외래키 포함)
-- 힌트: 복합키, 외래키 2개
CREATE TABLE ORDER_DETAIL(
    ORDER_NO VARCHAR(20),
    ORDER_CUSTOMER VARCHAR(10),
    ORDER_BOOK VARCHAR(10),
    ORDER_AMOUNT INT,
    
    /*
    예를 들어 고객은 탈퇴하였는데, 주문에는 고객 데이터가 남아있다.
    1. 주문 받고, 문제 없는지 확인하고, 고객은 탈퇴를 하거나, 주문 내역에만 남기거나
    2. 고객에게 주문한 모든 데이터를 삭제할 것이고, 이에 대해서 상품을 받지 못하거나 문제 생겼을 때
    이의 제기를 하지 않는다는 서명 후 탈퇴 -> 모든 내역 삭제
    */
    
    CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (ORDER_NO, ORDER_CUSTOMER, ORDER_BOOK),
    CONSTRAINT FK_ORDER_CUSTOMER FOREIGN KEY (ORDER_CUSTOMER) REFERENCES CUSTOMER(CUSTOMER_ID),
	CONSTRAINT FK_ORDER_BOOK FOREIGN KEY (ORDER_BOOK) REFERENCES BOOK(BOOK_ID)
);

-- 8. SELECT
-- 전체 조회
SELECT * FROM BOOK;

-- 조건 조회 (가격 25000원 이상)
SELECT * FROM BOOK WHERE PRICE >= 25000;

-- 특정 컬럼만 조회 (제목, 가격)
SELECT TITLE, PRICE FROM BOOK;

-- 9. 집계 함수
-- 최대 가격
SELECT MAX(PRICE) FROM BOOK;

-- 평균 가격  
SELECT AVG(PRICE) FROM BOOK;

-- 총 도서 수
SELECT COUNT(*) FROM BOOK;

-- 10. 
INSERT INTO CUSTOMER VALUES ('C001', '김고객', 'kim@email.com');
INSERT INTO ORDER_DETAIL VALUES ('O001', 'C001', 'B002', 2);

-- 11. 데이터 삭제가 안되는 문제 해결
DELETE FROM BOOK WHERE BOOK_ID = 'B001';
-- book 테이블을 참조하는 데이터가 존재해서 발생하는 오류.
-- 참조하는 데이터의 테이블에서 먼저 자식 데이터들을 삭제한 후 book 테이블에서 데이터 삭제 진행한다.

DELETE FROM ORDER_DETAIL WHERE ORDER_BOOK = 'B001';
DELETE FROM BOOK WHERE BOOK_ID = 'B001';

-- 12. 외래키 옵션 설정 후 삭제 진행
DROP TABLE ORDER_DETAIL;

CREATE TABLE ORDER_DETAIL(
    ORDER_ID VARCHAR(20) PRIMARY KEY,
    CUSTOMER_ID VARCHAR(10),
    BOOK_ID VARCHAR(10),
    QUANTITY INT,
    
    CONSTRAINT FK_ORDER_CUSTOMER 
    FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON delete cascade,
    
    CONSTRAINT FK_ORDER_BOOK 
    FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID) ON delete cascade
);

-- 14. CASCADE 정상 작동확인
-- 데이터 다시 입력
INSERT INTO ORDER_DETAIL VALUES ('O002', 'C001', 'B002', 1);

-- 테스트
/*
삭제를 할 때 B002에 해당하는 모든 데이터를 삭제한다?
-> 정말 삭제하시겠습니까?


ON DELETE CASCADE 연결되어 있지 않은 상태라면
-> 정말 삭제하시겠습니까?
삭제하더라도 기존에 작성한 댓글, 게시물 등은 삭제되지 않고 유지된다.
-> 해당 게시물을 통해 유저 페이지로 이동하면 '탈퇴한 회원입니다.'라고 나온다.
메인 테이블의 데이터가 삭제되었을 경우 자식테이블의 데이터는 NULL 설정 가능하다.
ON DELETE SET NULL로 데이터를 유지하되, 메인 테이블을 참조하는 컬럼에는 NULL 값으로 설정한다.
*/
DELETE FROM BOOK WHERE BOOK_ID = 'B002';

SELECT * FROM ORDER_DETAIL;

-- 15. 제약조건 위반
INSERT INTO ORDER_DETAIL VALUES ('O003', 'C999', 'B001', 1);







CREATE TABLE department (
    dept_id VARCHAR(10),
    dept_title VARCHAR(35),
    location_id VARCHAR(10)
);

CREATE TABLE employee (
    emp_id INT,
    emp_name VARCHAR(30),
    emp_no VARCHAR(14),
    email VARCHAR(30),
    phone VARCHAR(15),
    dept_code VARCHAR(10),
    salary INT,
    hire_date DATE
);

CREATE TABLE product (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(20)
);

INSERT INTO department VALUES 
('D1', '인사관리부', 'L1'),
('D2', '회계관리부', 'L2'),
('D3', '마케팅부', 'L3');

INSERT INTO employee VALUES 
(100, '홍길동', '901010-1234567', 'hong@company.com', '010-1234-5678', 'D1', 3000000, '2020-01-01'),
(200, '김영희', '951015-2345678', 'kim@company.com', '010-2345-6789', 'D2', 3500000, '2021-03-15');

INSERT INTO product VALUES 
(1, '노트북', 1200000, 'IT'),
(2, '마우스', 50000, 'IT'),
(3, '책상', 300000, '가구');

/*
UPDATE  컬럼 내에 존재하는 데이터 변경
ALTER   컬럼 내에 존재하는 데이터 이외 모든 변경

ADD     속성, 컬럼 추가
MODIFY  이미 존재하는 컬럼에 속성 추가, 제약 조건 변경/추가
*/


-- 문제 1: employee 테이블의 emp_id 컬럼을 PRIMARY KEY로 설정
ALTER TABLE employee ADD PRIMARY KEY(emp_id);
ALTER TABLE employee MODIFY emp_id INT PRIMARY KEY;
DROP TABLE employee;
-- 문제 2: employee 테이블의 email 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE employee Modify email VARCHAR(30) NOT NULL;
-- 문제 3: product 테이블의 product_name 컬럼에 NOT NULL 제약조건 추가
ALTER TABLE product MODIFY product_name VARCHAR(50) NOT NULL;
-- 문제 4: employee 테이블에 bonus 컬럼을 DECIMAL(3,2) 타입으로 추가
ALTER TABLE employee ADD bonus DECIMAL(3,2);
-- 문제 5: product 테이블에 stock_quantity 컬럼을 INT 타입으로 추가, 기본값 0
ALTER TABLE product ADD stock_quantity INT DEFAULT 0;
-- 문제 6: employee 테이블의 phone 컬럼을 VARCHAR(15) 타입으로 수정
ALTER TABLE employee MODIFY phone VARCHAR(15);
-- 문제 7: employee 테이블의 salary 컬럼을 BIGINT 타입으로 수정
ALTER TABLE employee MODIFY salary BIGINT;
-- 문제 8: product 테이블의 price 컬럼을 DECIMAL(10,2) 타입으로 수정
ALTER TABLE product MODIFY price DECIMAL(10,2);
-- 문제 9: employee 테이블의 emp_no 컬럼명을 social_no로 변경
ALTER TABLE employee RENAME COLUMN emp_no TO social_no;
-- 문제 10: product 테이블에서 stock_quantity 컬럼 삭제
ALTER TABLE product DROP COLUMN stock_quantity;
-- 문제 11: product 테이블의 product_id를 PRIMARY KEY로 설정
ALTER TABLE product MODIFY product_id INT PRIMARY KEY;
-- 문제 12: category 컬럼에 CHECK 제약조건 추가
ALTER TABLE product ADD CHECK(category IN('IT', '가구'));
-- 문제 13: description 컬럼을 TEXT 타입으로 추가
ALTER TABLE product ADD description TEXT;

SELECT * FROM product;