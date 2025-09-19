/****************************

SUBQUERY (서브쿼리)

하나의 SQL 문 안에 포함된 또다른 SQL 문.
메인쿼리 (기존 쿼리)를 위한 보조 역할을 하는 쿼리.
- SELECT, FROM, WHERE, HAVING 절에서 사용 가능하다.

****************************/

USE delivery_app;
SELECT * FROM stores;

/****************************
1. 기본 서브쿼리 (단일행)
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





