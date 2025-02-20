# 使用 Python 3.12 官方镜像
FROM python:3.12-slim-bookworm

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 poetry 并配置
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false

# 复制项目文件
COPY ./p115dav/pyproject.toml ./p115dav/readme.md ./
COPY ./p115dav/p115dav ./p115dav

# 安装项目依赖
RUN poetry install --no-dev --no-interaction --no-ansi

# 创建非root用户
RUN useradd -m -u 1001 appuser
USER appuser

# 暴露端口
EXPOSE 8000

# 设置启动命令
CMD ["p115dav", "--host", "0.0.0.0", "--port", "8000", "--cache-url"]
