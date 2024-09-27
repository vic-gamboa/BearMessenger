#include <asio.hpp>
#include <iostream>
#include <string>
#include <thread>
#include <vector>

std::string DiscoverServer(asio::io_context &context) {
    asio::ip::udp::socket socket(
        context, asio::ip::udp::endpoint(asio::ip::udp::v4(), 12345));
    asio::ip::udp::endpoint sender_endpoint;

    std::vector<char> recv_buffer(1024);
    asio::error_code ec;
    size_t len =
        socket.receive_from(asio::buffer(recv_buffer), sender_endpoint, 0, ec);

    if (!ec) {
        std::string message(recv_buffer.begin(), recv_buffer.begin() + len);
        std::cout << "Received broadcast from server: " << message << std::endl;
        return sender_endpoint.address().to_string();
    }

    return "";
}

int main() {
    asio::io_context context;

    std::string server_ip = DiscoverServer(context);

    if (!server_ip.empty()) {
        std::cout << "Connecting to server at " << server_ip << "..."
                  << std::endl;

        asio::ip::tcp::resolver resolver(context);
        auto endpoints = resolver.resolve(server_ip, "12345");

        asio::ip::tcp::socket socket(context);
        asio::connect(socket, endpoints);

        std::cout << "Connected to the server!" << std::endl;

        std::thread readThread([&]() {
            while (socket.is_open()) {
                std::vector<char> buffer(1024);
                asio::error_code ec;
                size_t length = socket.read_some(asio::buffer(buffer), ec);
                if (!ec) {
                    std::cout
                        << "\nReceived: " << std::string(buffer.data(), length)
                        << std::endl;
                    std::cout << "Enter message: " << std::flush;
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
    } else {
        std::cout << "No server found." << std::endl;
    }

    return 0;
}
