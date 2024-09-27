# Bear Messenger

This project is a simple TCP messaging application built using Asio. It consists of a client that sends messages to a server, and the server echoes the messages back to the client.

## Features
- Supports multiple clients
- Asynchronous communication using Asio
- Simple echo server
- Easy installation via Homebrew

## Requirements
- C++14 or higher
- Asio (Standalone) or Boost.Asio (Handled automatically if installed via Homebrew)
- GCC/Clang (for compiling)

## Installation

### Option 1: Install via Homebrew

1. Tap the repository and install Bear Messenger:
   ```bash
   brew tap vic-gamboa/bearmessenger
   brew install bearmessenger
   ```

   This will automatically install Bear Messenger along with its dependencies (Boost and Asio) via Homebrew.

2. Run the server and client:
   - To run the server:
     ```bash
     bearmessenger server
     ```

   - To run the client:
     ```bash
     bearmessenger client
     ```

   The `bearmessenger` command will launch both server and client terminals automatically based on the script.

## Usage

Once both the server and client are running, you can send messages from the client to the server, and the server will echo them back to the client.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
