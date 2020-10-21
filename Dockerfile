FROM runsafesecurity-docker-alkemist-lfr.jfrog.io/alpine:3.12 AS lfr-files

FROM alpine:3.12

RUN apk update && apk add --virtual .build-deps \
  build-base \
  gcc

COPY hello_world.c .

ENV LFR_ROOT_PATH=/lfr
COPY --from=lfr-files /usr/src/lfr ${LFR_ROOT_PATH}

RUN ${LFR_ROOT_PATH}/scripts/lfr-helper.sh gcc -o hello_world hello_world.c \
 && ${LFR_ROOT_PATH}/scripts/lfr-cleanup.sh 

CMD ["./hello_world"]
