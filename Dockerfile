FROM python:3
WORKDIR /usr/src/app
RUN pip install --upgrade pip
RUN pip install geoip2
RUN pip install influxdb-client

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
