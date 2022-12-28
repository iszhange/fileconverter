FROM alpine:3.16

ARG IS_CHINA
# 支持使用中文
ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN.UTF-8

RUN if [ "$IS_CHINA" == "true" ]; then sed -i 's@dl-cdn.alpinelinux.org@mirrors.aliyun.com@g' /etc/apk/repositories; fi

RUN apk update

# 设置时区
RUN apk add tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && apk del tzdata

RUN apk add openssl \
    && apk add git \
    && apk add curl \
    && apk add freetype \
    && apk add harfbuzz \
    && apk add libstdc++ \
    && apk add nss \
    && apk add ttf-freefont \
    && apk add dumb-init

# 安装java
RUN apk add openjdk11

# 安装Go
RUN apk add go \
    && echo "export GO111MODULE=on" >> ~/.profile \
    && echo "export GOPROXY=https://goproxy.cn" >> ~/.profile \
    && source ~/.profile
    
# 安装LibreOffice
RUN apk add libreoffice \
    && apk add libreoffice-lang-zh_cn

# 安装Pandoc
RUN apk add pandoc

# 安装chromium
RUN apk add chromium

# 添加字体
RUN cd /usr/share/fonts && \
    git clone --progress --verbose https://github.com/lampnick/free-fonts.git && \
    mv free-fonts/* ./ && \
    mkfontscale && \
    mkfontdir && \
    fc-cache && \
    fc-list :lang=zh
# RUN mkdir -p /usr/share/fonts/Fonts
# COPY fonts/* /usr/share/fonts/Fonts

# ENTRYPOINT ["chromium-browser", "--headless", "--no-first-run", "---no-sandbox", "--disable-gpu", "--disable-dev-shm-usage", "--disable-setuid-sandbox", "--fast-start", "--single-process", "--disable-renderer-backgrounding", "--disable-sync", "--enable-automation", "--hide-scrollbars", "--mute-audio"]

EXPOSE 5656