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
- 포함할 때 사용한다.
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
NOT IN 연산자
- 제외할 때 사용한다.
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

SELECT *
FROM stores
WHERE RATING in (SELECT max(rating)
FROM stores
GROUP BY category);


-- 문제 2: 배달비가 가장 저렴한 매장들의 인기 메뉴들 조회
-- 1단계: 가장 저렴한 배달비 매장 ID들 확인
SELECT min(delivery_fee) FROM stores;
SELECT id FROM stores WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores);
-- 2단계: 1단계 결과를 조합하여 해당 매장들의 인기 메뉴들 가져오기
SELECT *
FROM menus
WHERE is_popular = TRUE
AND store_id IN (SELECT id FROM stores WHERE delivery_fee = (SELECT min(delivery_fee) FROM stores));
/*
WHERE 절에는 MIN() MAX() AVG() 등의 함수를 직접적으로 사용 불가능하다.
WHERE 절은 테이블의 각 행을 하나씩 필터링하는 단계이다.
*/


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
- 하나라도 조건을 만족하면 TRUE
****************************/

-- 치킨집 중에서 배달비가 저렴한 매장들 확인하기.
-- 1단계 : 치킨집들의 배달비 확인하기.
SELECT name, delivery_fee FROM stores WHERE category = '치킨' AND delivery_fee IS NOT NULL ORDER BY delivery_fee;
-- 2단계 : 특정 값 (3000원)보다 작은 매장 찾기.
SELECT * FROM stores WHERE delivery_fee <= 3000 AND delivery_fee IS NOT NULL;
-- 3단계 : ANY로 조합하여 치킨 카테고리에서 배달비가 3천원이하인 가게들의 이름과 카테고리, 배달비 조회하기.
SELECT name, category, delivery_fee
FROM stores
WHERE delivery_fee < ANY(
				SELECT delivery_fee
                FROM stores
                WHERE category = '치킨'
                AND delivery_fee IS NOT NULL ORDER BY delivery_fee)
AND delivery_fee IS NOT NULL
ORDER BY delivery_fee;


-- 한식집들 중 어떤 매장보다 평점이 높은 매장 찾기.
-- 1단계 : 한식집 평점 확인하기.
SELECT rating
FROM stores
WHERE category = '한식';
-- 2단계 : 한식집 중 어느 매장보다든 높은 평점 매장 찾기.
SELECT *
FROM stores
WHERE rating > 4.2
AND rating IS NOT NULL;
-- 3단계 : ANY 작성하기.
SELECT *
FROM stores
WHERE rating > ANY (SELECT rating
					FROM stores
					WHERE category = '한식'
                    AND rating IS NOT NULL)
AND rating IS NOT NULL
AND category NOT IN('한식');			-- 한식 제외한 카테고리 조회 추가하기.

-- 일식집들 기준으로 배달비가 저렴한 매장 찾기.
-- 1단계 : 일식집 배달비 확인하기.
SELECT delivery_fee
FROM stores
WHERE category IN ('일식');
-- 2단계 : 일식집 중 어느 매장보다든 저렴한 매장 찾기.
SELECT *
FROM stores
WHERE delivery_fee < 4000
AND delivery_fee IS NOT NULL;
-- 3단계 : ANY 작성하기.
SELECT *
FROM stores
WHERE delivery_fee < ANY (SELECT delivery_fee
							FROM stores
							WHERE category IN ('일식'))
AND delivery_fee IS NOT NULL
AND category NOT IN ('일식');



/****************************
ALL 연산자
- 모든 조건을 만족해야 TRUE
****************************/

-- 치킨집보다 배달비가 저렴한 매장 찾기.
-- 1단계 : 치킨집 배달비 확인하기.
SELECT min(delivery_fee)
FROM stores
WHERE category IN ('치킨');
-- 2단계 : 모든 치킨집 배달비 중 가장 낮은 치킨집을 기준으로 저렴한 매장 찾기.
SELECT *
FROM stores
WHERE delivery_fee < 2000
AND delivery_fee IS NOT NULL
AND category != '치킨';
-- 3단계 : ALL 작성하기.
SELECT *
FROM stores
WHERE delivery_fee < ALL (SELECT delivery_fee
							FROM stores
							WHERE category IN ('치킨'))
AND delivery_fee IS NOT NULL
AND category != '치킨';
# Java에서는 DB에서 전달받은 데이터가 0개일 것이고, HTML로 0개를 전달한다.
# HTML에서는 조회된 결과가 없다는 것을 표시한다.
# DB OUTPUT 화면에 X가 표시되지 않고, 결과가 없다면 단순히 조회 결과가 없다는 것이다.



/****************************
EXISTS 연산자
- 모든 조건을 만족해야 TRUE

-- EXISTS = T/F만 본다.
-- 			존재 유무를 단순히 확인하기 때문에 1과 같은 숫자 값으로 빠르게 가져오도록 설정한다.
-- 존재하면 1이라는 숫자가 몇 개 뜨는지만 조회할 때 주로 사용한다.
-- 컬럼 내부 값은 중요하지 않고, 단순히 존재 유뮤를 확인할 때 사용하는 단순 숫자 표기
-- 숫자 값은 개발자가 넣고 싶은 숫자 값을 맘대로 넣어도 되지만 보통 존재할 때는 1, 존재하지 않을 때는 0을 작성한다.

EXISTS 사용 방법

WHERE EXISTS ( 	SELECT 	1
				FROM 	테이블명
                WHERE	별칭.외래키 = 현재테이블별칭.기본키 ) ;
                
****************************/

-- 메뉴가 존재하는 매장들 찾기.
-- 1단계 : 각 매장별로 메뉴가 있는지 확인하기.
-- 		  예를 들어 store_id가 1인 매장 메뉴 확인하기.
-- store_id = 1인 데이터를 조회할 때의 모든 컬럼의 결과를 가져온다.
SELECT *
FROM menus
WHERE store_id = 1;
-- SELECT 1은 내부 컬럼 데이터가 아닌 데이터가 존재하는지 확인한다.
-- TRUE = 1
-- FALSE = 0
-- 존재하면 1이라는 숫자가 몇 개 뜨는지만 조회할 때 주로 사용한다.
-- 컬럼 내부 값은 중요하지 않고, 단순히 존재 유뮤를 확인할 때 사용하는 단순 숫자 표기
-- 숫자 값은 개발자가 넣고 싶은 숫자 값을 맘대로 넣어도 되지만 보통 존재할 때는 1, 존재하지 않을 때는 0을 작성한다.
SELECT 1
FROM menus
WHERE store_id = 1;

SELECT name, category
FROM stores S
WHERE exists (SELECT 1
				FROM menus M
				WHERE M.store_id = S.id);	# menus store_id가 stores id가 같이 존재할 경우에만 출력한다.
											# 모든 가게가 모든 메뉴를 갖고 있기 때문에 모두 조회되지만
                                            # 배민에서 가게를 오픈하기만 하고, 메뉴가 존재하지 않는 매장은 조회되지 않는다.
                                            
                                            
-- 설명이 있는 메뉴를 파는 매장 찾기.
-- 1단계 : 설명이 있는 메뉴를 가진 매장 ID 찾기.
SELECT distinct store_id
FROM menus
WHERE description IS NOT NULL;
-- 2단계 : EXISTS 활용하여 조합하기.
-- EXISTS = T/F만 본다.
-- 			존재 유무를 단순히 확인하기 때문에 1과 같은 숫자 값으로 빠르게 가져오도록 설정한다.
-- store_id 연결 조건이 없기 때문에 단순히 
SELECT *
FROM stores
WHERE exists (SELECT distinct store_id
				FROM menus
				WHERE description IS NOT NULL);	# 설명이 없는 메뉴도 있는 매장 조회된다.
                
-- 매장 중에서 메뉴 설명이 존재하는 데이터만 조회하기.
-- s.id = m.store_id 메뉴와 가게가 서로 연결된 데이터만 조회하도록 설정한다.
SELECT *
FROM stores S
WHERE exists (SELECT distinct store_id
				FROM menus M
				WHERE s.id = m.store_id
                AND description IS NOT NULL);
                

/****************************
NOT EXISTS 연산자
- 모든 조건을 만족해야 TRUE
****************************/




















