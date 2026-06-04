# Backend - Inspector Sharesth

FastAPI-based backend for the Inspector Sharesth monitoring platform.

## Features

- RESTful API endpoints
- WebSocket support for real-time updates
- Database ORM with SQLAlchemy
- JWT authentication
- Role-based access control
- Event logging and audit trails
- Risk scoring engine
- PDF report generation

## Tech Stack

- **Framework**: FastAPI 0.104+
- **Database**: PostgreSQL with SQLAlchemy
- **Authentication**: JWT (PyJWT)
- **Encryption**: cryptography library
- **PDF**: ReportLab/weasyprint

## Installation

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
alembic upgrade head
uvicorn app.main:app --reload
```

## API Endpoints

### Authentication
- POST /api/auth/login
- POST /api/auth/logout
- POST /api/auth/refresh
- POST /api/auth/register

### Employees
- GET /api/employees
- POST /api/employees
- GET /api/employees/{id}
- PUT /api/employees/{id}
- DELETE /api/employees/{id}

### Devices
- GET /api/devices
- POST /api/devices
- GET /api/devices/{id}
- PUT /api/devices/{id}

### Activity & Screenshots
- GET /api/activity
- POST /api/activity
- GET /api/screenshots
- POST /api/screenshots

### Reports & Risk
- GET /api/reports
- POST /api/reports/generate
- GET /api/risk/dashboard
- GET /api/alerts
