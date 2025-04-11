DROP TABLE IF EXISTS product_info;
DROP TABLE IF EXISTS orders_date;

ALTER TABLE product
ADD COLUMN IF NOT EXISTS price double precision;

ALTER TABLE orders
ADD COLUMN IF NOT EXISTS date_created date DEFAULT current_date;

ALTER TABLE order_product
ADD FOREIGN KEY (order_id) REFERENCES orders(id);

ALTER TABLE order_product
ADD FOREIGN KEY (product_id) REFERENCES product(id);