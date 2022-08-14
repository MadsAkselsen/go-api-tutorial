# first image
FROM golang:alpine AS builder

WORKDIR /go/src
COPY . .

RUN go mod download
RUN go mod verify
# build folder called 'server'
RUN go build -o server .

# second image
FROM alpine

WORKDIR /app
# copy from 'builder' image to folder 'app'. 
COPY --from=builder /go/src/server /app/

EXPOSE 8080

ENTRYPOINT ["./server"]