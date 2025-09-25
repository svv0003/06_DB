
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


CREATE TABLE events (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL 
);

CREATE TABLE attendees (
    attendee_id INT PRIMARY KEY AUTO_INCREMENT,
    attendee_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    attendee_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (attendee_id) REFERENCES attendees(attendee_id)
);

INSERT INTO events (event_name, total_seats, available_seats) 
VALUES ('SQL 마스터 클래스', 100, 2); 


START transaction;
-- 이제부터 수동 저장

INSERT INTO attendees
VALUES (1, '김철수', 'chulsoo@gmail.com');

UPDATE events
SET available_seats = available_seats - 1
WHERE event_id = 1;

-- 주의
-- SELECT에서 데이터가 제대로 보이더라도 COMMIT이 무조건 완성된 것이 아니다.
-- SQL에서 보이더라도 자동 커밋이 아닌 경우에는 Java에서 데이터를 불러오기 했을 때 저장된 데이터를 불러오지 않을 수도 있다.
-- 지금 DB 자체가 아니라 DB에 데이터를 명시하는 Schemas 명세상태이다.
-- Java는 Schemas가 아니라 DB랑 상호소통한다.

-- 최종 내역 젖아하기.
INSERT INTO bookings (event_id, attendee_id)
VALUES (1, 1);

COMMIT;

SELECT * FROM attendees;
SELECT * FROM events;
SELECT * FROM bookings;


-- Ctrl + S		저장과 동시에 COMMIT 상태로 저장된다.
-- 다른 사람이 시도하지만 좌석이 없어서 실패한다면
-- rollback;
START transaction;			-- COMMIT 하기 전까지 유효한다.
							-- 어디부터 어디까지 흐름 추적하고, 저장 완료되면 추적 중단하겠다.
INSERT INTO attendees VALUES (2, '박영희', 'hee.park@gmail.com');
SELECT * FROM attendees;
rollback;


-- 외래키를 사용하는 테이블부터 삭제해주기.
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS attendees;


-- 일부만 성공한 savepoint
-- 담당자가 두 사람의 예약을 동시에 진행하지만 좌석은 하나 뿐이라 둘 중 한 명은 실패한다면
-- 둘 중 한 명이 예약 성공하면 savepoint 중간 저장하고,
-- 나머지 한 명이 예약 실패하면 savepoint로 되돌아가서 한 명이라도 예약하기.
START transaction;
INSERT INTO attendees VALUES (3, '이민준', 'jun@gmail.com');
SELECT * FROM attendees;
UPDATE events
	SET available_seats = available_seats - 1
	WHERE event_id = 1;
INSERT INTO bookings (event_id, attendee_id) VALUES (1, 3);
SAVEPOINT booking_joon_success;

INSERT INTO attendees VALUES (4, '최지아', 'jia@gmail.com');
-- 만약 예약 꽉 차서 불가능하다면 되돌아가기.
SELECT * FROM attendees;
ROLLBACK TO SAVEPOINT booking_joon_success;

COMMIT;
-- 결과 : 이민준 예약은 완료되었지만 최지아의 정보는 롤백되어 남아있지 않는다.
