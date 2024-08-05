FROM golang:1.21-alpine

EXPOSE 4000 80

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .


RUN CGO_ENABLED=0 go install -ldflags "-s -w -extldflags '-static'" github.com/go-delve/delve/cmd/dlv@latest
RUN CGO_ENABLED=0 go build -gcflags "all=-N -l" -o authApp ./cmd/api

CMD [ "/go/bin/dlv", "--listen=:4000", "--headless=true", "--log=true", "--accept-multiclient", "--api-version=2", "exec", "/app/authApp"]