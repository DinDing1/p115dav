# 构建阶段
FROM python:3.12-slim as builder

WORKDIR /app
COPY pyproject.toml poetry.lock* ./
RUN pip install --no-cache-dir poetry && \
    poetry export -f requirements.txt --output requirements.txt

# 运行时阶段
FROM python:3.12-slim

COPY --from=builder /app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /app
COPY . .

EXPOSE 8000
CMD ["p115dav", "--cookies-path", "/app/115-cookies.txt"]