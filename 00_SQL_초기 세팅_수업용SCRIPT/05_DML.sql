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

INSERT INTO member
       VALUES(NULL, 'jane_smith', 'password456', 'jane@example.com', '김영희', '010-9876-5432', '1992-08-20', 'F', '부산시 해운대구', now(), 'ACTIVE');
INSERT INTO member
       VALUES(NULL, 'mike_wilson', 'password789', 'mike@example.com', '이철수', '010-5555-7777', '1988-12-03', 'M', '대구시 중구', now(), 'ACTIVE');
INSERT INTO member
	   VALUES(NULL, 'sarah_lee', 'passwordabc', 'sarah@example.com', '박미영', '010-3333-9999', '1995-03-10', 'F', '광주시 서구', now(), 'ACTIVE');
INSERT INTO member
       VALUES(NULL, 'sarah_lee', 'password123', 'miyoung@example.com', '오미영', '010-3333-9999', '1994-03-10', 'F', '서울시 서초구', now(), 'ACTIVE');


select * FROM member WHERE member_id=2;



/*******************

INSERT 구문 작성법

INSERT INTO 테이블명 
	   VALUES (값, 값, 값, ... ),
			  (값, 값, 값, ... ),
			  (값, 값, 값, ... );
       
,로 구분하여 여러 행을 한 번에 입력하여 데이터 저장 가능하다.
       
*******************/


INSERT INTO member
	   VALUES
       (NULL, 'mini1004', 'pw4567', 'mini1004@example.com', '김미니', '010-1004-1004', '2000-03-29', 'M', '서울시 관악구', now(), 'ACTIVE'),
	   (NULL, 'big1004', 'pw456789', 'big1004@example.com', '김대왕', '010-1005-1005', '1999-03-29', 'M', '서울시 구로구', now(), 'ACTIVE');


/*******************

INSERT 필수 컬럼만 입력
-> 모든 컬럼에 데이터 입력하지 않고, 컬럼명 옆에 NOT NULL인 컬럼명만 지정하여 데이터 입력 가능하다.
   주의!! NOT NULL은 필수로 데이터를 넣어야 하는 공간이기 때문에 생략 불가!!


작성법

INSERT INTO 테이블명 (필수 컬럼명1, 필수 컬럼명2, ... )
	   VALUES (값1, 값2, ... );

INSERT INTO 테이블명 (필수 컬럼명1, 필수 컬럼명2, ... )
	   VALUES (값1, 값2, ... ),
			  (값1, 값2, ... ),
			  (값1, 값2, ... );
       
,로 구분하여 여러 행을 한 번에 입력하여 데이터 저장 가능하다.

AUTO_INCREMENT 설정된 컬럼은 번호가 자동으로 부여될 것이고,
이외 컬럼 값은 모두 NULL 또는 0 값으로 데이터가 추가될 것이다.
여기서 DEFAULT 설정된 데이터는 DEFAULT로 설정된 기본 데이터가 추가될 것이다.
       
*******************/


-- =============================================
-- 실습 문제 1: 필수 컬럼만 INSERT
-- =============================================
-- 문제: 다음 회원들을 필수 컬럼(username, password, email, name)만으로 INSERT하세요.
-- 나머지 컬럼들은 기본값 또는 NULL이 됩니다.

/*
회원1: user_basic1, basicpass123, basic1@email.com, 기본유저1
회원2: user_basic2, basicpass456, basic2@email.com, 기본유저2  
회원3: user_basic3, basicpass789, basic3@email.com, 기본유저3
*/

INSERT INTO member (username, password, email, name)
			values ('user_basic1', 'basicpass123', 'basic1@email.com', '기본유저1');
            
INSERT INTO member (username, password, email, name)
			values ('user_basic2', 'basicpass456', 'basic2@email.com', '기본유저2'),
				   ('user_basic3', 'basicpass789', 'basic3@email.com', '기본유저3');


-- =============================================
-- INSERT INTO 테이블명 (컬럼명, ... ) VALUES (데이터, ... )
-- 특정 컬럼만 지정하여 데이터 저장하기. (필수 + 선택사항)
-- =============================================



INSERT	INTO member (username, password, email, name, phone, gender)
		VALUES ('admin_user', 'admin_pass', 'admin@gmail.com', '관리자', '010-1234-4321', 'M');

/*
컬럼명 순서는 임의로 작성해도 문제 없다.
작성한 값이 해당 컬럼명의 자료형과 크기를 만족한다면 문제 없다.
*/

INSERT	INTO member (password, username, email, phone, name, gender)
		VALUES ('guest_pass1', 'guest_user1', 'guest1@gmail.com', '게스트1', '010-1111-1111', 'F');

INSERT	INTO member (password, username, email, phone, name, gender)
		VALUES ('guest_pass2', 'guest_user2', 'guest2@gmail.com', '010-2222-2222', '게스트2', 'F');
        
SELECT * FROM member;




-- =============================================
-- INSERT 실습문제
-- =============================================

-- 문제 1: 다음 회원 정보를 주어진 컬럼 순서에 맞춰 INSERT하세요.
-- 컬럼 순서: password, username, email, name, phone, gender
-- 회원 데이터: hong123, hong_pass, hong@naver.com, 홍길동, 010-1234-5678, M
INSERT INTO member (password, username, email, name, phone, gender)
		VALUES ('hong_pass', 'hong123', 'hong@naver.com', '홍길동', '010-1234-5678', 'M');


-- 문제 2: 필수 컬럼 4개를 다른 순서로 INSERT하세요.
-- 컬럼 순서: email, name, password, username  
-- 회원 데이터: kim_student, student123, kim@gmail.com, 김영희
INSERT INTO member (email, name, password, username)
		VALUES ('kim@gmail.com', '김영희', 'kim_student', 'student123');


-- 문제 3: 생년월일과 성별을 포함해서 다른 순서로 INSERT하세요
-- 컬럼 순서: birth_date, username, gender, email, name, password
-- 회원 데이터: park_teacher, teacher456, park@daum.net, 박철수, 1985-03-15, M
INSERT INTO member (birth_date, username, gender, email, name, password)
		VALUES ('1985-03-15', 'teacher456', 'M', 'park@daum.net', '박철수', 'park_teacher');


-- 문제 4: 주소를 포함해서 컬럼 순서를 바꿔 INSERT하세요.
-- 컬럼 순서: address, phone, birth_date, gender, name, email, password, username
-- 회원 데이터: lee_manager, manager789, lee@company.co.kr, 이미영, F, 1990-07-20, 010-9876-5432, 서울시 강남구 역삼동
INSERT INTO member (address, phone, birth_date, gender, name, email, password, username)
		VALUES ('서울시 강남구 역삼동', '010-9876-5432', '1990-07-20', 'F', '이미영', 'lee@company.co.kr', 'manager789', 'lee_manager');


-- 문제 5: 회원 상태를 포함해서 INSERT하세요.
-- 컬럼 순서: status, gender, username, password, email, name, phone
-- 회원 데이터: choi_admin, admin999, choi@admin.kr, 최관리, 010-5555-7777, INACTIVE, M
INSERT INTO member (status, gender, username, password, email, name, phone)
		VALUES ('INACTIVE', 'M', 'choi_admin', 'admin999', 'choi@admin.kr', '최관리', '010-5555-7777');


-- 문제 6: 3명의 회원을 각각 다른 컬럼 순서로 한 번에 INSERT하세요.
-- 순서: username, password, email, name, phone, gender
/*
회원1: jung_user1, pass1234, jung1@kakao.com, 정수민, 010-1111-2222, F
회원2: kang_user2, pass5678, kang2@nate.com, 강동원, 010-3333-4444, M  
회원3: yoon_user3, pass9012, yoon3@hanmail.net, 윤서연, 010-5555-6666, F
*/

INSERT INTO member (username, password, email, name, phone, gender)
		VALUES ('jung_user1', 'pass1234', 'jung1@kakao.com', '정수민', '010-1111-2222', 'F'),
        ('kang_user2', 'pass5678', 'kang2@nate.com', '강동원', '010-3333-4444', 'M'),
        ('yoon_user3', 'pass9012', 'yoon3@hanmail.net', '윤서연', '010-5555-6666', 'F');



-- 문제 7: 다음 잘못된 INSERT문을 올바르게 수정하세요.
-- 잘못된 예제 (실행하지 마세요.):
-- INSERT INTO member (username, password, email, name, phone) 
-- VALUES ('010-7777-8888', 'song_user', 'song@lycos.co.kr', 'songpass', '송지효');
 INSERT INTO member (username, password, email, name, phone) 
		VALUES ('song_user', 'songpass', 'song@lycos.co.kr', '송지효', '010-7777-8888');


-- 문제 8: 전화번호와 주소는 제외하고 다른 순서로 INSERT하세요.
-- 컬럼 순서: gender, birth_date, name, email, username, password
-- 회원 데이터: oh_student, student321, oh@snu.ac.kr, 오수진, 1995-12-03, F
INSERT INTO member (gender, birth_date, name, email, username, password)
		VALUES ('F', '1995-12-03', '오수진', 'oh@snu.ac.kr', 'oh_student', 'student321');


-- 문제 9: 모든 컬럼을 포함해서 순서를 바꿔 INSERT하세요.
-- 컬럼 순서: address, status, gender, birth_date, phone, name, email, password, username
-- 회원 데이터: han_ceo, ceo2024, han@bizmail.kr, 한대표, 010-8888-9999, 1975-05-25, M, ACTIVE, 부산시 해운대구 우동
INSERT INTO member (address, status, gender, birth_date, phone, name, email, password, username)
		VALUES ('부산시 해운대구 우동', 'ACTIVE', 'M', '1975-05-25', '010-8888-9999', '한대표', 'han@bizmail.kr', 'ceo2024', 'han_ceo');


-- 문제 10: 5명의 한국 회원을 서로 다른 컬럼 순서로 INSERT하세요.

/*
회원1: 김민수, minsoo_kim, minpass1, minsoo@gmail.com, 010-1010-2020, M
회원2: 이소영, soyoung_lee, sopass2, soyoung@naver.com, 010-3030-4040, F
회원3: 박준혁, junhyuk_park, junpass3, junhyuk@daum.net, 010-5050-6060, M
회원4: 최유진, yujin_choi, yujinpass4, yujin@hanmail.net, 010-7070-8080, F  
회원5: 장태현, taehyun_jang, taepass5, taehyun@korea.kr, 010-9090-1010, M
*/

-- 회원1 순서: name, username, password, email, phone, gender
INSERT INTO member (name, username, password, email, phone, gender)
		VALUES ('김민수', 'minsoo_kim', 'minpass1', 'minsoo@gmail.com', '010-1010-2020', 'M');

-- 회원2 순서: username, gender, email, name, password, phone  
INSERT INTO member (username, gender, email, name, password, phone)
		VALUES ('soyoung_lee', 'F', '010-3030-4040', '이소영', 'sopass2', '010-3030-4040');
        
-- 회원3 순서: email, phone, username, password, name, gender
INSERT INTO member (email, phone, username, password, name, gender)
		VALUES ('junhyuk@daum.net', '010-5050-6060', 'junhyuk_park', 'junpass3', '박준혁', 'M');
        
-- 회원4 순서: gender, name, phone, email, username, password
INSERT INTO member (gender, name, phone, email, username, password)
		VALUES ('F', '최유진', '010-7070-8080', 'yujin@hanmail.net', 'yujin_choi', 'yujinpass4');
        
-- 회원5 순서: phone, email, gender, username, password, name
INSERT INTO member (phone, email, gender, username, password, name)
		VALUES ('010-9090-1010', 'taehyun@korea.kr', 'M', 'taehyun_jang', 'taepass5', '장태현');


/*******************

UPDATE

이미 존재하는 컬럼 값을 수정할 때 사용하는 조작 언어
Error가 거의 일어나지 않는다.
왜?	-> WHERE에 해당하는 조건을 찾고,
		해당하는 조건이 있으면 있는대로
		해당하는 조건이 없으면 없는대로 맞춰 변경하기 때문에...

UPDATE 테이블명
   SET 컬럼명1 = 바꿀값1,
	   컬럼명2 = 바꿀값2,
       ...
   WHERE 조건식;

주의!! WHERE 절이 없으면 해당 테이블의 모든 컬럼 값이
	  한 번에 변경되므로 데이터 유실 발생할 수 있다!!
      모든 데이터를 한 번에 변경하려는 것이 아니라면 WHERE 사용 필수!!
      WHERE 절을 이용해서 특정 컬럼 값만 정확히 변경하는 것이 중요!!

******************/

-- 무사히 변경된다면
-- 1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0	0.0047 sec


UPDATE member
SET phone = '010-1111-9999',
    email = 'hong@hong.hong'
WHERE username = 'hong1234';

-- 존재하지 않은 username을 조건으로 작성해도 에러 발생하지 않는다.
-- 왜? -> 못 찾은 상태 그대로 변경된 데이터가 0으로 조회된다.
-- 0 row(s) affected Rows matched: 0  Changed: 0  Warnings: 0	0.00083 sec

UPDATE member
SET phone = '010-1111-9999'
WHERE username = 'hong1234567890';

SELECT * FROM member WHERE username = 'hong1234';


-- Error Code: 1175;
-- 모든 데이터를 한 번에 수정하거나 삭제하는 것을 방지하기 위한 MySQL 안정 장치!!
-- 안전 모드 비활성화
SET SQL_SAFE_UPDATES = 0;
-- 안전 모드 활성화
SET SQL_SAFE_UPDATES = 1;

UPDATE member
SET join_date = current_timestamp();

SELECT * FROM member;


-- 문제 1: username이 'mike_wilson'인 이철수 회원의 이메일 주소를 'mike.w@naver.com'으로 변경하세요.
UPDATE member
SET email = 'mike.w@naver.com'
WHERE username = 'mike_wilson';

-- 문제 2: member_id가 5번인 회원의 상태(status)를 'SUSPENDED'로, 주소(address)를 '확인 필요'로 변경하세요.
UPDATE member
SET status = 'SUSPENDED',
	email = '확인 필요'
WHERE member_id = '5';

-- 문제 3: 1990년 이전에 태어난 모든 회원의 상태(status)를 'INACTIVE'로 변경하세요.
SET SQL_SAFE_UPDATES = 0;

UPDATE member
SET status = 'INACTIVE'
WHERE birth_date < '1990-01-01';

SET SQL_SAFE_UPDATES = 1;



/*******************

DELETE

테이블의 행을 삭제하는 구문

작성법

DELETE FROM 테이블명 WHERE 조건식;
(만약 WHERE 조건 설정하지 않으면 모든 행이 삭제된다.)


******************/

-- DELETE 작업 전 개발자가 잠시 수행하는 작업 중 하나
-- 가볍게 저용량 테이블을 삭제할 경우 많이 사용한다.



USE delivery_app;
-- 테스트용 테이블 생성하자. (기존 stores 테이블 복사하기.)
CREATE TABLE stores_copy AS SELECT * FROM stores;
-- 테스트용 테이블 조회하자.
SELECT * FROM stores_copy;
-- 테스트용 테이블 삭제하자.
DROP TABLE stores_copy;


INSERT INTO stores_copy
		-- VALUES (NULL, '박말숙치킨', '치킨', '서울시 강남구 99', '02-1234-1234', 4.8, 3000);
		VALUES (default, '박말숙치킨', '치킨', '서울시 강남구 99', '02-1234-1234', 4.8, 3000);
-- AUTO INCREMENT는 NULL 작성 가능해야 하는데 DEFAULT 작성하니까 가능하다네?
-- member 테이블은 null이 되고, stores_copy는 null 안 되네?
-- > member 테이블은 개발자가 CREATE TABLE로 직접 모두 작성해서 만든 SQL 테이블.
-- > stores_copy 테이블은 기존 테이블을 가볍게 복제한 상태.
-- -- > AUTO INCREMENT 같은 상세한 컬럼 설정은 복제 안 된다.
-- -- > 별도로 설정 추가해야 한다.


-- 속성까지 모두 복제하는 방식.
CREATE TABLE stores_copy_2 LIKE stores;
INSERT INTO stores_copy_2 SELECT * FROM stores;

INSERT INTO stores_copy_2
		VALUES (NULL, '박말숙치킨', '치킨', '서울시 강남구 99', '02-1234-1234', 4.8, 3000);
-- 이젠 null 작성 가능하다.
SELECT * FROM stores_copy_2;


-- SQL에서 아무런 설정이 되어있지 않는 상태.
SELECT @sql_mode;





-- stores_copy_2
SELECT * FROM stores_copy_2 WHERE delivery_fee >= 4000;
-- 배달비가 4000 원 이상인 가게들 삭제
DELETE 
FROM stores_copy_2
WHERE delivery_fee >= 4000
OR delivery_fee IS NULL;

-- stores_copy_2 에서 배달비가 4000원 이상인 가게들 모두 삭제
DELETE
FROM stores_copy_2
WHERE delivery_fee >= 4000;

-- stores_copy_2 에서 평점이 4.5 미만이고 카테고리가 치킨인 매장 모두 삭제
DELETE
FROM stores_copy_2
WHERE rating < 4.5
AND category = '치킨';

-- stores_copy_2 에서 전화번호가 NULL 인 매장 삭제
DELETE 
FROM stores_copy_2
WHERE phone IS NULL;

-- stores_copy TABLE 자체 모두 삭제
DROP TABLE stores_copy_2;



CREATE TABLE stores_dev_test LIKE stores;
INSERT INTO stores_dev_test SELECT * FROM stores;
SELECT * FROM stores_dev_test;

-- 매장 번호가 1,2,3인 매장 삭제하기.
DELETE FROM stores_dev_test WHERE id IN (1,2,3);
-- 이름에 치킨 들어가는 매장 삭제하기.
DELETE FROM stores_dev_test WHERE name LIKE '%치킨%';

DROP TABLE stores_dev_test;




