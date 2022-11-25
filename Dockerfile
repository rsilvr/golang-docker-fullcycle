# first stage; just building binary; it will be discarded at the end
FROM golang:1.19 AS builder
WORKDIR /build
COPY . .
# create module, update it, build binary "app"
RUN go mod init hello && go mod tidy && go build -v -o /build/app .

# second stage; just copy binary into PATH dir and run it; it wll be final image
FROM scratch
COPY --from=builder /build/app /usr/local/bin/app
CMD ["app"]