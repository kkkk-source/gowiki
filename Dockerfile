FROM golang:1.12.0-alpine3.9
RUN mkdir /gowiki
ADD . /gowiki
WORKDIR /gowiki
RUN go build -o main .
CMD ["/gowiki/main"]
