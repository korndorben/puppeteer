FROM node:9.2.0-slim

RUN apt-get update && \
apt-get install -yq vim nano gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget \
fonts-arphic-gbsn00lp fonts-arphic-gkai00mp ttf-wqy-zenhei && \
apt-get clean && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN yarn global add puppeteer && yarn cache clean

# 设置中文
ENV LANG C.UTF-8

# 安装pm2守护进程
RUN npm install pm2 -g -verbose --registry=https://registry.npm.taobao.org

# 端口
EXPOSE 3000

# 开放挂载目录
VOLUME ["/src"]

# 默认执行(可被运行时重写)
ENTRYPOINT ["pm2","start", "/src/ecosystem.config.js","--no-daemon"]
