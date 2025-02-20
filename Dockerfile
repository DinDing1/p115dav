# 构建阶段
FROM python:3.12-slim as builder

# 安装编译依赖
RUN apt-get update && \
    apt-get install -y \
    gcc \
    g++ \
    libssl-dev \
    libffi-dev \
    liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 安装 Poetry 和 export 插件
RUN pip install --no-cache-dir poetry poetry-plugin-export

# 复制依赖文件
COPY pyproject.toml poetry.lock* ./

# 导出 requirements.txt
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

# 运行时阶段
FROM python:3.12-slim

WORKDIR /app

# 安装运行时系统依赖
RUN apt-get update && \
    apt-get install -y liblz4-1 && \
    rm -rf /var/lib/apt/lists/*

# 从构建阶段复制 requirements.txt
COPY --from=builder /app/requirements.txt .

# 安装 Python 依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目代码
COPY . .

EXPOSE 8000

CMD ["p115dav", "--cookies-path", "/app/115-cookies.txt"]