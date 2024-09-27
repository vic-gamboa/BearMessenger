#!/bin/bash

install_script() {
    SCRIPT_NAME="bearmessenger"
    
    # Detect if this is an ARM-based Mac (M1/M2) or Intel-based
    if [[ $(uname -m) == 'arm64' ]]; then
        INSTALL_DIR="/opt/homebrew/bin"
    else
        INSTALL_DIR="/usr/local/bin"
    fi

    TARGET_PATH="$INSTALL_DIR/$SCRIPT_NAME"
    
    if [[ $0 != "$TARGET_PATH" ]]; then
        echo "The script is not in $INSTALL_DIR. Attempting to move it there..."
        sudo mv "$0" "$TARGET_PATH" && sudo chmod +x "$TARGET_PATH"
        
        if [[ $? -eq 0 ]]; then
            echo "Successfully moved to $INSTALL_DIR. You can now run '$SCRIPT_NAME' from anywhere."
            exit 0
        else
            echo "Failed to move the script to $INSTALL_DIR."
            exit 1
        fi
    fi
}

install_script

APP_DIR="$(cd "$(dirname "$0")" && pwd)"

osascript -e "tell application \"Terminal\" to do script \"cd $APP_DIR && ./server\""

osascript -e "tell application \"Terminal\" to do script \"cd $APP_DIR && ./client\""

