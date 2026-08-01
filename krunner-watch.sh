#!/bin/bash

# Define the service name
SERVICE="plasma-krunner.service"

# Define the error to look for
ERROR="eglSwapBuffers"

EMIT_LOGS=0

QDBUS_BINARY=""

function pick_qdbus_binary(){
    QDBUS_BINARIES=("qdbus" "qdbus6")

    for BINARY in "${QDBUS_BINARIES[@]}"; do
        eval "$BINARY" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            QDBUS_BINARY="${BINARY}"
            return 0
        fi
    done

}

pick_qdbus_binary

if [[ -z "$QDBUS_BINARY" ]]; then
    echo "Failed to find functional qdbus installation. Check if required packages are installed."
    exit 1
fi


if [ $EMIT_LOGS -eq 1 ]; then
    echo "Using $QDBUS_BINARY"
fi

# Continuously monitor the logs
journalctl --user-unit=$SERVICE -f -n0 | while read -r line; do
    if echo "$line" | grep -q "$ERROR"; then
        if [ $EMIT_LOGS -eq 1 ]; then
            echo "Error '$ERROR' detected. Restarting $SERVICE..."
        fi
        systemctl --user restart $SERVICE
        sleep 0.01
        "$QDBUS_BINARY" org.kde.krunner /App display
    fi
done
