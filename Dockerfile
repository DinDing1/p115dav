# 使用 Python 3.13.2-alpine 镜像
FROM python:3.13.2-alpine

# 安装编译所需的工具和库
RUN apk update && apk add --no-cache \
    build-base \
    lz4-libs \
    openssl-dev \
    zlib-dev \
    python3-dev \
    gcc \
    libffi-dev \
    libuv-dev

# 升级 pip 并安装 setuptools 和 wheel
RUN pip install --upgrade pip setuptools wheel

# 创建工作目录
WORKDIR /app

# 安装依赖
RUN pip install p115dav

# 暴露端口 8050
EXPOSE 8091

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 启动命令
CMD ["python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8091"]