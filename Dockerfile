FROM python:3.8-alpine

WORKDIR /app

# 安装系统依赖 (分为编译时和运行时)
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    python3-dev \
    fuse-dev \
    && apk add --no-cache \
    libstdc++ \
    libgomp

# 复制项目文件
COPY . .

# 安装 Python 依赖 (分步调试)
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir wheel && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir . && \
    apk del .build-deps

EXPOSE 8000

CMD ["python", "-m", "p115dav", "--cookies-path", "/app/115-cookies.txt"]