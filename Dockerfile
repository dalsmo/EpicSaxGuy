# Build Stage
# First pull Golang image
#FROM golang:1.17-alpine as build-env
FROM golang as build-env

# Set environment variable
ENV APP_NAME sample-dockerize-app
ENV CMD_PATH server.go
LABEL org.opencontainers.image.source="https://github.com/dalsmo/EpicSaxGuy"

# Copy application data into image
COPY . $GOPATH/src/$APP_NAME

WORKDIR $GOPATH/src/$APP_NAME


# Budild application
RUN CGO_ENABLED=0 go build -v -o /$APP_NAME $GOPATH/src/$APP_NAME/$CMD_PATH

# Run Stage
FROM alpine:3.14

# Set environment variable
ENV APP_NAME sample-dockerize-app

# Copy only required data into this image
COPY --from=build-env /$APP_NAME .
COPY ./data/epic-sax-guy-saxophone.gif /appStuff/data/epic-sax-guy-saxophone.gif
COPY ./data/epic-sax-guy-saxophone.gif /epic-sax-guy-saxophone.gif
COPY ./image.html /appStuff/image.html

# Expose application port
EXPOSE 8076

# Start app
CMD ./$APP_NAME