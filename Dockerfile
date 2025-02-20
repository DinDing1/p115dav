FROM python:3.12-slim

# 安装系统依赖
RUN apt-get update && \
    apt-get install -y libfuse2 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 复制项目文件
COPY pyproject.toml poetry.lock* ./

# 安装 Poetry 和项目依赖
RUN pip install --no-cache-dir poetry && \
    poetry install --no-root --only main && \
    pip uninstall -y poetry

# 复制项目代码
COPY . .

# 安装项目本体
RUN poetry install --only-root

EXPOSE 8000

CMD ["poetry", "run", "p115dav", "--cookies-path", "/app/115-cookies.txt"]