FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

# 升级 pip、setuptools 和 wheel
RUN pip install --upgrade pip setuptools wheel

# 安装 lz4 的预编译二进制包
RUN pip install --no-cache-dir lz4

# 复制项目文件
COPY . .

# 使用 Poetry 安装依赖
RUN poetry install --no-root

# 暴露端口 8000
EXPOSE 8000

# 运行应用
CMD ["poetry", "run", "p115dav", "--host", "0.0.0.0", "--port", "8000"]
