#pragma once

#include <vector>

#include <netdb.h>
#include <stdio.h>
#include <unistd.h>
#include <memory.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

namespace comm {

	class udp {
	    int _socket;
	    int _port_num;
	    int _status;
	    struct sockaddr_in _local_addr;
	    struct sockaddr_in _remote_addr;

	    unsigned long get_host_id(const char* p_host_name);
	public:
		udp();
		virtual ~udp();

		int send(std::vector<unsigned char> & p_buffer);
		int recv(std::vector<unsigned char> & p_buffer);

		inline int get_socket() { return _socket; };
	};

}

using namespace comm;
