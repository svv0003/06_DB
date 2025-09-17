use chun_university;

SELECT *
FROM student;

-- Q1. 문제: STUDENT 테이블에서 학생 이름의 길이가 3글자인 학생의 학번, 이름을 조회하시오.
-- 힌트: LENGTH(컬럼명) 함수 사용
-- WHERE 절에 LENGTH(STUDENT_NAME) = 3 조건 추가
SELECT student_no, student_name
FROM student
WHERE length(student_name) = 3;


-- Q2. 문제: STUDENT 테이블에서 주민등록번호 앞 6자리를 생년월일로 하여
-- 학번, 이름, 생년월일을 조회하시오. (별칭: 생년월일)
-- 힌트: SUBSTRING(문자열, 시작위치, 길이) 사용
-- 주민번호 형태: YYMMDD-XXXXXXX, 앞 6자리 추출
SELECT student_no, student_name, substring(student_ssn, 1, 6) 생년월일
FROM student;


-- Q3. 문제: DEPARTMENT 테이블에서 학과명에 '학과'를 '전공'으로 바꾼 결과를
-- 학과번호, 기존학과명, 변경학과명으로 조회하시오.
-- 힌트: REPLACE(문자열, 찾을문자열, 바꿀문자열) 사용
SELECT department_no 학과번호, department_name 기존학과명, replace(department_name, '학과', '전공') 변경학과명 
FROM department;


-- Q4. 문제: STUDENT 테이블에서 주민등록번호에서 '-' 문자의 위치를 찾아
-- 성별구분번호(주민등록번호 뒷자리 첫 번째 숫자)를 추출하여
-- 학번, 이름, 성별구분번호를 조회하시오.
-- 힌트: LOCATE('-', 주민번호)로 '-' 위치 찾기
-- SUBSTRING(주민번호, LOCATE('-', 주민번호) + 1, 1)로 성별구분번호 추출
SELECT student_no 학번, student_name 이름, substring(student_ssn, locate('-', student_ssn)+1, 1) 성별구분번호
FROM student;


-- Q5. 문제: GRADE 테이블에서 모든 학점을 소수점 첫째자리까지 반올림하여
-- 학기번호, 과목번호, 학번, 반올림학점으로 조회하시오.
-- 힌트: ROUND(숫자, 자릿수) 사용, 첫째자리는 1
SELECT term_no 학기번호, class_no 과목번호, student_no 학번, round(point, 1) 반올림학점
FROM grade;


-- Q6. 문제: STUDENT 테이블에서 학번의 마지막 숫자가 짝수인 학생들의 학번, 이름을 조회하시오.
-- 힌트: SUBSTRING(학번, -1, 1)로 마지막 글자 추출
-- MOD(숫자, 2) = 0으로 짝수 판별
SELECT student_no 학번, student_name 이름, student_ssn 주민등록번호
FROM student
WHERE mod(substring(student_ssn, -1, 1), 2) = 0;


-- Q7. 문제: PROFESSOR 테이블에서 교수 이름의 성(첫 글자)과 이름 길이를 조회하시오.
-- 출력 형태: 교수번호, 교수명, 성, 이름길이
-- 힌트: SUBSTRING(이름, 1, 1)로 첫 글자 추출
-- LENGTH(이름)로 길이 계산
SELECT professor_no 교수번호, professor_name 교수명, substring(professor_name, 1, 1) 성, length(professor_name) '이름 길이'
FROM professor;


-- Q8. 문제: STUDENT 테이블에서 주민등록번호를 이용해 성별을 구분하여
-- 학번, 이름, 성별(남/여)을 조회하시오.
-- (힌트: 성별구분번호가 1,3이면 '남', 2,4이면 '여')
-- 힌트: 서브쿼리나 조건문 없이 단순한 방법 사용
-- 성별구분번호를 먼저 확인해보고 직접 조건 작성
SELECT student_no 학번, student_name 이름, substring(student_ssn, locate('-', student_ssn)+1, 1) '성별(남/여)'
FROM student;


-- Q9. 문제: CLASS 테이블에서 과목번호 길이를 확인하고 현재 형태를 조회하시오.
-- 출력: 과목번호, 과목번호길이, 과목명
-- 힌트: LENGTH() 함수로 현재 과목번호의 길이 확인
SELECT class_no 과목번호, length(class_no) 과목번호길이, class_name 과목명
FROM class;


-- Q10. 문제: DEPARTMENT 테이블에서 학과명의 첫 두 글자를 추출하여 조회하시오.
-- 출력: 학과번호, 학과명, 첫두글자
-- 힌트: SUBSTRING(학과명, 1, 2)로 첫 두글자 추출
SELECT department_no 학과번호, department_name 학과명, substring(department_name, 1, 2) '첫 두 글자'
FROM department;


-- Q11. 문제: 전체 학생 수를 조회하시오.
-- 출력: 전체학생수
-- 힌트: COUNT(*) 사용
SELECT count(*) 전체학생수
FROM student;


-- Q12. 문제: 휴학생 수를 조회하시오.
-- 출력: 휴학생수
-- 힌트: WHERE ABSENCE_YN = 'Y' 조건 사용
SELECT count(*)
FROM student
WHERE ABSENCE_YN = 'Y';

SELECT *
FROM class;
-- Q13. 문제: 학과별 학생 수를 조회하시오.
-- 출력: 학과번호, 학과별학생수 (학생수 기준 내림차순 정렬)
-- 힌트: GROUP BY 학과번호, ORDER BY COUNT(*) DESC
SELECT C.department_no 학과번호, count(*) 학과별학생수
FROM student S
JOIN class C
ON S.department_no = C.department_no
GROUP BY 학과번호
ORDER BY 학과별학생수 DESC;


-- Q14. 문제: 전체 학생의 성적에서 최고점, 최저점, 평균점수를 조회하시오.
-- 출력: 최고점, 최저점, 평균점수(소수점 2자리까지)
-- 힌트: MAX(), MIN(), ROUND(AVG(), 2) 함수 활용
SELECT * FROM student;
SELECT * FROM grade;
SELECT max(point) 최고점, min(point) 최저점, round(avg(point),2) 평균점수
FROM grade;


-- Q15. 문제: 학과 분류(CATEGORY)별로 정원(CAPACITY)의 합계와 평균을 조회하시오.
-- 출력: 학과분류, 정원합계, 정원평균 (정원평균 기준 내림차순 정렬)
-- 힌트: GROUP BY CATEGORY, SUM(), AVG() 사용
SELECT * FROM student;
SELECT * FROM grade;
SELECT * FROM class;
SELECT * FROM professor;
SELECT * FROM department;



SELECT
    CATEGORY,                    -- 학과 분류 출력
    SUM(CAPACITY) AS 정원합계,    -- 정원 합계 계산
    AVG(CAPACITY) AS 정원평균     -- 정원 평균 계산
FROM DEPARTMENT
GROUP BY CATEGORY              -- 학과 분류별로 그룹화
ORDER BY AVG(CAPACITY) DESC;   -- 정원평균 기준 내림차순



-- Q16. 문제: 2005년도에 입학한 학생들을 학과별로 그룹화하여 학과번호, 학생수를 조회하시오.

-- 힌트: WHERE YEAR(ENTRANCE_DATE) = 2005, GROUP BY DEPARTMENT_NO
SELECT
    DEPARTMENT_NO,      -- 학과번호 출력
    COUNT(*) AS 학생수   -- 학생 수 계산
FROM STUDENT
WHERE YEAR(ENTRANCE_DATE) = 2005  -- 2005년 입학 조건
GROUP BY DEPARTMENT_NO;           -- 학과번호별로 그룹화



-- Q17. 문제: 과목별 평균 성적을 조회하시오.
-- 출력: 과목번호, 평균성적 (평균성적 기준 내림차순 정렬)

-- 힌트: GROUP BY CLASS_NO, ORDER BY AVG(POINT) DESC
SELECT
    CLASS_NO,                   -- 과목번호 출력
    AVG(POINT) AS 평균성적       -- 평균 성적 계산
FROM GRADE
GROUP BY CLASS_NO              -- 과목번호별로 그룹화
ORDER BY AVG(POINT) DESC;      -- 평균성적 기준 내림차순




-- Q18. 문제: 학기별, 과목별 수강 학생 수와 평균 성적을 조회하시오.
-- 출력: 학기번호, 과목번호, 수강학생수, 평균성적 (학기번호, 평균성적 기준 정렬)

-- 힌트: GROUP BY TERM_NO, CLASS_NO, ORDER BY TERM_NO, AVG(POINT)
SELECT
    TERM_NO,                    -- 학기번호 출력
    CLASS_NO,                   -- 과목번호 출력
    COUNT(*) AS 수강학생수,      -- 수강 학생 수 계산
    AVG(POINT) AS 평균성적       -- 평균 성적 계산
FROM GRADE
GROUP BY TERM_NO, CLASS_NO     -- 학기별, 과목별 그룹화
ORDER BY TERM_NO, AVG(POINT); -- 학기번호, 평균성적 순 정렬




-- Q19. 문제: CLASS_PROFESSOR 테이블에서 전체 교수가 담당하는 서로 다른 과목의 수를 조회하시오.

-- 힌트: COUNT(DISTINCT CLASS_NO) 사용
SELECT
    COUNT(DISTINCT CLASS_NO) AS 담당과목수  -- 서로 다른 과목 수 계산
FROM CLASS_PROFESSOR;



-- Q20. 문제: 교수별로 지도하는 학생 수를 조회하시오.
-- 출력: 교수번호, 지도학생수 (지도학생수 기준 내림차순 정렬)

-- 힌트: WHERE COACH_PROFESSOR_NO IS NOT NULL
-- GROUP BY COACH_PROFESSOR_NO, ORDER BY COUNT(*) DESC
SELECT
    COACH_PROFESSOR_NO AS 교수번호,    -- 교수번호 출력
    COUNT(*) AS 지도학생수             -- 지도 학생 수 계산
FROM STUDENT
WHERE COACH_PROFESSOR_NO IS NOT NULL  -- 지도교수가 있는 학생만
GROUP BY COACH_PROFESSOR_NO           -- 교수번호별로 그룹화
ORDER BY COUNT(*) DESC;               -- 지도학생수 기준 내림차순
