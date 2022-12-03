FROM alpine:3.16

ARG IS_CHINA
# 支持使用中文
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN.UTF-8

RUN if [ "$IS_CHINA" == "true" ]; then sed -i 's@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g' /etc/apk/repositories; fi
RUN apk update \
    # 设置时区
    && apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata \ 
    && apk add libreoffice \
    && apk add libreoffice-lang-zh_cn \
    && apk add pandoc \
    && apk add openssl \
    && apk add go \
    && apk add openjdk11 \
    && apk add git \
    && echo "export GO111MODULE=on" >> ~/.profile \
    && echo "export GOPROXY=https://goproxy.cn" >> ~/.profile \
    && source ~/.profile

# 添加字体
RUN mkdir -p /usr/share/fonts/Fonts
COPY fonts/* /usr/share/fonts/Fonts

EXPOSE 5656