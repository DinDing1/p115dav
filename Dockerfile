# 第一阶段：构建依赖
FROM python:3.12-slim as builder

WORKDIR /app
COPY . /app

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 Poetry
RUN pip install --no-cache-dir poetry
RUN poetry config virtualenvs.create false

# 安装项目依赖
RUN poetry install --no-root --no-cache
RUN poetry install --no-cache

# 第二阶段：运行镜像
FROM python:3.12-slim

WORKDIR /app
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /app /app

# 设置默认的 cookies 文件路径
ENV COOKIES_PATH=/app/115-cookies.txt

# 暴露端口
EXPOSE 8080

# 设置启动命令
ENTRYPOINT ["p115dav"]
CMD ["--host", "0.0.0.0", "--port", "8080"]
