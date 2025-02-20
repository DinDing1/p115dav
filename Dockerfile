# 使用 Python 3.12 作为基础镜像
FROM python:3.12-slim AS builder

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \  # 编译工具
    liblz4-dev \       # lz4 依赖
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 安装 Poetry
ENV POETRY_VERSION=1.8.2
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# 复制依赖文件
COPY pyproject.toml poetry.lock* ./

# 安装项目依赖
RUN poetry config virtualenvs.create false \
    && poetry install --only main --no-interaction --no-ansi \
        --no-cache \
        --compile

# 复制源代码
COPY p115dav/ ./p115dav

# 多阶段构建：减小最终镜像大小
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 从构建阶段复制已安装的依赖
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /app /app

# 暴露端口
EXPOSE 8050

# 启动命令
CMD ["python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8050"]