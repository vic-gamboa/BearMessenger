# Bear Messenger

This project is a simple TCP messaging application built using Asio (Standalone or Boost). It consists of a client that sends messages to a server, and the server echoes the messages back to the client.

## Features
- Supports multiple clients
- Asynchronous communication using Asio
- Simple echo server

## Requirements
- C++14 or higher
- Asio (Standalone) or Boost.Asio
- GCC/Clang/Visual Studio (for compiling)
  
## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/vic-gamboa/BearMessenger.git
2. Install necessary dependencies (e.g., Boost, Asio):
   - For Ubuntu/Linux:
     ```bash
     sudo apt install libasio-dev libboost-all-dev
     ```
   - For macOS:
     ```bash
     brew install boost asio
     ```

3. Compile the project:
   ```bash
   make
   ```

4. Run the server:
   ```bash
   ./server
   ```

5. Run the client:
   ```bash
   ./client
   ```
