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

#include "final_layer.hh"

namespace comm {

	class udp_layer : public final_layer {
	    int _socket;
	    int _port_num;
	    int _status;
	    struct sockaddr_in _local_addr;
	    struct sockaddr_in _remote_addr;

	    unsigned long get_host_id(const char* p_host_name);
	public:
		udp_layer();
		virtual ~udp_layer();

	    void Handle_Fd_Event_Readable(int fd);

		int send_message(OCTETSTRING & p_payload);
		int recv_message(const OCTETSTRING & p_payload);
	};

}

using namespace comm;
