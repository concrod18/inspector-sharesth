-- Users and Authentication
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL DEFAULT 'admin',
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Employees
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    department VARCHAR(255),
    position VARCHAR(255),
    hire_date DATE,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Devices
CREATE TABLE devices (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
    device_name VARCHAR(255) NOT NULL,
    device_id VARCHAR(255) UNIQUE NOT NULL,
    os VARCHAR(100),
    os_version VARCHAR(100),
    agent_version VARCHAR(50),
    is_registered BOOLEAN DEFAULT false,
    last_seen TIMESTAMP,
    status VARCHAR(50) DEFAULT 'offline',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Website Categories
CREATE TABLE website_categories (
    id SERIAL PRIMARY KEY,
    url VARCHAR(2048) NOT NULL,
    category VARCHAR(50) NOT NULL,
    description TEXT,
    created_by INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(url, category)
);

-- Activity Logs
CREATE TABLE activity_logs (
    id SERIAL PRIMARY KEY,
    device_id INTEGER REFERENCES devices(id) ON DELETE CASCADE,
    employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
    url VARCHAR(2048),
    title VARCHAR(512),
    category VARCHAR(50),
    browser VARCHAR(50),
    session_start TIMESTAMP,
    session_end TIMESTAMP,
    duration_seconds INTEGER,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Screenshots
CREATE TABLE screenshots (
    id SERIAL PRIMARY KEY,
    activity_log_id INTEGER REFERENCES activity_logs(id) ON DELETE CASCADE,
    device_id INTEGER REFERENCES devices(id) ON DELETE CASCADE,
    employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
    file_path VARCHAR(512),
    file_size INTEGER,
    url VARCHAR(2048),
    website_title VARCHAR(512),
    is_encrypted BOOLEAN DEFAULT true,
    is_compressed BOOLEAN DEFAULT true,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Risk Scores
CREATE TABLE risk_scores (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
    device_id INTEGER REFERENCES devices(id) ON DELETE CASCADE,
    risk_level VARCHAR(50),
    score INTEGER,
    factors TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Alerts
CREATE TABLE alerts (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
    device_id INTEGER REFERENCES devices(id),
    alert_type VARCHAR(100),
    severity VARCHAR(50),
    message TEXT,
    is_acknowledged BOOLEAN DEFAULT false,
    acknowledged_by INTEGER REFERENCES users(id),
    acknowledged_at TIMESTAMP,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Reports
CREATE TABLE reports (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id) ON DELETE CASCADE,
    device_id INTEGER REFERENCES devices(id),
    report_type VARCHAR(100),
    file_path VARCHAR(512),
    file_size INTEGER,
    summary TEXT,
    generated_by INTEGER REFERENCES users(id),
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Logs
CREATE TABLE audit_logs (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    action VARCHAR(255),
    resource_type VARCHAR(100),
    resource_id INTEGER,
    old_values TEXT,
    new_values TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_devices_employee_id ON devices(employee_id);
CREATE INDEX idx_devices_status ON devices(status);
CREATE INDEX idx_devices_last_seen ON devices(last_seen);
CREATE INDEX idx_activity_logs_device_id ON activity_logs(device_id);
CREATE INDEX idx_activity_logs_employee_id ON activity_logs(employee_id);
CREATE INDEX idx_activity_logs_timestamp ON activity_logs(timestamp);
CREATE INDEX idx_activity_logs_category ON activity_logs(category);
CREATE INDEX idx_screenshots_device_id ON screenshots(device_id);
CREATE INDEX idx_screenshots_employee_id ON screenshots(employee_id);
CREATE INDEX idx_screenshots_timestamp ON screenshots(timestamp);
CREATE INDEX idx_risk_scores_employee_id ON risk_scores(employee_id);
CREATE INDEX idx_risk_scores_timestamp ON risk_scores(timestamp);
CREATE INDEX idx_alerts_employee_id ON alerts(employee_id);
CREATE INDEX idx_alerts_timestamp ON alerts(timestamp);
CREATE INDEX idx_audit_logs_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_audit_logs_user_id ON audit_logs(user_id);
