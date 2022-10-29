TRUNCATE TABLE items, cohorts RESTART IDENTITY;

INSERT INTO items (name, price, quantity) VALUES (milk, 1, 6)
INSERT INTO items (name, price, quantity) VALUES (feta, 2, 3)
INSERT INTO items (name, price, quantity) VALUES (broccoli, 1, 2)
INSERT INTO items (name, price, quantity) VALUES (chicken, 5, 5)
INSERT INTO items (name, price, quantity) VALUES (coffee, 7, 4)

INSERT INTO orders (order_name, order_date, order_time) VALUES ('alastair', '01,05,2022', '08:15:00')
INSERT INTO orders (order_name, order_date, order_time) VALUES ('gunel', '03,08,2022', '09:15:00')
INSERT INTO orders (order_name, order_date, order_time) VALUES ('thanos', '24,10,2022', '10:15:00')
INSERT INTO orders (order_name, order_date, order_time) VALUES ('mum', '28,04,2022', '11:15:00')
INSERT INTO orders (order_name, order_date, order_time) VALUES ('dad', '01,08,2022', '12:15:00')


