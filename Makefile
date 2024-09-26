# Compiler to use
CXX = g++ -std=c++14

# Paths for Boost and Asio installed via Homebrew
BOOST_INCLUDE ?= /opt/homebrew/opt/boost/include
ASIO_INCLUDE ?= /opt/homebrew/opt/asio/include

BOOST_LIB ?= /opt/homebrew/opt/boost/lib
ASIO_LIB ?= /opt/homebrew/opt/asio/lib

# Compiler flags (e.g., include paths for Asio and Boost)
CXXFLAGS = -I$(BOOST_INCLUDE) -I$(ASIO_INCLUDE)

# Linker flags (linking Boost.System and Boost.Thread libraries)
LDFLAGS = -L$(BOOST_LIB) -lboost_system -lboost_thread-mt

# Source files
CLIENT_SRCS = ./client_app/SimpleClient.cpp
SERVER_SRCS = ./server_app/SimpleServer.cpp

# Output binaries
CLIENT_TARGET = client
SERVER_TARGET = server

all: $(CLIENT_TARGET) $(SERVER_TARGET)

# Build the client
$(CLIENT_TARGET): $(CLIENT_SRCS)
	$(CXX) $(CXXFLAGS) $(CLIENT_SRCS) -o $(CLIENT_TARGET) $(LDFLAGS)

# Build the server
$(SERVER_TARGET): $(SERVER_SRCS)
	$(CXX) $(CXXFLAGS) $(SERVER_SRCS) -o $(SERVER_TARGET) $(LDFLAGS)

# Clean up the binaries
clean:
	rm -f $(CLIENT_TARGET) $(SERVER_TARGET)

