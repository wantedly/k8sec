FROM golang:1.12 AS builder

WORKDIR /go/src/github.com/wantedly/k8sec
COPY . /go/src/github.com/wantedly/k8sec

ENV CGO_ENABLED=0 GO111MODULE=on
RUN make

FROM alpine:3.8

RUN apk add --no-cache --update ca-certificates

COPY --from=builder /go/src/github.com/wantedly/k8sec/bin/k8sec /k8sec

ENTRYPOINT ["/k8sec"]
