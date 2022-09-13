FROM alpine:latest

#add curl for better handling
RUN apk add --no-cache curl
RUN apk add linux-headers
# Update & Install dependencies
RUN apk add --no-cache --update \
    git \
    bash \
    libffi-dev \
    openssl-dev \
    bzip2-dev \
    zlib-dev \
    readline-dev \
    sqlite-dev \
    build-base

# Set pyenv home
ARG PYENV_HOME=/root/.pyenv
RUN export PYENV_HOME

# Install pyenv, then install python versions
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git

ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH

RUN pyenv install 3.7.0
RUN pyenv global 3.7.0
RUN pip install --upgrade pip && pyenv rehash
RUN pip install geoip2
RUN pip install influxdb-client

# Clean
RUN rm -rf ~/.cache/pip

# Done python3.7 setup

## setup home folder
RUN mkdir -p /root/.config/NPMGRAF

ENV NPMGRAF_HOME=/root/.config/NPMGRAF
ARG NPMGRAF_HOME=/root/.config/NPMGRAF
RUN export NPMGRAF_HOME

## exludeHOMEIps
ENV HOME_IPS="192.168.0.*\|192.168.10.*"
ARG HOME_IPS="192.168.0.*\|192.168.10.*"

## seting up influx connection
ENV INFLUX_TOKEN=admin
ARG INFLUX_TOKEN=admin

ENV INFLUX_BUCKET=DB
ARG INFLUX_BUCKET=DB

ENV INFLUX_HOST="http://localhost:8086"
ARG INFLUX_HOST="http://localhost:8086"

ENV INFLUX_ORG=default
ARG INFLUX_ORG=default

## Copy files
COPY Getipinfo.py /root/.config/NPMGRAF/Getipinfo.py
RUN chmod +x  /root/.config/NPMGRAF/Getipinfo.py

COPY sendips.sh /root/.config/NPMGRAF/sendips.sh
RUN chmod +x  /root/.config/NPMGRAF/sendips.sh

COPY start.sh /root/start.sh
RUN chmod +x  /root/start.sh

ENTRYPOINT ["/root/start.sh"]
