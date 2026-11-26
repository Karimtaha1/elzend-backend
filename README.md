# Elzend Backend

Backend source showcase for the Elzend charity management system, developed by Karim Taha.

## Stack
Node.js, Express, SQL Server, JWT, bcrypt, express-validator, Multer, Helmet and express-rate-limit.

## Included modules
- Account login and role-based access middleware
- Donations and donation statistics
- Projects, volunteers, contact messages, stories, news and partners
- Dashboard statistics and site settings
- SQL table definitions and file-upload middleware

## Local setup
1. Install Node.js and SQL Server.
2. Run `npm install`.
3. Copy `.env.example` to `.env` and set your own local database, JWT and application values. Generate your own JWT secret. Do not use production credentials.
4. Run `schema.sql` in SQL Server. It creates an empty `elzend_demo` database. No accounts or seed data are included. Provision a local administrator separately before testing protected routes.
5. Run `npm run dev` or `npm start`. The default port is 5000. The health endpoint is `/health`; API routes use `/api`.

## Scope
This is a backend-only source snapshot with fresh history. The original frontend/admin assets, uploads, production settings, environment files, dependency folder and sample database records are deliberately excluded. Static frontend paths in the server are retained, but frontend pages are not included.

`npm run test-db` is a database connection check, not a unit/integration test suite. This snapshot has not been run against a database here and does not claim production readiness, a security audit or test coverage.

## Configuration
`.env.example` lists variable names with empty values only. Configure a database user with appropriate local permissions, encryption settings, allowed CORS origins and a JWT expiry. Do not commit credentials, database backups, donor records or uploaded files.
