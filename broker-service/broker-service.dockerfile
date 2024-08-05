FROM golang:1.21-alpine

EXPOSE 4000 80

# COPY go.mod go.sum ./
# RUN go mod download
# COPY . .

RUN mkdir /app

COPY brokerApp /app

RUN CGO_ENABLED=0 go install -ldflags "-s -w -extldflags '-static'" github.com/go-delve/delve/cmd/dlv@latest


CMD ["/app/brokerApp"]