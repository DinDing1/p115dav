FROM python:3.8-slim

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y \
    gcc \
    python3-dev \
    libfuse2 \
    libjpeg-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 复制项目文件
COPY . .

# 仅安装 requirements 中的依赖
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

# 直接运行模块（无需安装项目）
CMD ["python", "-m", "p115dav", "--cookies-path", "/app/115-cookies.txt"]