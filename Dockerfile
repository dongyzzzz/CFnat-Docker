FROM --platform=$BUILDPLATFORM golang:1.23-alpine AS builder

ARG TARGETOS
ARG TARGETARCH
ARG TARGETVARIANT

WORKDIR /src
COPY cfnat.go ./cfnat.go

# Build cfnat from source for the target platform.
RUN set -eux; \
    mkdir -p /cfnat; \
    goarm=""; \
    if [ "$TARGETARCH" = "arm" ] && [ -n "$TARGETVARIANT" ]; then \
        goarm="${TARGETVARIANT#v}"; \
    fi; \
    CGO_ENABLED=0 GOOS="${TARGETOS:-linux}" GOARCH="$TARGETARCH" GOARM="$goarm" \
    go build -trimpath -ldflags="-s -w" -o /cfnat/cfnat ./cfnat.go

FROM alpine:3.19

WORKDIR /app
RUN apk add --no-cache ca-certificates

COPY --from=builder /cfnat/cfnat ./cfnat
COPY go.sh ./go.sh
COPY ips-v4.txt ./ips-v4.txt
COPY ips-v6.txt ./ips-v6.txt
COPY locations.json ./locations.json

RUN chmod +x ./cfnat ./go.sh

ENV colo="SJC,LAX,HKG" \
    delay="300" \
    ipnum="10" \
    ips="4" \
    num="10" \
    port="443" \
    random="true" \
    task="100" \
    tls="true" \
    code="200" \
    domain="cloudflaremirrors.com/debian"

EXPOSE 1234

CMD ["/bin/sh", "./go.sh"]
