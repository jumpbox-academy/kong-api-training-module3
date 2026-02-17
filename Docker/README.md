# Kong API Gateway (Postgres Mode) – Docker Compose Setup
This setup runs Kong 3.9 in Traditional (DB-backed) mode using PostgreSQL 16.

## Architecture:
- PostgreSQL (kong-db)
- Kong Migrations (one-time bootstrap)
- Kong Gateway (Proxy + Admin API + Kong Manager GUI)

## Prerequisites
- Docker
- Docker Compose (v2+)

Verify installation:
```bash
docker --version

docker compose version
```

## Architecture Overview
| kong-db | PostgreSQL datastore for Kong |
| kong-migrations | Initializes Kong database schema |
| kong| Kong Gateway (Proxy + Admin API + GUI) |


## Start the Environment
```bash
docker compose up -d

docker compose ps
```
All services should be in running state

### Verify Kong is Running
Check Admin API
```bash
curl -s http://localhost:8001 | head
```
Expected output (example):
```
{
  "version": "3.9.x",
  ...
}
```

Kong Manager
```
http://localhost:8002
```