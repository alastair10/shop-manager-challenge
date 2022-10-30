TRUNCATE TABLE items, orders, items_orders RESTART IDENTITY CASCADE;

INSERT INTO items (item_name, item_price, item_quantity) VALUES ('milk', 1, 6);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('feta', 2, 3);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('broccoli', 1, 2);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('chicken', 5, 5);
INSERT INTO items (item_name, item_price, item_quantity) VALUES ('coffee', 7, 4);

INSERT INTO orders (order_name, order_date) VALUES ('alastair', '2022-05-01');
INSERT INTO orders (order_name, order_date) VALUES ('gunel', '2022-08-03');
INSERT INTO orders (order_name, order_date) VALUES ('thanos', '2022-10-24');
INSERT INTO orders (order_name, order_date) VALUES ('mum', '2022-04-30');
INSERT INTO orders (order_name, order_date) VALUES ('dad', '2022-08-01');

INSERT INTO items_orders (item_id, order_id) VALUES (5,1);
INSERT INTO items_orders (item_id, order_id) VALUES (2,2);
INSERT INTO items_orders (item_id, order_id) VALUES (3,2);
INSERT INTO items_orders (item_id, order_id) VALUES (4,3);
INSERT INTO items_orders (item_id, order_id) VALUES (1,4);
INSERT INTO items_orders (item_id, order_id) VALUES (5,4);
INSERT INTO items_orders (item_id, order_id) VALUES (1,5);
INSERT INTO items_orders (item_id, order_id) VALUES (2,5);
INSERT INTO items_orders (item_id, order_id) VALUES (3,5);
