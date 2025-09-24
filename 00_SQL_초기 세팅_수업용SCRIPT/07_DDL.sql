CREATE TABLE USER_TABLE (
    USER_NO INT PRIMARY KEY,                          -- 컬럼 레벨 PK
    USER_ID VARCHAR(20) UNIQUE,                       -- 컬럼 레벨 UNIQUE
    USER_PWD VARCHAR(30) NOT NULL,                    -- 컬럼 레벨 NOT NULL
    GENDER VARCHAR(10) CHECK(GENDER IN ('남', '여'))   -- 컬럼 레벨 CHECK
);



CREATE TABLE USER_TABLE (
    USER_NO INT,
    USER_ID VARCHAR(20),
    USER_PWD VARCHAR(30) NOT NULL,                    -- NOT NULL은 컬럼 레벨만 가능
    GENDER VARCHAR(10),
    
    -- 👇 테이블 레벨 제약조건들
    CONSTRAINT PK_USER_NO PRIMARY KEY(USER_NO),
    CONSTRAINT UK_USER_ID UNIQUE(USER_ID),
    CONSTRAINT CK_GENDER CHECK(GENDER IN ('남', '여'))
);


/*
LIBRARY_MEMBER 테이블을 생성하세요.

컬럼 정보:
- MEMBER_NO: 회원번호 (숫자, 기본키)
- MEMBER_NAME: 회원이름 (최대 20자, 필수입력)
- EMAIL: 이메일 (최대 50자, 중복불가)
- PHONE: 전화번호 (최대 15자)
- AGE: 나이 (숫자, 7세 이상 100세 이하만 가능)
- JOIN_DATE: 가입일 (날짜시간, 기본값은 현재시간)

제약조건명 규칙:
- PK: PK_테이블명_컬럼명
- UK: UK_테이블명_컬럼명  
- CK: CK_테이블명_컬럼명
*/


USE delivery_app;

CREATE TABLE library_member (
-- 다른 SQL에서는 컬럼 레벨로 재약 조건을 작성할 때
-- CONSTRAINT를 작성해서 제약 조건명을 설정할 수 있지만
-- MySQL에서는 제약 조건명을 MySQL에서 자동 생성하기 때문에
-- 명칭 작성을 컬럼 레벨에서 할 수 없다.
-- 	컬럼명		자료형(크기)	제약 조건		제약 조건명						제약 조건 설정
-- 	member_no	INT			CONSTRAINT	PK_library_member_member_no		PRIMARY KEY,
	member_no	INT			PRIMARY KEY,
    member_name VARCHAR(20) NOT NULL,
--  email		VARCHAR(50) CONSTRAINT	UK_library_member_email			UNIQUE,
	email		VARCHAR(50)	UNIQUE,
    phone 		VARCHAR(15),
	age 		INT			CONSTRAINT	CK_library_age					CHECK(age >= 7 AND age <= 100),
    join_date	TIMESTAMP	DEFAULT		CURRENT_TIMESTAMP
);
/*
member_no, email에는 제약 조건명 설정 안 되지만
단순히 PK, UNIQUE, FK, NOT NULL과 같이 한 단어로 키 형태를 작성하는 경우 제약 조건명 설정 불가능하다.

age에서는 제약 조건명 설정 가능한 이유
CHECK처럼 제약 조건이 상세한 경우에는 제약 조건명 설정 가능하다.
CHECK만 개발자가 지정한 제약 조건명 설정 가능하다.
*/



SELECT * FROM library_member;

-- 만약 이메일 크기가 21인 사람은 회원가입 안 된다고 항의가 들어온다면?
INSERT INTO library_member (member_no, member_name, email, phone, age)
		VALUES (1, '김독서', 'kimreadbook@book.com', '010-1111-2222', 25);
        
-- 방법 1번
-- DROP 사용해서 테이블을 새로 생성한다.
-- > 기존 데이터는 사라진다.
-- -- > 폐업한다.

-- 방법 2번
-- email 컬럼 크기를 ALTER 사용해서 수정한다.
ALTER TABLE library_member
MODIFY email VARCHAR(50) UNIQUE;
-- ALTER 사용해서 컬럼 속성을 변경할 경우에 컬럼명에 해당하는 정보를 하나 더 만들어놓은 후 해당 제약 조건을 동작한다.
-- ALTER에서 자세히 설명할 예정...

/*
ALTER 사용해서 컬럼 조건을 수정한다면
Indexs에 컬럼명, 컬럼명_2, 컬럼명_3, ... 과 같은 형식으로 추가된다.

Indexs
email
email_2		와 같은 형태로 존재한다.

email 제약 조건		VARCHAR(20) UNIQUE,
email_2 제약 조건		VARCHAR(50) UNIQUE,

컬럼명		인덱스
email		email, email_2 중에서 가장 최근에 생성된 명칭으로 연결된다.
			기존 제약 조건으로 되돌리고 싶을 때는 인덱스 (제약 조건명)를 통해 재설정 가능하다.
*/

INSERT INTO library_member
		VALUES (2, '박중복', 'park@email.com', '010-9999-8888', 30, DEFAULT),
			   (6, '이나이', 'lee@email.com', '010-7777-6666', 7, DEFAULT);



/*
온라인 쇼핑몰의 PRODUCT(상품) 테이블과 ORDER_ITEM(주문상품) 테이블을 생성하세요.

1) PRODUCT 테이블:
- PRODUCT_ID: 상품코드 (문자 10자, 기본키)
- PRODUCT_NAME: 상품명 (문자 100자, 필수입력)
- PRICE: 가격 (숫자, 0보다 큰 값만 가능)
- STOCK: 재고수량 (숫자, 0 이상만 가능, 기본값 0)
- STATUS: 판매상태 ('판매중', '품절', '단종' 중 하나만 가능, 기본값 '판매중')

2) ORDER_ITEM 테이블:
- ORDER_NO: 주문번호 (문자 20자)  
- PRODUCT_ID: 상품코드 (문자 10자)
- QUANTITY: 주문수량 (숫자, 1 이상만 가능)
- ORDER_DATE: 주문일시 (날짜시간, 기본값은 현재시간)

주의사항:
- ORDER_ITEM의 PRODUCT_ID는 PRODUCT 테이블의 PRODUCT_ID를 참조해야 함
- ORDER_ITEM은 (주문번호 + 상품코드) 조합으로 기본키 설정 (복합키)
*/

CREATE TABLE product (
-- 	기본키라고 해서 AUTO_INCREMENT 사용 가능한 것은 아니다.
--  정수 자료형만 설정 가능하다.
	product_id		VARCHAR(10)		PRIMARY KEY,
    product_name	VARCHAR(100)	NOT NULL,
--  price			INT				CHECK(price > 0),	constraint 제약조건명 필수 아니다!
    price			INT				CONSTRAINT CH_product_price		CHECK(price > 0),
--  stock			INT				CHECK(price > 0)	DEFAULT 0,
	stock			INT 			DEFAULT 0 			CHECK(stock >= 0),
	status			ENUM('판매중', '품절', '단종') 			DEFAULT '단종'
-- 	STATUS VARCHAR(20) DEFAULT '판매중' CONSTRAINT CK_PRODUCT_STATUS CHECK(STATUS IN ('판매중', '품절', '단종'))
);

CREATE TABLE order_item (
	order_no		VARCHAR(20),
    product_id		VARCHAR(10),
    quantity		INT				CHECK(quantity >= 1),
    order_date		TIMESTAMP		DEFAULT CURRENT_TIMESTAMP
);


SELECT * FROM product;
SELECT * FROM order_item;

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');

-- 제품이 존재하고, 제품번호에 따른 주문
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);
-- CREATE TABLE 할 때 FK를 작성하지 않아서
-- 존재하지 않는 제품번호의 주문이 들어오면 문제 발생한다.



-- 테이블(이 존재한다면) 삭제하고, 다시 생성하기.
-- 외래키가 성정되었을 경우에 메인 테이블은 자식 테이블을 삭제한 뒤에 삭제 가능하다.
-- 왜? 자식 테이블과 연결된 메인 테이블을 먼저 삭제하면 자식 테이블도 함께 삭제된다.
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS order_item;

CREATE TABLE product (
-- 	기본키라고 해서 AUTO_INCREMENT 사용 가능한 것은 아니다.
--  정수 자료형만 설정 가능하다.
	product_id		VARCHAR(10)		PRIMARY KEY,
    product_name	VARCHAR(100)	NOT NULL,
    price			INT				CONSTRAINT CH_product_price		CHECK(price > 0),
	stock			INT 			DEFAULT 0 			CHECK(stock >= 0),
	status			VARCHAR(20) 	DEFAULT '판매중' 		CONSTRAINT CK_PRODUCT_STATUS 	CHECK(STATUS IN ('판매중', '품절', '단종'))
);

CREATE TABLE order_item (
	order_no		VARCHAR(20),
--  product 테이블 내에 존재하는 컬럼 중 product_id 컬럼명과 연결할 것이다.
--  product_id		VARCHAR(10)		CONSTRAINT ABC		FOREIGN KEY		REFERENCES product(product_id),
	product_id		VARCHAR(10),
    quantity		INT				CHECK(quantity >= 1),
    order_date		TIMESTAMP		DEFAULT CURRENT_TIMESTAMP,

    -- 외래키는 보통 테이블 레벨 형태로 작성한다.
    CONSTRAINT ABC		FOREIGN KEY (product_id)		REFERENCES product(product_id)
);

SELECT * FROM product;
SELECT * FROM order_item;

INSERT INTO PRODUCT VALUES ('P001', '노트북', 1200000, 10, '판매중');
INSERT INTO PRODUCT VALUES ('P002', '마우스', 25000, 50, '판매중');
INSERT INTO PRODUCT VALUES ('P003', '키보드', 80000, 0, '품절');

INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P001', 2, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD001', 'P002', 1, DEFAULT);
INSERT INTO ORDER_ITEM VALUES ('ORD002', 'P002', 3, '2024-03-06 14:30:00');
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);

-- 제품이 존재하고, 제품번호에 따른 주문
INSERT INTO ORDER_ITEM VALUES ('ORD003', 'P999', 1, DEFAULT);
-- 여전히 오류...
-- product 테이블에 존재하지 않는 상품번호 주문이 들어와서 외래키 조건에 위배되는 현상으로 인해 오류 발생한다.




/*
대학교 성적 관리를 위한 테이블들을 생성하세요.

1) STUDENT 테이블:
- STUDENT_ID: 학번 (문자 10자, 기본키)
- STUDENT_NAME: 학생이름 (문자 30자, 필수입력)
- MAJOR: 전공 (문자 50자)
- YEAR: 학년 (숫자, 1~4학년만 가능)
- EMAIL: 이메일 (문자 100자, 중복불가)

2) SUBJECT 테이블:
- SUBJECT_ID: 과목코드 (문자 10자, 기본키)
- SUBJECT_NAME: 과목명 (문자 100자, 필수입력)
- CREDIT: 학점 (숫자, 1~4학점만 가능)

3) SCORE 테이블:
- STUDENT_ID: 학번 (문자 10자)
- SUBJECT_ID: 과목코드 (문자 10자)  
- SCORE: 점수 (숫자, 0~100점만 가능)
- SEMESTER: 학기 (문자 10자, 필수입력)
- SCORE_DATE: 성적입력일 (날짜시간, 기본값은 현재시간)

주의사항:
- SCORE 테이블의 STUDENT_ID는 STUDENT 테이블 참조
- SCORE 테이블의 SUBJECT_ID는 SUBJECT 테이블 참조  
- SCORE 테이블은 (학번 + 과목코드 + 학기) 조합으로 기본키 설정
- 같은 학생이 같은 과목을 같은 학기에 중복으로 수강할 수 없음
*/

CREATE TABLE student (
	student_id		VARCHAR(10)		PRIMARY KEY,
    student_name	VARCHAR(30)		NOT NULL,
    major			VARCHAR(50),
    year			INT 			CHECK(year >= 1 AND year <= 4),
    email			VARCHAR(100)	UNIQUE
);

CREATE TABLE subject (
	subject_id		VARCHAR(10)		PRIMARY KEY,
    subject_name	VARCHAR(100)	NOT NULL,
    credit			INT				CHECK(credit >= 1 AND credit <= 4)
);

CREATE TABLE score (
	student_id		VARCHAR(10),
    subject_id		VARCHAR(10),
    score			INT				CHECK(score >= 0 AND score <= 100),
    semester		VARCHAR(10),
    score_date		TIMESTAMP		DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT PK_score PRIMARY KEY (student_id, subject_id, semester),
    
    CONSTRAINT FK_srore_student_id	FOREIGN KEY (student_id)		REFERENCES student(student_id) ON DELETE SET NULL,
    CONSTRAINT FK_srore_subject_id	FOREIGN KEY (subject_id)		REFERENCES subject(subject_id) ON DELETE SET NULL
);

SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM score;

INSERT INTO STUDENT VALUES ('2024001', '김대학', '컴퓨터공학과', 2, 'kim2024@univ.ac.kr');
INSERT INTO STUDENT VALUES ('2024002', '이공부', '경영학과', 1, 'lee2024@univ.ac.kr');

INSERT INTO SUBJECT VALUES ('CS101', '프로그래밍기초', 3);
INSERT INTO SUBJECT VALUES ('BM201', '경영학원론', 3);
INSERT INTO SUBJECT VALUES ('EN101', '대학영어', 2);

INSERT INTO SCORE VALUES ('2024001', 'CS101', 95, '2024-1학기', DEFAULT);
INSERT INTO SCORE VALUES ('2024001', 'EN101', 88, '2024-1학기', DEFAULT);
INSERT INTO SCORE VALUES ('2024002', 'BM201', 92, '2024-1학기', DEFAULT);

-- 제약조건 위반 테스트
INSERT INTO STUDENT VALUES ('2024003', '박중복', '수학과', 2, 'kim2024@univ.ac.kr');	-- email - UNIQUE 제약 조건 불일치
INSERT INTO SCORE VALUES ('2024001', 'CS101', 150, '2024-1학기', DEFAULT);			-- score - 범위 제약 조건 불일치
INSERT INTO SCORE VALUES ('2024001', 'CS101', 90, '2024-1학기', DEFAULT);			-- PK 중복



-- student 테이블의 이메일 컬럼 중복 불가 설정하기.
ALTER TABLE student
MODIFY email VARCHAR(100) UNIQUE NOT NULL;
-- 만약 변경할 제약 조건에 부합하지 않은 데이터가 존재한다면
-- 우선 해당 데이터를 수정한 다음에 제약 조건을 수정한다.



-- 기존에 존재하는 이메일 데이터 삭제하기.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM student WHERE email = 'kim2024@univ.ac.kr';
-- 특정 학생을 삭제하려고 했지만 score 테이블에 외래키를 참조하고 있어서 함부로 삭제 불가능하다.

-- 방법 1번
-- 삭제하고자 하는 데이터의 하위 데이터에 존재하는 데이터 먼저 삭제 후 부모 데이터 삭제하기.

-- 방법 2번
-- 외래키 제약 조건을 잠시 종료하고 삭제하기.
-- > 데이터 무결성 조건을 해지할 수 있으므로 실제 DB 서비스에서는 사용 금지한다.
SET FOREIGN_KEY_CHECKS = 0;

-- 방법 3번
-- ON DELETE CASCADE
-- 부모 테이블에 존재하는 데이터 삭제 시 자식 테이블 또한 자동적으로 삭제될 수 있도록 설정하는 조건.




