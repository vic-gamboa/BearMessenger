#include <asio.hpp>
#include <iostream>
#include <memory>

class SimpleServer {
  public:
    SimpleServer(asio::io_context &context, uint16_t port)
        : acceptor(context,
                   asio::ip::tcp::endpoint(asio::ip::tcp::v4(), port)) {
        StartAccept(context);
    }

  private:
    asio::ip::tcp::acceptor acceptor;
    std::vector<std::shared_ptr<asio::ip::tcp::socket>> clients;

    void StartAccept(asio::io_context &context) {
        auto socket = std::make_shared<asio::ip::tcp::socket>(context);

        acceptor.async_accept(
            *socket, [this, socket, &context](std::error_code ec) {
                if (!ec) {
                    std::cout
                        << "New connection from: " << socket->remote_endpoint()
                        << std::endl;
                    clients.push_back(socket);
                    StartReceive(socket, context);
                }

                StartAccept(context);
            });
    }

    void StartReceive(std::shared_ptr<asio::ip::tcp::socket> socket,
                      asio::io_context &context) {
        auto buffer = std::make_shared<std::vector<char>>(1024);
        socket->async_read_some(asio::buffer(*buffer), [this, socket, buffer,
                                                        &context](
                                                           std::error_code ec,
                                                           std::size_t length) {
            if (!ec) {
                std::string message(buffer->begin(), buffer->begin() + length);
                std::cout << "Received: " << message << std::endl;

                SendMessage(socket, message, context);
                StartReceive(socket, context);
            } else {
                std::cout << "Connection closed: " << ec.message() << std::endl;
                RemoveClient(socket);
            }
        });
    }

    void SendMessage(std::shared_ptr<asio::ip::tcp::socket> socket,
                     const std::string &message, asio::io_context &context) {
        auto buffer =
            std::make_shared<std::vector<char>>(message.begin(), message.end());
        asio::async_write(*socket, asio::buffer(*buffer),
                          [buffer](std::error_code ec, std::size_t length) {
                              if (!ec) {
                                  std::cout << "Sent: " << length << " bytes"
                                            << std::endl;
                              } else {
                                  std::cout << "Failed to send message: "
                                            << ec.message() << std::endl;
                              }
                          });
    }

    void RemoveClient(std::shared_ptr<asio::ip::tcp::socket> socket) {
        clients.erase(std::remove(clients.begin(), clients.end(), socket),
                      clients.end());
        std::cout << "Client removed, active clients: " << clients.size()
                  << std::endl;
    }
};

int main() {
    asio::io_context context;

    SimpleServer server(context, 12345);

    std::thread server_thread([&context]() { context.run(); });

    server_thread.join();

    return 0;
}
