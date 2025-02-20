# 构建阶段
FROM python:3.12-slim as builder

WORKDIR /app

# 安装 Poetry 和 export 插件
RUN pip install --no-cache-dir poetry poetry-plugin-export

# 复制依赖文件
COPY pyproject.toml poetry.lock* ./

# 导出 requirements.txt
RUN poetry export -f requirements.txt --output requirements.txt --without-hashes

# 运行时阶段
FROM python:3.12-slim

WORKDIR /app

# 从构建阶段复制 requirements.txt
COPY --from=builder /app/requirements.txt .

# 安装运行时依赖
RUN pip install --no-cache-dir -r requirements.txt

# 复制项目代码
COPY . .

EXPOSE 8000

CMD ["p115dav", "--cookies-path", "/app/115-cookies.txt"]