# 使用 Python 3.12 作为基础镜像
FROM python:3.12-slim

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

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

# 设置启动命令（根据 pyproject.toml 中的脚本配置）
CMD ["p115dav", "--host", "0.0.0.0", "--port", "8080"]
