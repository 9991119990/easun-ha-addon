ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python and dependencies
RUN \
    apk add --no-cache \
        python3 \
        py3-pip \
        py3-serial \
    && pip3 install --no-cache-dir \
        paho-mqtt==1.6.1 \
        bashio==0.15.0

# Copy run script and Python monitor
COPY run.sh /
COPY easun_monitor.py /

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]