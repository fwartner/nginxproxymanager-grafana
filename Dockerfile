FROM python:3

RUN pip install --upgrade pip
RUN pip install geoip2
RUN pip install influxdb-client

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
COPY Getipinfo.py /usr/src/app/Getipinfo.py
RUN chmod +x  /usr/src/app/Getipinfo.py

COPY sendips.sh /usr/src/app/sendips.sh
RUN chmod +x  /usr/src/app/sendips.sh

COPY start.sh /usr/src/app/start.sh
RUN chmod +x  /usr/src/app/start.sh

ENTRYPOINT ["/usr/src/app/start.sh"]
