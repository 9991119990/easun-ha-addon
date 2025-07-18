#!/usr/bin/with-contenv bashio

# Get configuration
DEVICE=$(bashio::config 'device')
MQTT_HOST=$(bashio::config 'mqtt_host')
MQTT_PORT=$(bashio::config 'mqtt_port')
MQTT_USER=$(bashio::config 'mqtt_user')
MQTT_PASSWORD=$(bashio::config 'mqtt_password')
UPDATE_INTERVAL=$(bashio::config 'update_interval')

# If MQTT credentials not provided, try to get from services
if bashio::var.is_empty "${MQTT_USER}"; then
    if bashio::services.available "mqtt"; then
        MQTT_HOST=$(bashio::services "mqtt" "host")
        MQTT_PORT=$(bashio::services "mqtt" "port")
        MQTT_USER=$(bashio::services "mqtt" "username")
        MQTT_PASSWORD=$(bashio::services "mqtt" "password")
    fi
fi

bashio::log.info "Starting EASUN Solar Monitor..."
bashio::log.info "Device: ${DEVICE}"
bashio::log.info "MQTT Host: ${MQTT_HOST}:${MQTT_PORT}"
bashio::log.info "Update interval: ${UPDATE_INTERVAL}s"

# Export variables for Python script
export DEVICE
export MQTT_HOST
export MQTT_PORT
export MQTT_USER
export MQTT_PASSWORD
export UPDATE_INTERVAL

# Run Python monitor
exec python3 /easun_monitor.py