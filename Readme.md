-- 1. Создание пользователя
СREATE USER test_user WITH PASSWORD 'secure_password';

-- 2. Выдача всех прав на базу данных store
GRANT ALL PRIVILEGES ON DATABASE store TO test_user;

-- 3. Подключаемся к базе store, чтобы дать права на таблицы
\c store

-- 4. Выдача всех прав на все существующие таблицы (если они уже есть)
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO test_user;

-- 5. Выдача прав на будущие таблицы
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO test_user;


SELECT
  o.date_created,
  SUM(op.quantity) AS total_sold
FROM
  orders AS o
JOIN
  order_product AS op ON o.id = op.order_id
WHERE
  o.status = 'shipped'
  AND o.date_created > NOW() - INTERVAL '7 DAY'
GROUP BY
  o.date_created
ORDER BY
  o.date_created;
