FROM alpine:3.20

# 필요하면 수정!!!!!!!!!!
ARG APP_USER=skills
ARG APP_UID=1001
ARG LOG_DIRECTORY=/app/log

WORKDIR /app

RUN apk add --no-cache curl gcompat
RUN adduser -D -u ${APP_UID} ${APP_USER}
COPY --chown=${APP_UID}:${APP_UID} stress-arm64 .
RUN mkdir -p ${LOG_DIRECTORY}
RUN chown -R ${APP_UID}:${APP_UID} /app && \
    chmod +x stress-arm64

USER ${APP_UID}:${APP_UID}

ENTRYPOINT ["/app/stress-arm64"]

# === 사용 가이드 ===
# 기본 실행: 
# docker run -d -p 8080:8080 --cap-add=SYS_PTRACE stress-arm64
#
# 토큰 엔드포인트 설정:
# docker run -d -p 8080:8080 stress-arm64 -stressEndpoint http://stress -region us-east-1
#
# 멀티 플랫폼 빌드:
# docker buildx build --platform linux/arm64 -t stress-arm64:latest --load .