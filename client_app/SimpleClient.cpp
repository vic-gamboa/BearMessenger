#include <asio.hpp>
#include <iostream>
#include <thread>

int main() {
    asio::io_context context;

    asio::ip::tcp::resolver resolver(context);
    auto endpoints = resolver.resolve("127.0.0.1", "12345");

    asio::ip::tcp::socket socket(context);
    asio::connect(socket, endpoints);

    std::cout << "Connected to the server!" << std::endl;

    std::thread readThread([&]() {
        while (socket.is_open()) {
            std::vector<char> buffer(1024);
            asio::error_code ec;
            size_t length = socket.read_some(asio::buffer(buffer), ec);
            if (!ec) {
                std::cout << "Received: " << std::string(buffer.data(), length)
                          << std::endl;
            } else {
                std::cout << "Connection closed by server: " << ec.message()
                          << std::endl;
                break;
            }
        }
    });

    std::string message;
    while (socket.is_open()) {
        std::cout << "Enter message: ";
        std::getline(std::cin, message);

        if (message == "exit") {
            break;
        }

        asio::write(socket, asio::buffer(message));
    }

    socket.close();
    readThread.join();

    return 0;
}
