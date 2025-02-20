FROM python:3.12-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装Poetry
ENV POETRY_VERSION=1.7.1
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# 复制依赖文件
COPY pyproject.toml poetry.lock* ./

# 安装项目依赖
RUN poetry config virtualenvs.create false \
    && poetry install --no-dev --no-interaction --no-ansi

# 复制源代码
COPY p115dav/ ./p115dav

# 暴露端口
EXPOSE 8050

# 启动命令
CMD ["poetry", "run", "python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8050"]