FROM python:3

# 拷贝文件
COPY . /env

# 下载chromedriver至可执行目录
RUN curl -SLO "http://chromedriver.storage.googleapis.com/75.0.3770.90/chromedriver_linux64.zip" \
	&& unzip "chromedriver_linux64.zip" -d /usr/local/bin \
	&& chmod 755 /usr/local/bin/chromedriver \
  	&& rm "chromedriver_linux64.zip"

# 更换apt源为阿里云源
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak \
	&& cp /env/etc/apt/sources.list /etc/apt/sources.list

# 安装google-chrome-stable所需的依赖
RUN apt update \
	&& apt install -y fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatspi2.0-0 libgtk-3-0 libnspr4 libnss3 libx11-xcb1 libxtst6 lsb-release xdg-utils

# 安装google-chrome-stable
RUN curl -SLO "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" \
	&& dpkg -i "google-chrome-stable_current_amd64.deb" \
  	&& rm "google-chrome-stable_current_amd64.deb"

# 安装python插件
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ -r /env/pip/requirements.txt