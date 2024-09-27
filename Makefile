CXX = g++ -std=c++14

BOOST_INCLUDE ?= /opt/homebrew/opt/boost/include
ASIO_INCLUDE ?= /opt/homebrew/opt/asio/include

BOOST_LIB ?= /opt/homebrew/opt/boost/lib
ASIO_LIB ?= /opt/homebrew/opt/asio/lib

CXXFLAGS = -I$(BOOST_INCLUDE) -I$(ASIO_INCLUDE) -Wall -Wextra

LDFLAGS = -L$(BOOST_LIB) -lboost_system -lboost_thread-mt

CLIENT_SRCS = ./client_app/SimpleClient.cpp
SERVER_SRCS = ./server_app/SimpleServer.cpp

CLIENT_OBJS = $(CLIENT_SRCS:.cpp=.o)
SERVER_OBJS = $(SERVER_SRCS:.cpp=.o)

CLIENT_TARGET = client
SERVER_TARGET = server

all: $(CLIENT_TARGET) $(SERVER_TARGET)

$(CLIENT_TARGET): $(CLIENT_OBJS)
	$(CXX) $(CXXFLAGS) $(CLIENT_OBJS) -o $(CLIENT_TARGET) $(LDFLAGS)

$(SERVER_TARGET): $(SERVER_OBJS)
	$(CXX) $(CXXFLAGS) $(SERVER_OBJS) -o $(SERVER_TARGET) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(CLIENT_TARGET) $(SERVER_TARGET) $(CLIENT_OBJS) $(SERVER_OBJS)

.PHONY: clean

