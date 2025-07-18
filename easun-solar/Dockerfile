ARG BUILD_FROM
FROM $BUILD_FROM

# Install Python and dependencies
RUN \
    apk add --no-cache \
        python3 \
        py3-pip \
        jq \
    && pip3 install --no-cache-dir \
        pyserial==3.5 \
        paho-mqtt==1.6.1

# Copy run script and Python monitor
COPY run.sh /
COPY easun_monitor.py /

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]