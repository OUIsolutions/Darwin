
FROM alpine:latest
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

RUN apk update
RUN apk add --no-cache gcc musl-dev
RUN apk add git
RUN apk add curl

RUN git config --global user.name "nothing"
RUN git config --global user.email "nothing@nothing.biz"

