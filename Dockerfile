FROM python:3.12-slim

WORKDIR /app

# 安装系统依赖（新增liblz4-dev）
RUN apt-get update && apt-get install -y \
    curl \
    liblz4-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 安装新版Poetry
ENV POETRY_VERSION=1.8.2
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

# 复制依赖文件
COPY pyproject.toml poetry.lock* ./

# 安装项目依赖（添加额外参数）
RUN poetry config virtualenvs.create false \
    && poetry install --no-dev --no-interaction --no-ansi \
        --no-cache \
        --compile \
        --extras "full"

# 复制源代码
COPY p115dav/ ./p115dav

EXPOSE 8050

CMD ["poetry", "run", "python", "-m", "p115dav", "--host", "0.0.0.0", "--port", "8050"]