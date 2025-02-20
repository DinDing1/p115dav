# 使用 Alpine 镜像作为基础
FROM python:3.13.2-alpine

# 升级 pip 并安装 Python 依赖（同时清理缓存）
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir p115dav \
    # 删除构建依赖和清理 APK 缓存
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

# 配置工作目录和启动命令
WORKDIR /app

# 暴露端口 8091
EXPOSE 8091

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 启动命令
CMD ["python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8091"]