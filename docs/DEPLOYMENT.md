# Deployment Guide

## Prerequisites

- Docker & Docker Compose 1.29+
- PostgreSQL 14+ (for production)
- 2GB+ RAM minimum for development
- 8GB+ RAM recommended for production
- Linux/Windows Server 2019+ for agent deployment

## Local Development Deployment

### 1. Clone the Repository

```bash
git clone https://github.com/concrod18/inspector-sharesth.git
cd inspector-sharesth
```

### 2. Start Services with Docker Compose

```bash
docker-compose -f docker-compose.yml up -d
```

### 3. Initialize Database

```bash
docker-compose exec backend alembic upgrade head
```

### 4. Create Admin User

```bash
docker-compose exec backend python -m app.cli create-admin \
  --username admin \
  --email admin@inspector.local \
  --password your-secure-password
```

### 5. Access Dashboard

- Frontend: http://localhost:3000
- API: http://localhost:8000
- Default credentials: admin/your-secure-password

## Production Deployment

### 1. Environment Configuration

Create `.env.production`:

```env
DEBUG=false
SECRET_KEY=your-very-secure-secret-key-here
ALGORITHM=HS256
JWT_EXPIRATION_HOURS=24

DATABASE_URL=postgresql://user:password@db-host:5432/inspector_sharesth
DATABASE_POOL_SIZE=20
DATABASE_MAX_OVERFLOW=40

SCREENSHOT_STORAGE_PATH=/mnt/screenshots
REPORT_STORAGE_PATH=/mnt/reports
SCREENSHOT_ENCRYPTION_KEY=your-encryption-key

SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_USERNAME=your-email@gmail.com
SMTP_PASSWORD=your-app-password

ALLOWED_HOSTS=yourdomain.com,www.yourdomain.com
CORS_ORIGINS=https://yourdomain.com,https://www.yourdomain.com
```

### 2. Database Setup

```bash
# Create database
createdb -U postgres inspector_sharesth

# Load schema
psql -U postgres inspector_sharesth < database/schema.sql

# Run migrations
alembic upgrade head
```

### 3. Deploy with Kubernetes

```bash
# Create namespace
kubectl create namespace inspector-sharesth

# Create ConfigMap and Secrets
kubectl create secret generic inspector-secrets \
  --from-literal=DATABASE_URL=... \
  --from-literal=SECRET_KEY=... \
  -n inspector-sharesth

# Deploy
kubectl apply -f k8s/ -n inspector-sharesth
```

### 4. SSL/TLS Configuration

```bash
# Using Let's Encrypt with Nginx
certbot certonly --standalone -d yourdomain.com
```

### 5. Reverse Proxy Setup (Nginx)

```nginx
server {
    listen 443 ssl http2;
    server_name yourdomain.com;

    ssl_certificate /etc/letsencrypt/live/yourdomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/yourdomain.com/privkey.pem;

    # API backend
    location /api/ {
        proxy_pass http://localhost:8000/api/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # WebSocket
    location /ws {
        proxy_pass http://localhost:8000/ws;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    # Frontend
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
    }
}
```

### 6. Agent Deployment

#### Windows Deployment

```powershell
# Download agent installer
Invoke-WebRequest -Uri "https://yourdomain.com/agents/windows/latest" `
  -OutFile "inspector-agent-installer.exe"

# Run installer
.\inspector-agent-installer.exe `
  -ServerURL "https://yourdomain.com" `
  -RegistrationToken "your-token-here"

# Verify service started
Get-Service InspectorSharesth
```

#### Batch Deployment

```powershell
# Using Group Policy or SCCM
# 1. Create MSI package
# 2. Distribute via GPO/SCCM
# 3. Monitor deployment status in dashboard
```

## Monitoring & Maintenance

### Health Checks

```bash
# Backend health
curl -s http://localhost:8000/api/health | jq .

# Database connectivity
docker-compose exec postgres pg_isready -U inspector
```

### Log Monitoring

```bash
# Backend logs
docker-compose logs -f backend

# Frontend logs
docker-compose logs -f frontend

# Database logs
docker-compose logs -f postgres
```

### Backup & Recovery

```bash
# Backup database
pg_dump -U inspector inspector_sharesth > backup.sql

# Backup screenshots
tar -czf screenshots-backup.tar.gz /mnt/screenshots

# Restore database
psql -U inspector inspector_sharesth < backup.sql
```

### Performance Tuning

```sql
-- Analyze query performance
EXPLAIN ANALYZE SELECT * FROM activity_logs;

-- Vacuum and analyze
VACUUM ANALYZE;

-- Check index usage
SELECT * FROM pg_stat_user_indexes;
```

## Security Hardening

1. **Firewall Rules**
   - Allow only required ports
   - Restrict agent communication to backend only

2. **Database Security**
   - Enable SSL connections
   - Use strong passwords
   - Regular security updates

3. **API Security**
   - Enable rate limiting
   - Implement DDoS protection
   - Regular security audits

4. **Secret Management**
   - Use environment variables
   - Rotate secrets regularly
   - Use HashiCorp Vault in production

## Troubleshooting

### Backend not starting

```bash
# Check logs
docker-compose logs backend

# Verify database connection
docker-compose exec backend python -c "from app.db import SessionLocal; SessionLocal()"
```

### Frontend not connecting to API

```bash
# Verify VITE_API_BASE_URL in .env
# Check CORS configuration
# Verify network connectivity
```

### Agent registration failures

```bash
# Verify registration token
# Check server URL accessibility
# Review agent logs: C:\ProgramData\InspectorSharesth\logs\
```

## Rollback Procedure

```bash
# Rollback to previous version
docker-compose down
git checkout previous-tag
docker-compose up -d
alembic downgrade -1
```

## Support

For deployment assistance: support@inspectorsharesth.com
