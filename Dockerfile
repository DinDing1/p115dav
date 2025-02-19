FROM python:3.8-alpine

WORKDIR /app

# 安装依赖
RUN apk add --no-cache --virtual .build-deps gcc musl-dev fuse-dev

# 复制项目文件
COPY . .

# 安装Python依赖
RUN pip install --no-cache-dir -r requirements.txt . \
    && apk del .build-deps

# 设置默认Cookie文件位置（通过 -v 参数覆盖）
VOLUME /app/115-cookies.txt

EXPOSE 8000

CMD ["python", "-m", "p115dav", "--cookies-path", "/app/115-cookies.txt"]