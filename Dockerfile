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
COPY . .

RUN pip install --no-cache-dir -r requirements.txt .

EXPOSE 8000

CMD ["python", "-m", "p115dav", "--cookies-path", "/app/115-cookies.txt"]