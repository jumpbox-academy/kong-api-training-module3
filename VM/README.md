# Kong on VM (Ubuntu - Traditional Mode)
This guide demonstrates how to install Kong API Gateway on a Linux VM using PostgreSQL (DB-backed / Traditional mode).

## Requirements
- Ubuntu 22.04 (fresh VM recommended)
- sudo access
- Internet connection
- Git installed

If Git is not installed:
```bash
sudo apt update

sudo apt install -y git
```

## Installation Steps
Step 0 – Clone the Repository
```bash
git clone https://github.com/your-repo/kong-vm-lab.git
cd kong-vm-lab/vm
```

Make all scripts executable:
```bash
chmod +x *.sh
```

### Step 1️⃣: Install PostgreSQL
```bash
./install-postgres.sh
```
Verify PostgreSQL is running
```bash
sudo systemctl status postgresql
```

### Step 2️⃣: Install Kong
```bash
./install-kong.sh
```
Verify Kong installation:
```bash
kong version
```

### Step 3️⃣: Setup Database
Create Kong database and user
```bash
./setup-database.sh
```

### Step 4️⃣: Run Database Migrations
```bash
./migrate.sh
```
If successful, you should see:
```
Migration complete
```

### Step 5️⃣: Start Kong
```bash
./start-kong.sh
```
Check Kong health:
```
kong health
```

### ✅ Verify Installation
Test the Admin API:
```bash
curl http://localhost:8001
```