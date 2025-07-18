#!/usr/bin/with-contenv bash

# Read configuration from options.json
CONFIG_PATH="/data/options.json"

if [ -f "$CONFIG_PATH" ]; then
    DEVICE=$(jq -r '.device // "/dev/ttyUSB0"' "$CONFIG_PATH")
    MQTT_HOST=$(jq -r '.mqtt_host // "core-mosquitto"' "$CONFIG_PATH")
    MQTT_PORT=$(jq -r '.mqtt_port // 1883' "$CONFIG_PATH")
    MQTT_USER=$(jq -r '.mqtt_user // ""' "$CONFIG_PATH")
    MQTT_PASSWORD=$(jq -r '.mqtt_password // ""' "$CONFIG_PATH")
    UPDATE_INTERVAL=$(jq -r '.update_interval // 10' "$CONFIG_PATH")
else
    # Default values
    DEVICE="/dev/ttyUSB0"
    MQTT_HOST="core-mosquitto"
    MQTT_PORT="1883"
    MQTT_USER=""
    MQTT_PASSWORD=""
    UPDATE_INTERVAL="10"
fi

# Try to get MQTT credentials from services if not provided
if [ -z "$MQTT_USER" ] && [ -f "/etc/services.d/mqtt" ]; then
    MQTT_HOST="core-mosquitto"
    MQTT_PORT="1883"
    MQTT_USER="addons"
    MQTT_PASSWORD=""
fi

echo "Starting EASUN Solar Monitor..."
echo "Device: ${DEVICE}"
echo "MQTT Host: ${MQTT_HOST}:${MQTT_PORT}"
echo "Update interval: ${UPDATE_INTERVAL}s"

# Export variables for Python script
export DEVICE
export MQTT_HOST
export MQTT_PORT
export MQTT_USER
export MQTT_PASSWORD
export UPDATE_INTERVAL

# Run Python monitor
exec python3 /easun_monitor.py