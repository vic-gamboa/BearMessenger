#!/bin/bash

install_script() {
    SCRIPT_NAME="bearmessenger"

    if [[ "$1" == "--local" ]]; then
        echo "Running in local mode, skipping installation."
        return
    fi

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

install_script "$1"

if [[ $(uname -m) == 'arm64' ]]; then
    APP_DIR="/opt/homebrew/bin"
else
    APP_DIR="/usr/local/bin"
fi
osascript -e "tell application \"Terminal\" to do script \"cd $APP_DIR && ./server\""

osascript -e "tell application \"Terminal\" to do script \"cd $APP_DIR && ./client\""

