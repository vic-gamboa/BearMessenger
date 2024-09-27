#!/bin/bash

install_script() {
    SCRIPT_NAME="bear"
    TARGET_PATH="/usr/local/bin/$SCRIPT_NAME"
    
    if [[ $0 != "$TARGET_PATH" ]]; then
        echo "The script is not in /usr/local/bin. Attempting to move it there..."
        sudo mv "$0" "$TARGET_PATH" && sudo chmod +x "$TARGET_PATH"
        
        if [[ $? -eq 0 ]]; then
            echo "Successfully moved to /usr/local/bin. You can now run 'bear' from anywhere."
            exit 0
        else
            echo "Failed to move the script to /usr/local/bin."
            exit 1
        fi
    fi
}

install_script

APP_DIR="$(cd "$(dirname "$0")" && pwd)"

osascript -e "tell application \"Terminal\" to do script \"cd $APP_DIR && ./server\""

osascript -e "tell application \"Terminal\" to do script \"cd $APP_DIR && ./client\""

