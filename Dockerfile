FROM alpine:3.14

RUN apk upgrade --no-cache && \
	apk add --no-cache bash curl ca-certificates aws-cli gettext

ADD ./s3cache /bin

ENTRYPOINT ["s3cache"]
