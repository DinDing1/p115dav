FROM python:3.12-slim

# 安装系统依赖及配置环境
RUN apt-get update && apt-get install -y --no-install-recommends gcc python3-dev \
    && rm -rf /var/lib/apt/lists/*
RUN pip install poetry --no-cache-dir \
    && poetry config virtualenvs.create false

WORKDIR /app
COPY pyproject.toml poetry.lock* ./

# 安装项目依赖
RUN poetry install --no-dev --no-interaction

# 部署项目代码
COPY p115dav/ p115dav/

EXPOSE 8000
CMD ["p115dav", "--cookies-path", "/app/115-cookies.txt"]
