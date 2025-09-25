CREATE TABLE shop_items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    price INT NOT NULL
);

CREATE TABLE customer_points (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    points INT DEFAULT 0
);

CREATE TABLE order_history (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id VARCHAR(50) NOT NULL,
    item_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO shop_items (item_id, item_name, stock, price) VALUES
(101, '키보드', 10, 30000),
(102, '마우스', 5, 25000),
(103, '모니터', 0, 150000);

INSERT INTO customer_points (customer_id, customer_name, points) VALUES
('user01', '홍길동', 1000);


SELECT * FROM shop_items;
SELECT * FROM customer_points;
SELECT * FROM order_history;


-- 문제1
START TRANSACTION;
UPDATE shop_items SET stock = stock - 1 WHERE item_id = 101;
UPDATE customer_points SET points = points + 300 WHERE customer_id = 'user01';
INSERT INTO order_history VALUES (null, 'user01', 101, now());
COMMIT;

-- 키보드 재고가 9개, 홍길동 포인트가 1300점이 되었는지 확인
SELECT * FROM shop_items WHERE item_id = 101;
SELECT * FROM customer_points WHERE customer_id = 'user01';
SELECT * FROM order_history;



-- 문제2
START TRANSACTION;
INSERT INTO customer_points (customer_id, customer_name, points) VALUES ('user02', '이몽룡', 0);
UPDATE shop_items SET stock = stock - 1 WHERE item_id = 102;
ROLLBACK;

-- 마우스 재고가 그대로 5개이고, '이몽룡' 고객 정보가 없는지 확인
SELECT * FROM shop_items WHERE item_id = 102;
SELECT * FROM customer_points WHERE customer_id = 'user02';


-- 문제3
START TRANSACTION;
UPDATE shop_items SET stock = stock - 1 WHERE item_id = 102;
UPDATE customer_points SET points = points + 250 WHERE customer_id = 'user01';
INSERT INTO order_history VALUES (null, 'user01', 102, now());
SAVEPOINT mouse_order_success;

UPDATE shop_items SET stock = stock - 1 WHERE item_id = 103;
ROLLBACK TO SAVEPOINT mouse_order_success;
COMMIT;

-- 마우스 재고는 4개로 줄었지만, 모니터 재고는 그대로 0개인지 확인
SELECT * FROM shop_items;
-- 홍길동의 최종 포인트가 1300점(기존) + 250점(마우스) = 1550점이 되었는지 확인
SELECT * FROM customer_points;
-- 주문 내역에 마우스만 추가되었는지 확인
SELECT * FROM order_history;



