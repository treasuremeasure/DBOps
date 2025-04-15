📦 Sausage Store Analytics (PostgreSQL + Flyway + CI/CD)

✅ Описание проекта

Проект представляет собой аналитическую систему, моделирующую базу данных виртуального магазина сосисок. Она автоматизирует:

- миграцию и настройку PostgreSQL через Flyway;

- массовую генерацию данных (10 млн заказов и связей);

- запуск CI/CD пайплайна с автотестами через GitHub Actions;

- построение аналитических запросов к БД (например, подсчёт проданных сосисок за последние 7 дней).

🛠️ Технологии

Компонент	Технология
Язык БД	PostgreSQL 16
Миграции	Flyway 9.22
CI/CD	GitHub Actions
Контейнеризация	Docker Compose
Хранилище данных	Volume в Docker
Тесты	Binary-автотесты (dbopstest)

⚙️ Структура проекта

.
├── .github/workflows/main.yml        # CI-пайплайн
├── docker-compose.yml                # Конфигурация запуска PostgreSQL
├── insert-data.sh                    # Bash-скрипт для ручной инициализации БД
├── migrations/
│   ├── V001__create_tables.sql       # Создание базовых таблиц
│   ├── V002__change_schema.sql       # Рефакторинг схемы и добавление внешних ключей
│   ├── V003__insert_data.sql         # Генерация данных
│   └── V004__create_index.sql        # Создание индексов для ускорения
├── Readme.md                         # Документация проекта

🚀 Быстрый старт (локально)

1. Склонируйте репозиторий

git clone <this-repo>
cd <this-repo>

2. Запустите PostgreSQL через Docker Compose

docker-compose up -d

3. Запустите миграции Flyway


flyway -url=jdbc:postgresql://localhost:5432/store \
       -user=user -password=password \
       -locations=filesystem:migrations migrate

Убедитесь, что Flyway установлен

4. Проверьте содержимое БД

psql -U user -d store -h localhost -c '\dt'

🤖 CI/CD пайплайн

Файл .github/workflows/main.yml автоматически запускает:

- PostgreSQL в контейнере;

- установку Flyway и прогон миграций;

- скачивание и запуск автотестов (dbopstest);

- проверку структуры и содержимого БД.

Пайплайн запускается при пуше в main.

🧪 SQL-запрос (аналитика)

Пример запроса: сколько сосисок было продано за каждый день предыдущей недели:

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


📌 Комментарии по миграциям

V001__create_tables.sql: базовые таблицы product, orders, order_product.

V002__change_schema.sql: удаление избыточных таблиц, добавление полей price, date_created, внешние ключи.

V003__insert_data.sql: добавление 10M записей с generate_series и random().

V004__create_index.sql: индексация по order_id, status, date_created для ускорения аналитики.

📑 Дополнительно: insert-data.sh

Скрипт insert-data.sh позволяет:

- пересоздать всю схему вручную;

- наполнить таблицы актуальными данными без использования Flyway;

- удобно использовать на этапе локального дебага.

📩 Автор

Ордухани Риза
✉️ orduhaniriza@gmail.com