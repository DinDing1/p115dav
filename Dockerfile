# 使用指定版本的 Python 3.12.7 镜像（基于 Debian 12 "Bookworm"）
FROM python:3.12.7-slim-bookworm

# 设置工作目录
WORKDIR /app

# 安装系统依赖（编译工具 + lz4 系统库）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

# 复制 pyproject.toml 文件
COPY pyproject.toml ./

# 安装 Poetry（不生成虚拟环境）
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false

# 生成 poetry.lock 文件并安装项目依赖
RUN poetry lock --no-update && \
    poetry install --no-root --no-interaction --no-ansi

# 复制项目代码
COPY . .

# 安装项目本身
RUN poetry install --no-interaction --no-ansi

# 环境变量配置
ENV COOKIES_PATH=/app/115-cookies.txt \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app

# 暴露端口
EXPOSE 8080

# 启动命令
ENTRYPOINT ["p115dav"]
CMD ["--host", "0.0.0.0", "--port", "8080"]
