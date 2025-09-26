/********************

DCL
DB 접근 권한을 제어하는 SQL 명령어.
주로 사용자 권한 관리와 보안 설정에 사용된다.

GRANT
사용자에게 특정 권한을 부여할 때 사용한다.

GRANT 권한종류
ON DB명칭.테이블명
TO '사용자'@'호스트' ;


REVOKE
사용자로부터 특정 권한을 회수할 때 사용한다.

REVOKE 권한종류
ON DB명칭.테이블명
FROM '사용자'@'호스트' ;

********************/





CREATE USER 'john'@'localhost' IDENTIFIED BY 'mypassword123';
CREATE USER 'remote_user'@'%' IDENTIFIED BY 'remotepass456';
CREATE USER 'office_user'@'192.168.1.100' IDENTIFIED BY 'officepass';
CREATE USER 'network_user'@'192.168.1.%' IDENTIFIED BY 'networkpass';
CREATE USER 'guest'@'localhost';




-- 5.7 버전은 아래 명령어 가능하지만 8.0 버전 이후부터는 아래 명령어 사용 불가하다.
-- guest 유저에게 어느 범위까지 ip로 접속 가능한 지 반드시 명시해야 한다.
GRANT SELECT ON tje.employees TO 'guest';
-- Error Code: 1410 -> 권한 생성할 수 없다.


-- DATABASE TJE에서 employees 테이블만 SELECT 제공하기.
-- guest에게 SELECT 권한을 부여한다.
GRANT SELECT ON tje.employees TO 'guest'@'localhost';


-- office_user SELECT, INSERT, UPDATE 권한을 동시에 부여한다.
-- 조회, 수정, 저장 가능하지만 삭제 불가능한 유저이다.
GRANT SELECT ON tje.employees TO 'office_user'@'192.168.1.100';


-- network_user에게 SELECT, INSERT, UPDATE 권한을 동시에 부여한다.
-- tje 데이터 베이스에서 모든 테이블에 접근 권한이 있는 유저이다.
-- 조회, 수정, 저장 가능하지만 삭제 불가능한 유저이다.
GRANT SELECT ON tje.* TO 'network_user'@'192.168.1.%';


-- remote_user에게 모든 권한을 부여한다.
-- 모든 데이터 베이스의 모든 테이블의 접근 권한이 있는 유저이다.
-- 조회, 수정, 저장, 삭제까지 모든게 가능한 유저이다.
GRANT ALL privileges ON *.* TO 'remote_user'@'%';


-- 모든 권한을 부여한 후 권한 적용을 안 하면 부여한 권한이 의미 없어진다.



-- 권환 회수
REVOKE SELECT ON tje.employees FROM 'guest'@'localhost';
REVOKE SELECT ON tje.employees FROM 'office_user'@'192.168.1.100';
REVOKE SELECT ON tje.* FROM 'network_user'@'192.168.1.%';
REVOKE SELECT ON *.* FROM 'remote_user'@'%';



















