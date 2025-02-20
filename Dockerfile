# 使用官方的 Python 3.12 作为基础镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . .

# 安装 Poetry
RUN pip install poetry

# 使用 Poetry 安装依赖
RUN poetry install --no-root

# 暴露端口 8000
EXPOSE 8000

# 设置环境变量
ENV PYTHONUNBUFFERED=1

# 运行应用
CMD ["poetry", "run", "p115dav", "--host", "0.0.0.0", "--port", "8000"]
