# Agent - Inspector Sharesth

Lightweight Go-based Windows agent for the Inspector Sharesth platform.

## Features

- Auto-start with Windows
- Ultra-low resource usage (<1% CPU idle, <50MB RAM)
- Secure registration and authentication
- Auto-reconnect with local caching
- End-to-end encrypted communication
- Multi-browser support (Chrome, Edge, Firefox, Brave)
- Adaptive screenshot capture
- Session duration tracking

## Tech Stack

- **Language**: Go 1.21+
- **Encryption**: cryptography/aes
- **HTTP**: net/http with custom client
- **JSON**: encoding/json
- **Logging**: log/slog

## Project Structure

```
agent/
├── main.go
├── config/
│   └── config.go
├── registry/
│   └── registry.go
├── browser/
│   ├── chrome.go
│   ├── edge.go
│   ├── firefox.go
│   └── brave.go
├── monitor/
│   ├── activity_monitor.go
│   ├── screenshot_capture.go
│   └── session_tracker.go
├── network/
│   ├── client.go
│   ├── encryption.go
│   └── cache.go
├── system/
│   ├── windows_service.go
│   └── process_monitor.go
├── utils/
│   ├── logger.go
│   └── helpers.go
├── go.mod
├── go.sum
└── Dockerfile
```

## Building

```bash
go mod download
go build -o inspector-agent.exe
```

## Installation

1. Run the installer
2. Agent auto-registers with the server
3. Windows service starts automatically
4. Agent connects on startup

## Configuration

Configuration is stored in:
```
C:\ProgramData\InspectorSharesth\config.json
```

## Key Components

### Browser Monitor
- Tracks active URLs across all supported browsers
- Monitors page titles and timestamps
- Detects website category changes
- Manages screenshot intervals

### Screenshot Manager
- Compresses screenshots to minimize bandwidth
- Encrypts before transmission
- Implements local caching
- Respects screenshot intervals per category

### Session Tracker
- Monitors session duration
- Detects context switches
- Logs sensitive resource access
- Records user interactions

### Network Client
- Handles server communication
- Implements retry logic
- Manages offline caching
- Encrypts all data in transit
