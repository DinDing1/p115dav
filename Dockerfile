# 使用 Python 3.12 作为基础镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 安装系统依赖（包括编译工具）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    liblz4-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 Poetry（用于管理依赖）
RUN pip install --no-cache-dir poetry

# 配置 Poetry 不使用虚拟环境（将依赖安装到系统 Python 中）
RUN poetry config virtualenvs.create false

# 安装项目依赖
RUN poetry install --no-root

# 安装项目本身
RUN poetry install

# 暴露端口（根据 README.md 中的说明）
EXPOSE 8080

# 设置默认的 cookies 文件路径
ENV COOKIES_PATH=/app/115-cookies.txt

# 设置启动命令（允许用户通过命令行参数覆盖默认配置）
ENTRYPOINT ["p115dav"]
CMD ["--host", "0.0.0.0", "--port", "8080"]
