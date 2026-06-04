# Inspector Sharesth

**Lightweight Enterprise Employee Monitoring and Data Protection Platform**

A comprehensive monitoring solution designed for enterprises to track employee activity, protect sensitive data, and maintain compliance while minimizing system resource usage.

## Features

### Central Dashboard (Admin Only)
- Employee and device management
- Department and position assignment
- Website list management (Allowed, Restricted, Sensitive)
- Live endpoint status monitoring
- Activity logs and screenshot viewer
- Risk dashboard and PDF report generation

### Lightweight Windows Agent
- Auto-start with Windows
- Ultra-low resource usage (<1% CPU idle, <50MB RAM)
- Secure agent registration and authentication
- Auto-reconnect with local caching
- End-to-end encrypted communication

### Website Monitoring
- Multi-browser support (Chrome, Edge, Firefox, Brave)
- Adaptive screenshot capture based on website category
- Real-time session tracking
- Zero screenshots for allowed websites
- 10-second intervals for unknown websites
- 3-second intervals for restricted/sensitive websites

### Sensitive Resource Monitoring
- CRM systems
- Customer portals
- Payment portals
- Internal dashboards
- Admin panels

### Risk Engine
- Dynamic risk scoring (Low, Medium, High, Critical)
- Behavioral analysis
- Suspicious activity detection
- After-hours activity flagging

### Reporting & Alerts
- Automated PDF report generation
- Email notifications
- Security summaries
- Activity timelines with screenshots

## Technology Stack

| Component | Technology |
|-----------|-------------|
| Backend | FastAPI (Python) |
| Frontend | React |
| Database | PostgreSQL |
| Agent | Go |
| Reporting | PDF Generation Engine |

## Project Structure

```
inspector-sharesth/
├── backend/              # FastAPI server
│   ├── app/
│   ├── models/
│   ├── schemas/
│   ├── services/
│   ├── api/
│   └── requirements.txt
├── frontend/             # React dashboard
│   ├── src/
│   ├── public/
│   └── package.json
├── agent/                # Windows Go agent
│   ├── main.go
│   └── go.mod
├── database/             # Database schemas
│   └── migrations/
└── docker/               # Docker configuration
    ├── Dockerfile.backend
    ├── Dockerfile.agent
    └── docker-compose.yml
```

## Performance Goals

- ✅ Support 500+ endpoints
- ✅ Event-driven monitoring
- ✅ Real-time dashboard performance
- ✅ Minimal CPU/RAM/storage/bandwidth usage
- ✅ Real-time alerts
- ✅ Scalable architecture

## Security

- HTTPS API communication
- End-to-end encryption
- Role-based access control (RBAC)
- Audit logging
- Encrypted database and storage
- Agent authentication tokens
- Screenshot encryption and compression

## Getting Started

### Prerequisites
- Python 3.10+
- Node.js 18+
- Go 1.21+
- PostgreSQL 14+
- Docker & Docker Compose

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/concrod18/inspector-sharesth.git
   cd inspector-sharesth
   ```

2. **Start with Docker Compose**
   ```bash
   docker-compose -f docker/docker-compose.yml up -d
   ```

3. **Access the dashboard**
   - URL: http://localhost:3000
   - Default credentials: admin/admin (change on first login)

## Documentation

- [Backend API Documentation](./backend/README.md)
- [Frontend Setup Guide](./frontend/README.md)
- [Agent Installation & Configuration](./agent/README.md)
- [Database Schema](./database/README.md)
- [Security Best Practices](./docs/SECURITY.md)
- [Deployment Guide](./docs/DEPLOYMENT.md)

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md) for guidelines.

## License

Proprietary - Inspector Sharesth™

## Support

For support, contact: support@inspectorsharesth.com

---

**Version**: 1.0.0  
**Status**: Active Development