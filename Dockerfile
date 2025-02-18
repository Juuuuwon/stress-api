FROM alpine

WORKDIR /app

RUN apk add --no-cache curl gcompat tcpdump

RUN adduser -D -u 10001 skills

COPY --chown=10001:10001 stress-arm64 .

RUN mkdir /app/log && chown -R 10001:10001 /app

RUN chmod +x /app/stress-arm64

USER 10001:10001

ENTRYPOINT ["/app/stress-arm64"]

# 로그 리다이렉션
# ENTRYPOINT ["/bin/sh", "-c", "/app/stress-arm64 > /app/log/app.log"]



# 인자 실행 시 
# docker run -d -p 8080:8080 stress -stressEndpoint http://stress -region us-east-1

# 멀티 스테이지 빌드
# docker buildx build --platform linux/arm64 -t stress:latest --load .
