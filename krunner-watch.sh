#!/bin/bash

# Define the service name
SERVICE="plasma-krunner.service"

# Define the error to look for
ERROR="eglSwapBuffers"

EMIT_LOGS=0

# Continuously monitor the logs
journalctl --user-unit=$SERVICE -f -n0 | while read -r line; do
    if echo "$line" | grep -q "$ERROR"; then
        if [ $EMIT_LOGS -eq 1 ]; then
            echo "Error '$ERROR' detected. Restarting $SERVICE..."
        fi
        systemctl --user restart $SERVICE
        sleep 0.01
        qdbus org.kde.krunner /App display
    fi
done
