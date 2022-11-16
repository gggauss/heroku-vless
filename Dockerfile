FROM alpine:latest
RUN apk add --no-cache --virtual .build-deps ca-certificates curl unzip
ADD configure.sh /configure.sh
ADD v2-linux-64.zip /v2-linux-64.zip
RUN chmod +x /configure.sh
CMD /configure.sh
RUN apk del .build-deps
