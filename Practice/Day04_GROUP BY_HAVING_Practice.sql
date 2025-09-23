USE delivery_db;
SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM menus;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM reviews;
SELECT * FROM stores;

-- 문제 1
-- CUSTOMERS 테이블에서 고객명과 이메일 길이를 조회하고, 이메일 길이를 기준으로 내림차순 정렬하시오.
SELECT customer_name 고객명, email 이메일, length(email) '이메일 길이'
FROM customers
ORDER BY `이메일 길이` DESC;

-- 문제 2
-- STORES 테이블에서 가게명의 길이가 10자 이상인 가게들의 이름과 글자 수를 조회하시오.
SELECT store_name 가게명, length(store_name) '글자 수'
FROM stores
WHERE length(store_name) >= 10;

-- 문제 3
-- CUSTOMERS 테이블에서 이메일에서 '@' 문자의 위치를 찾아 고객명, 이메일, '@위치'로 조회하시오.
SELECT customer_name 고객명, email 이메일, locate('@', email) '@위치'
FROM customers;

-- 문제 4
-- CUSTOMERS 테이블에서 고객명, 이메일에서 아이디 부분만 추출하여 '이메일 아이디'라는 별칭으로 조회하시오.
SELECT customer_name 고객명, email 이메일, substring(email, 1, locate('@', email)-1) '이메일 아이디'
FROM customers;

-- 문제 5
-- CUSTOMERS 테이블에서 고객명, 이메일 아이디, 이메일 도메인을 각각 분리하여 조회하시오.
SELECT customer_name 고객명, email 이메일, substring(email, locate('@', email)+1) '이메일 도메인'
FROM customers;

/*
명칭에 is를 앞에 붙이는 것은 Boolean 값을 의미한다.
SQL, Java, JavaScript, Python 등 어떤 언어에서든 개발자들이 많이 활용하는 변수명 방식이다.
*/

-- 문제 6
-- MENUS 테이블에서 메뉴명에 '치킨'이라는 단어가 포함된 메뉴들을 조회하고, '치킨'을 'Chicken'으로 변경한 결과도 함께 보여주시오.
SELECT menu_id 메뉴번호, store_id 가게번호, menu_name 메뉴명, replace(description, '치킨', 'chicken') 설명, price 가격
FROM menus
WHERE locate('치킨', description) > 0;

-- 문제 7
-- STORES 테이블에서 가게명에 '점'을 'Store'로 바꾸어 조회하시오. (기존명, 변경명)
-- SELECT store_name 기존명, replace(store_name, '점', 'Store') 변경명
/*
regexp_replace()는 정규식을 이용해서 특정 명칭을 변경한다.
OO$ : OO단어 마지막으로 조회되는 단어(글자?)만 변경한다.
^OO : OO단어 시작으로 조회되는 단어만 변경한다.
*/
SELECT store_name 기존명, regexp_replace(store_name, '점$', 'Store') 변경명
FROM stores;

-- 문제 8
-- MENUS 테이블에서 가격을 1000으로 나눈 나머지를 구하여 메뉴명, 가격, 나머지를 조회하시오.
SELECT menu_name 메뉴명, price 가격, mod(price, 1000) 나머지
FROM menus
WHERE mod(price, 1000) != 0;

-- 문제 9
-- ORDERS 테이블에서 총 가격의 절댓값을 구하여 주문번호, 총가격, 절댓값을 조회하시오.
SELECT order_date 주문번호, total_price 총가격, abs(total_price) 절댓값
FROM orders;

-- 문제 10
-- MENUS 테이블에서 가격을 1000으로 나눈 몫을 올림, 내림, 반올림하여 비교해보시오.
SELECT menu_name 메뉴명, ceil(price/1000) 올림, floor(price/1000) 내림, round(price/1000) 반올림
FROM menus;

-- 문제 11
-- STORES 테이블에서 평점을 소수점 첫째 자리까지, 배달비를 백의 자리에서 반올림하여 조회하시오.
SELECT store_name 가게명, round(rating, 1) 평점, round(delivery_fee,-3) 배달비
FROM stores;

-- 문제 12
-- MENUS 테이블에서 가격이 10000원 이상인 메뉴들의 가격을 천 원 단위로 반올림하여 조회하시오.
SELECT menu_name 메뉴명, round(price, -3) 가격
FROM menus
WHERE price > 10000;

-- 문제 13
-- ORDERS 테이블에서 고객 ID가 짝수인 주문들의 정보를 조회하시오. (MOD 함수 사용)
SELECT *
FROM orders
WHERE mod(customer_id, 2) = 0;

-- 문제 14
-- STORES 테이블에서 최소 주문금액을 만 원 단위로 올림하여 조회하시오.
SELECT store_name 가게명, round(min_order_amount, -4) 최소주문금액
FROM stores;

-- 문제 15
-- MENUS 테이블에서 인기메뉴 여부를 숫자로 변환하여 조회하시오. (TRUE=1, FALSE=0)
SELECT menu_name 메뉴명, is_popular 인기메뉴여부
FROM menus;

-- 문제 16
-- 전체 주문의 총 주문금액 합계를 구하시오.
SELECT sum(total_price) '총 주문금액'
FROM orders;

-- 문제 17
-- 배달 완료된 주문들의 평균 주문금액을 구하시오. (소수점 내림 처리)
SELECT floor(avg(total_price)) '평균 주문금액'
FROM orders
WHERE order_status = 'delivered';

-- 문제 18
-- 가장 비싼 메뉴 가격과 가장 저렴한 메뉴 가격을 조회하시오.
SELECT MAX(price) '젤 비싼 메뉴', MIN(price) '젤 싼 메뉴'
FROM menus; 

-- 문제 19
-- 전체 고객 수와 전화번호가 등록된 고객 수를 각각 구하시오.
SELECT count(customer_id) '전체 고객 수', count(phone) '전화번호 수'
FROM customers;

-- 문제 20
-- 카테고리별로 중복을 제거한 가게 수를 조회하시오.
SELECT C.category_id '카테고리', count(distinct S.store_id) '가게 수'
FROM categories C
JOIN stores S
ON C.category_id = S.category_id
GROUP BY C.category_name;

-- 문제 21
-- 가게별로 메뉴 개수와 평균 메뉴 가격을 조회하시오. (가게명 포함)
SELECT S.store_name '가게명', count(M.menu_id) '메뉴 개수', floor(avg(M.price)) '평균 메뉴 가격'
FROM stores S
JOIN menus M
ON S.store_id = M.store_id
GROUP BY S.store_id, '가게명';

-- 문제 22
-- 카테고리별로 가게 수, 평균 평점, 평균 배달비를 조회하시오. (배달비가 NULL이 아닌 경우만)
SELECT C.category_name '카테고리', count(S.store_id) '가게 수', round(avg(S.rating),1) '평균 평점', floor(avg(S.delivery_fee)) '평균 배달비'
FROM categories C
JOIN stores S
ON C.category_id = S.category_id
WHERE S.delivery_fee IS NOT NULL
GROUP BY category_name;

-- 문제 23
-- 고객별로 총 주문 횟수와 총 주문금액을 조회하시오. (고객명 포함)
SELECT C.customer_id '고객번호', C.customer_name '고객명', count(O.order_id) '총 주문 수', sum(O.total_price) '총 주문금액'
FROM customers C
JOIN orders O
ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.customer_name;

-- 문제 24
-- 주문 상태별로 주문 건수와 평균 주문금액을 조회하시오.
SELECT order_status '주문 상태', count(order_id) '주문 건수', floor(avg(total_price)) '평균 주문금액'
FROM orders
GROUP BY `주문 상태`;

-- 문제 25
-- 가게별 인기메뉴 개수와 일반메뉴 개수를 각각 구하시오.
SELECT S.store_id '가게번호', S.store_name '가게명', sum(M.is_popular) '인기 메뉴 개수', count(*) - sum(M.is_popular) '일반 메뉴 개수'
FROM stores S
JOIN menus M
ON S.store_id = M.store_id
GROUP BY S.store_id, S.store_name;

-- 문제 26
-- 메뉴가 3개 이상인 가게들의 가게명과 메뉴 개수를 조회하시오.
SELECT S.store_id '가게번호', S.store_name '가게명', count(M.menu_id) '메뉴 개수'
FROM stores S
JOIN menus M
ON S.store_id = M.store_id
GROUP BY S.store_id, S.store_name
HAVING count(M.menu_id) >= 3;

-- 문제 27
-- 평균 메뉴 가격이 15000원 이상인 가게들을 조회하시오. (가게명, 평균가격)
SELECT S.store_id '가게번호', S.store_name '가게명', floor(avg(price)) '평균 메뉴 가격'
FROM stores S
JOIN menus M
ON S.store_id = M.store_id
GROUP BY S.store_id, S.store_name
HAVING floor(avg(price)) >= 15000;

-- 문제 28
-- 총 주문금액이 30000원 이상인 고객들의 고객명과 총 주문금액을 조회하시오.
SELECT C.customer_id '고객번호', C.customer_name '고객명', sum(O.total_price) '총 주문금액'
FROM customers C
JOIN orders O
ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.customer_name
HAVING sum(O.total_price) >= 30000;

SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM menus;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM reviews;
SELECT * FROM stores;

-- 문제 29
-- 배달비 평균이 3500원 이상인 카테고리들을 조회하시오. (배달비가 NULL이 아닌 경우만)
SELECT C.category_id '카테고리', C.category_name '카테고리명', floor(avg(S.delivery_fee)) '평균 배달비'
FROM categories C
JOIN stores S
ON C.category_id = S.category_id
WHERE S.delivery_fee IS NOT NULL
GROUP BY C.category_id, C.category_name
HAVING floor(avg(S.delivery_fee)) > 3500;

-- 문제 30
-- 주문 건수가 2건 이상인 주문 상태들과 해당 건수, 총 주문금액을 조회하시오. 총 주문금액 기준으로 내림차순 정렬하시오.
SELECT order_status '주문 상태', count(order_id) '주문 건수', sum(total_price) '총 주문금액'
FROM orders
GROUP BY `주문 상태`
HAVING `주문 건` >= 2;






