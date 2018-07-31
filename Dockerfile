FROM alpine:3.5

RUN apk upgrade --no-cache && apk add --no-cache bash curl ca-certificates ncurses
RUN curl -L https://github.com/rlmcpherson/s3gof3r/releases/download/v0.5.0/gof3r_0.5.0_linux_amd64.tar.gz -o - | tar -xzf -; mv gof3r_0.5.0_linux_amd64/gof3r /bin; rm -rf gof3r_0.5.0_linux_amd64*

ADD ./s3cache /bin

ENTRYPOINT ["s3cache"]
