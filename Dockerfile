# 使用官方的 Python 3.12 作为基础镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

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
RUN poetry install --no-root --no-cache

# 安装项目本身
RUN poetry install --no-cache

# 暴露端口 8000
EXPOSE 8000

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 运行应用
CMD [""]
