# 使用 Alpine 镜像作为基础
FROM python:3.13.2-alpine

# 配置工作目录
WORKDIR /app

# 安装项目依赖
RUN pip install p115dav

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 暴露端口 8090
EXPOSE 8090

# 启动命令
CMD ["python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8090"]
