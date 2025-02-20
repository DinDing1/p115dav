FROM python:3.12.7-slim-bookworm

# 设置版本参数
ARG DAV_VERSION
#ARG NANO_VERSION
#ARG TINY_VERSION
#ARG EMBY_VERSION
#ARG ALIST_VERSION

# 安装基础系统包和Python包
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir \
        p115dav==${DAV_VERSION} 
        #p115nano302==${NANO_VERSION} \
        #p115tiny302==${TINY_VERSION} \
        #python-emby-proxy==${EMBY_VERSION} \
        #alist_proxy==${ALIST_VERSION}

# 创建配置目录
RUN mkdir -p /config

# 设置工作目录
WORKDIR /app

# 暴露端口
EXPOSE 8090 8091

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# # 设置动态入口
# ENTRYPOINT ["python", "-m"]

# 设置默认启动命令为空，允许在运行时指定模块
CMD [""]

