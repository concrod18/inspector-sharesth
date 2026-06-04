FROM golang:1.21-alpine as builder

WORKDIR /app

COPY agent/go.mod agent/go.sum ./

RUN go mod download

COPY agent/ .

RUN CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o inspector-agent.exe

FROM mcr.microsoft.com/windows/servercore:ltsc2022

WORKDIR /app

COPY --from=builder /app/inspector-agent.exe .

CMD ["inspector-agent.exe"]
