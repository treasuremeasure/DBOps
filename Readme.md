Pet Project: Sausage-Store-Analytics
Goal: Build an analytics system modeling a database for a virtual sausage store
Stack: PostgreSQL, Flyway, Docker, GitHub Actions (CI/CD)
An analytics system for a virtual sausage store. The workflow is as follows:

- PostgreSQL migration and configuration via Flyway
- Bulk data generation (10 million orders and relationships)
- CI/CD pipeline with automated tests via GitHub Actions
- Analytical queries against the database (e.g., counting sausages sold in the last 7 days)

The CI pipeline automatically runs PostgreSQL in a container, installs Flyway, runs migrations, and validates the database structure and content. Migrations include table creation, schema refactoring with foreign keys, data generation using generate_series and random(), and index creation for faster analytics.
