/****************************

SUBQUERY (서브쿼리)

하나의 SQL 문 안에 포함된 또다른 SQL 문.
메인쿼리 (기존 쿼리)를 위한 보조 역할을 하는 쿼리.
- SELECT, FROM, WHERE, HAVING 절에서 사용 가능하다.

****************************/

USE delivery_app;
SELECT * FROM stores;

/****************************

1. 기본 단일행 서브쿼리

****************************/

-- 가장 비싼 메뉴 찾기.
SELECT max(price) '가장 비싼 메뉴'
FROM menus;
-- 해당 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = 38900;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name, price
FROM menus
WHERE price = (SELECT max(price) '가장 비싼 메뉴' FROM menus);

-- 평균 가격 찾기.
SELECT floor(avg(price))
FROM menus;
-- 해당 메뉴 찾기.
SELECT name, price
FROM menus
WHERE price > 15221;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name, price
FROM menus
WHERE price > (SELECT floor(avg(price)) FROM menus);


-- 최고 평점 찾기.
SELECT max(rating)
FROM stores;
-- 해당 매장 찾기.
SELECT name '가게명', rating '평점'
FROM stores
WHERE rating = 4.9;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name '가게명', rating '평점'
FROM stores
WHERE rating = (SELECT max(rating) FROM stores);


-- 가장 비싼 배달비 찾기.
SELECT max(delivery_fee)
FROM stores;
-- 해당 매장 찾기.
SELECT name '가게명', delivery_fee '배달'
FROM stores
WHERE delivery_fee = 5500;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name '가게명', delivery_fee '배달'
FROM stores
WHERE delivery_fee = (SELECT max(delivery_fee) FROM stores);




-- 문제1: 가장 싼 메뉴 찾기
SELECT min(price) '가장 싼 메뉴'
FROM menus;
-- 해당 메뉴 찾기
SELECT name, price
FROM menus
WHERE price = 1500;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name, price
FROM menus
WHERE price = (SELECT min(price) '가장 싼 메뉴' FROM menus);


-- 문제2: 평점이 가장 낮은 매장 찾기 (NULL 제외)
SELECT min(rating)
FROM stores
WHERE rating IS NOT NULL;
-- 해당 매장 찾기.
SELECT name '가게명', rating '평점'
FROM stores
WHERE rating = 4.2;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name '가게명', rating '평점'
FROM stores
WHERE rating = (SELECT min(rating) FROM stores WHERE rating IS NOT NULL );


-- 문제3: 배달비가 가장 저렴한 매장 찾기 (NULL 제외)
SELECT min(delivery_fee)
FROM stores
WHERE delivery_fee IS NOT NULL;
-- 해당 매장 찾기.
SELECT name '가게명', delivery_fee '배달비'
FROM stores
WHERE delivery_fee = 4.2;
-- 위 내용을 조합하여 한 번에 진행하기.
SELECT name '가게명', delivery_fee '배달비'
FROM stores
WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores WHERE rating IS NOT NULL );


-- 문제4: 평균 평점보다 높은 매장들 찾기
-- 1단계: 전체 매장 평균 평점 구하기
SELECT round(avg(rating),2)
FROM stores;
-- 2단계: 평균보다 높은 평점의 매장들 찾기 (매장명, 평점, 카테고리)
SELECT name 가게명, rating 평점, category 카테고리 
FROM stores
where rating > 4.67;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 가게명, rating 평점, category 카테고리 
FROM stores
where rating > (SELECT round(avg(rating), 2) FROM stores);


-- 문제5: 평균 배달비보다 저렴한 매장들 찾기 (NULL 제외)
-- 1단계: 전체 매장 평균 배달비 구하기
SELECT floor(avg(delivery_fee))
FROM stores;
-- 2단계: 평균보다 저렴한 배달비의 매장들 찾기 (매장명, 배달비, 카테고리)
SELECT name 가게명, delivery_fee 배달비, category 카테고리
FROM stores
where delivery_fee < 3179;
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 가게명, delivery_fee 배달비, category 카테고리
FROM stores
where delivery_fee < (SELECT floor(avg(delivery_fee)) FROM stores);


-- 문제6: 치킨집 중에서 평점이 가장 높은 곳
-- 1단계: 치킨집들의 최고 평점 찾기
SELECT max(rating)
FROM stores
WHERE category = '치킨';
-- 2단계: 치킨집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT name 매장명, rating 평점, address 주소
FROM stores
WHERE rating = 4.9 AND category = '치킨';
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 매장명, rating 평점, address 주소
FROM stores
WHERE rating = (SELECT max(rating) FROM stores WHERE category = '치킨')
AND category = '치킨';


-- 문제7: 치킨집 중에서 배달비가 가장 저렴한 곳 (NULL 제외)
-- 1단계: 치킨집들의 최저 배달비 찾기
SELECT min(delivery_fee)
FROM stores
WHERE category = '치킨' and delivery_fee IS NOT NULL;
-- 2단계: 치킨집 중 그 배달비인 매장 찾기 (매장명, 배달비)
SELECT name 매장명, delivery_fee 배달비
FROM stores
WHERE delivery_fee = 2000 AND category = '치킨';
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 매장명, delivery_fee 배달비
FROM stores
WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores WHERE category = '치킨' and delivery_fee IS NOT NULL)
AND category = '치킨';


-- 문제8: 중식집 중에서 평점이 가장 높은 곳
SELECT * FROM stores;
-- 1단계: 중식집들의 최고 평점 찾기
SELECT max(rating)
FROM stores
WHERE category = '중식';
-- 2단계: 중식집 중 그 평점인 매장 찾기 (매장명, 평점, 주소)
SELECT name 매장명, rating 평점, address 주소
FROM stores
WHERE rating = 4.7 AND category = '중식';
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 매장명, rating 평점, address 주소
FROM stores
WHERE rating = (SELECT max(rating) FROM stores WHERE category = '중식')
AND category = '중식';


-- 문제9: 피자집들의 평균 평점보다 높은 치킨집들
-- 1단계: 피자집들의 평균 평점 구하기
SELECT round(avg(rating), 2)
FROM stores
WHERE category = '피자';
-- 2단계: 그보다 높은 평점의 치킨집들 찾기 (매장명, 평점)
SELECT name 매장명, rating 평점
FROM stores
WHERE rating > 4.70 AND category = '피자';
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 매장명, rating 평점
FROM stores
WHERE rating > (SELECT round(avg(rating), 2) FROM stores WHERE category = '피자')
AND category = '피자';


-- 문제10: 한식집들의 평균 배달비보다 저렴한 일식집들 (NULL 제외)
-- 1단계: 한식집들의 평균 배달비 구하기
SELECT floor(avg(delivery_fee)) '평균 배달비'
FROM stores
WHERE category = '한식';
-- 2단계: 그보다 저렴한 배달비의 일식집들 찾기 (매장명, 배달비)
SELECT name 매장명, delivery_fee 배달비
FROM stores
WHERE delivery_fee < 3200 AND category = '한식';
-- 조합 : 1단계 2단계를 조합하여 한 번에 조회하기
SELECT name 매장명, delivery_fee 배달비
FROM stores
WHERE delivery_fee < (SELECT floor(avg(delivery_fee)) '평균 배달비' FROM stores WHERE category = '한식')
AND category = '한식';



/****************************

2. 다중행 서브쿼리 (Multi Row SubQuery)

IN / NOT IN
> ANY / < ANY
> ALL / < ALL
EXISTS / NOT EXISTS

주요 연산자 : IN, NOT IN, ANY, ALL, EXISTS

****************************/

/****************************
IN 연산자 : 가장 많이 사용되는 다중행 서브쿼리
****************************/

-- 인기 메뉴가 있는 매장 조회하기.
-- 1단계 : 인기 메뉴 있는 매장 ID 확인하기.
SELECT distinct store_id
FROM menus
WHERE is_popular = TRUE;
-- 2단계 : 인기있는 매장 ID에 해당하는 매장 정보 찾기.
SELECT name, category, rating
FROM stores
where id IN (SELECT distinct store_id FROM menus WHERE is_popular = TRUE);

SELECT distinct s.name, s.category, s.rating, s.id, m.store_id
FROM stores s
JOIN menus m ON s.id = m.store_id
WHERE s.id IN (SELECT distinct store_id FROM menus WHERE is_popular = TRUE);



/****************************
NOT IN 연산자
****************************/

-- 인기메뉴가 없는 매장 조회하기.
-- 1단계 : 인기메뉴 있는 매장 조회하기.
SELECT distinct store_id
FROM menus
WHERE is_popular = TRUE;
-- 2단계 : 전체 매장에서 1단계에서 조회한 매장 제외하기.
SELECT name, category, rating
FROM stores
where id NOT IN (SELECT distinct store_id FROM menus WHERE is_popular = TRUE);



/**********************************************************
           다중행 서브쿼리 실습문제 (1 ~ 10 문제)
           IN / NOT IN 연산자
***********************************************************/
SELECT * FROM menus;

-- 문제 1: 카테고리별 최고 평점 매장들 조회
-- 1단계: 카테고리별 최고 평점들 확인
SELECT category, max(rating) FROM stores GROUP BY category;

SELECT max(rating) FROM stores GROUP BY category;
SELECT category FROM stores GROUP BY category;
-- 2단계: 1단계 결과를 조합하여 각 카테고리의 최고 평점 매장들 가져오기
SELECT *
FROM stores s
INNER JOIN (SELECT category, max(rating) '최대평점' FROM stores GROUP BY category) J
ON s.category = J.category AND s.rating = J.최대평점;




-- 문제 2: 배달비가 가장 저렴한 매장들의 인기 메뉴들 조회
-- 1단계: 가장 저렴한 배달비 매장 ID들 확인
SELECT min(delivery_fee) FROM stores;
SELECT id FROM stores WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores);
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 인기 메뉴들 가져오기
SELECT *
FROM menus
WHERE is_popular = TRUE
AND store_id IN (SELECT id FROM stores WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores));


-- 문제 3: 평점이 가장 높은 매장들의 모든 메뉴들 조회
-- 1단계: 가장 높은 평점 매장 ID들 확인
SELECT max(rating) FROM stores;
SELECT id FROM stores WHERE rating = (SELECT max(rating) FROM stores);
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 모든 메뉴들 가져오기
SELECT * FROM stores WHERE id IN (SELECT id FROM stores WHERE rating = (SELECT max(rating) FROM stores));


-- 문제 4: 15000원 이상 메뉴가 없는 매장들 조회
-- 1단계: 15000원 이상 메뉴를 가진 매장 ID들 확인
SELECT distinct store_id FROM menus WHERE price > 15000;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기
SELECT * FROM stores WHERE id NOT IN (SELECT distinct store_id FROM menus WHERE price > 15000);


-- 문제 5: 메뉴 설명이 있는 메뉴를 파는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT distinct store_id FROM menus WHERE description IS NOT NULL;
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT * FROM stores WHERE id IN (SELECT distinct store_id FROM menus WHERE description IS NOT NULL);


-- 문제 6: 메뉴 설명이 없는 메뉴만 있는 매장들 조회
-- 1단계: 메뉴 설명이 있는 메뉴를 가진 매장 ID들 확인
SELECT distinct store_id FROM menus WHERE description IS NOT NULL;
-- 2단계: 1단계 결과에 해당하지 않는 매장들 가져오기 (단, 메뉴가 있는 매장만)
SELECT *
FROM stores S
INNER JOIN menus M
ON s.id = m.store_id
WHERE s.id NOT IN (SELECT distinct store_id FROM menus WHERE description IS NOT NULL);


-- 문제 7: 치킨 카테고리 매장들의 메뉴들 조회
-- 1단계: 치킨 카테고리 매장 ID들 확인
SELECT id FROM stores WHERE category = '치킨';
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 메뉴들 가져오기
SELECT * FROM menus WHERE store_id IN (SELECT id FROM stores WHERE category = '치킨');


SELECT * FROM stores;
-- 문제 8: 피자 매장이 아닌 곳의 메뉴들만 조회
-- 1단계: 피자 매장 ID들 확인
SELECT id FROM stores WHERE category = '피자';
-- 2단계: 1단계 결과에 해당하지 않는 매장들의 메뉴들 가져오기
SELECT * FROM menus WHERE store_id NOT IN (SELECT id FROM stores WHERE category = '피자');


-- 문제 9: 평균 가격보다 비싼 메뉴를 파는 매장들 조회
-- 1단계: 평균 가격보다 비싼 메뉴를 가진 매장 ID들 확인
SELECT avg(price) FROM menus;
SELECT distinct store_id FROM menus WHERE price > (SELECT avg(price) FROM menus);
-- 2단계: 1단계 결과를 조합하여 해당 매장들 정보 가져오기
SELECT * FROM stores WHERE id IN (SELECT distinct store_id FROM menus WHERE price > (SELECT avg(price) FROM menus));


-- 문제 10: 가장 비싼 메뉴를 파는 매장들 조회
-- 1단계: 가장 비싼 메뉴를 가진 매장 ID들 확인
SELECT max(price) FROM menus;
SELECT distinct store_id FROM menus WHERE price = (SELECT max(price) FROM menus);
-- 2단계: 1단계 결과를 조합하여 해당 매장과 메뉴 정보 가져오기
SELECT *
FROM stores
WHERE id = (SELECT distinct store_id FROM menus WHERE price = (SELECT max(price) FROM menus));



/****************************
ANY 연산자
IS NULL / IS NOT NULL
****************************/

-- 치킨, 피자 카테고리 매장들만 조회하기.
-- 1단계 : 치킨 피자 카테고리 중복없이 조회하기.
SELECT distinct name, category, rating
FROM stores
WHERE category IN ('치킨','피자');
-- 2단계 : WHERE category = '치킨' OR category = '피자'
SELECT distinct name, category, rating
FROM stores
WHERE category = '치킨' OR category = '피자';


-- 2만원 이상인 메뉴를 파는 매장들 조회하기.
-- 1단계 : 메뉴가 2만원 이상인 매장 조회하기.
SELECT distinct store_id
FROM menus
WHERE price > 20000;
-- 2단계 : 해당 매장들에 대한 정보 가져오기
SELECT name, category, rating
FROM stores
WHERE id IN (SELECT distinct store_id FROM menus WHERE price > 20000)
ORDER BY name;



/****************************
ALL 연산자
****************************/



























