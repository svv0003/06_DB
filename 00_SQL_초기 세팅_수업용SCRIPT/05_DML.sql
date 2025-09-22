/*******************
DQL	(Data Query Language)			데이터 조회		SELECT 	데이터 조회
DML	(Data Manupulation Language)	데이터 조작		INSERT	데이터 삽입
													UPDATE	데이터 갱신
													DELETE	데이터 삭제
DDL	(Data Definition Language)		데이터 구조 정의	CREATE	객체 생성 
													ALTER	객체 수정
													DROP	객체 삭제
DCL	(Data Control Language)			데이터 권한 관리	GRANT
													REVOKE
TCL	(Transaction Control Language)	트랜잭션 관리		COMMIT



DML		데이터 조작 언어
		데이터에 값을 삽입, 수정, 삭제, 조회하는 구문
        주의!! COMMIT, ROLLBACK을 실무에서 혼자 하지 말 것!!

*******************/

CREATE TABLE member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    gender ENUM('M', 'F', 'Other'),
    address TEXT,
    join_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') DEFAULT 'ACTIVE'
);

SELECT * FROM member;

/*******************

INSERT 구문 작성법

INSERT INTO 테이블명 
VALUES (값, 값, 값, ... )

모든 컬럼에 대한 값을 넣을 대는 컬럼명을 생략하고, 순서대로 VALUES에 추가할 데이터를 작성한다.

*******************/

-- 모든 컬럼에 대한 값을 저장하기. (AUTO_INCREMENT 제외)
INSERT INTO member
		VALUES (
        NULL, 				# member_id		(AUTO_INCREMENT이므로 NULL)
        'hong1234',			# username 		닉네임
        'pass1234',			# password		비밀번호
        'hong@gil.com',		# email 		이메일
        '홍길동',				# name 			이름
        '010-1234-1234',	# phone 		연락처
        '2000-01-01',		# birth_date 	생년월일
        'M',				# gender 		성별
        '서울시 관악구',		# address 		주소
        NOW(),				# join_date 	가입일자 -> 현재시간 기준
        'Active'			# status 		탈퇴, 휴먼계정 여부
        );

SELECT * FROM member;


-- =============================================
-- 실습 문제 1: 기본 INSERT 구문
-- =============================================
-- 문제: 다음 회원 정보들을 한 번에 INSERT하세요.
/*
회원1: jane_smith, password456, jane@example.com, 김영희, 010-9876-5432, 1992-08-20, F, 부산시 해운대구, 현재시간, ACTIVE
회원2: mike_wilson, password789, mike@example.com, 이철수, 010-5555-7777, 1988-12-03, M, 대구시 중구, 현재시간, ACTIVE  
회원3: sarah_lee, passwordabc, sarah@example.com, 박미영, 010-3333-9999, 1995-03-10, F, 광주시 서구, 현재시간, INACTIVE
*/

INSERT INTO member VALUES(NULL, 'jane_smith', 'password456', 'jane@example.com', '김영희', '010-9876-5432', '1992-08-20', 'F', '부산시 해운대구', now(), 'ACTIVE');
INSERT INTO member VALUES(NULL, 'mike_wilson', 'password789', 'mike@example.com', '이철수', '010-5555-7777', '1988-12-03', 'M', '대구시 중구', now(), 'ACTIVE');
INSERT INTO member VALUES(NULL, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'F', '광주시 서구', now(), 'ACTIVE');



















