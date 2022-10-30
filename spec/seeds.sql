TRUNCATE TABLE items, orders RESTART IDENTITY CASCADE;

INSERT INTO items (name, price, quantity) VALUES ('milk', 1, 6);
INSERT INTO items (name, price, quantity) VALUES ('feta', 2, 3);
INSERT INTO items (name, price, quantity) VALUES ('broccoli', 1, 2);
INSERT INTO items (name, price, quantity) VALUES ('chicken', 5, 5);
INSERT INTO items (name, price, quantity) VALUES ('coffee', 7, 4);

INSERT INTO orders (order_name, order_date, order_time) VALUES ('alastair', '05/01/2022', '08:15:00');
INSERT INTO orders (order_name, order_date, order_time) VALUES ('gunel', '08/03/2022', '09:15:00');
INSERT INTO orders (order_name, order_date, order_time) VALUES ('thanos', '10/24/2022', '10:15:00');
INSERT INTO orders (order_name, order_date, order_time) VALUES ('mum', '04/28/2022', '11:15:00');
INSERT INTO orders (order_name, order_date, order_time) VALUES ('dad', '08/01/2022', '12:15:00');

INSERT INTO items_orders (item_id, order_id) VALUES (5,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,2);
INSERT INTO items_orders (item_id, order_id) VALUES (3,2);
INSERT INTO items_orders (item_id, order_id) VALUES (4,3);
INSERT INTO items_orders (item_id, order_id) VALUES (1,4);
INSERT INTO items_orders (item_id, order_id) VALUES (5,4);
INSERT INTO items_orders (item_id, order_id) VALUES (1,5);
INSERT INTO items_orders (item_id, order_id) VALUES (2,5);
INSERT INTO items_orders (item_id, order_id) VALUES (3,5);
