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
    MQTT_BASE_TOPIC=$(jq -r '.mqtt_base_topic // "easun_solar"' "$CONFIG_PATH")
    DEVICE_ID=$(jq -r '.device_id // "easun_shm_ii_7k"' "$CONFIG_PATH")
else
    # Default values
    DEVICE="/dev/ttyUSB0"
    MQTT_HOST="core-mosquitto"
    MQTT_PORT="1883"
    MQTT_USER=""
    MQTT_PASSWORD=""
    UPDATE_INTERVAL="10"
    MQTT_BASE_TOPIC="easun_solar"
    DEVICE_ID="easun_shm_ii_7k"
fi

echo "Starting EASUN Solar Monitor..."
echo "Device: ${DEVICE}"
echo "MQTT Host: ${MQTT_HOST}:${MQTT_PORT}"
echo "MQTT Base Topic: ${MQTT_BASE_TOPIC}"
echo "Update interval: ${UPDATE_INTERVAL}s"

# Export variables for Python script
export DEVICE
export MQTT_HOST
export MQTT_PORT
export MQTT_USER
export MQTT_PASSWORD
export UPDATE_INTERVAL
export MQTT_BASE_TOPIC
export DEVICE_ID

# Run Python monitor
exec python3 /easun_monitor.py
