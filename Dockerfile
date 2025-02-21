# 使用Python 3.12 slim镜像
FROM python:3.12-slim

# 安装运行时依赖 和 构建依赖（构建后删除）
RUN apk update && apk add --no-cache \
    lz4-libs \
    openssl \
    zlib \
    libuv \
    # 声明构建依赖虚拟组（安装后删除）
    && apk add --no-cache --virtual .build-deps \
    build-base \
    python3-dev \
    libffi-dev \
    openssl-dev \
    zlib-dev \
    libuv-dev

# 升级 pip 并安装 Python 依赖（同时清理缓存）
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir p115dav \
    # 删除构建依赖和清理 APK 缓存
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 暴露端口 8090
EXPOSE 8090

# 启动命令
CMD ["python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8090"]
