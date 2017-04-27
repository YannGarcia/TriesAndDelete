#include <cstring>
#include <exception>
#include <stdexcept>

#include "udp.hh"

#include "logger/logger.hh"


namespace comm {

	udp::udp() : _socket(-1)
	{
		logger::logger::log("udp::udp");
		_local_addr.sin_family = AF_INET;
		_local_addr.sin_addr.s_addr = htonl(get_host_id("localhost"));
		_local_addr.sin_port = htons(12345);
		if((_socket = socket(AF_INET,SOCK_DGRAM,0)) < 0) {
			throw std::invalid_argument("::socket failure");
		}
		if(bind(_socket, (struct sockaddr *) &_local_addr, sizeof(_local_addr)) < 0) {
			throw std::invalid_argument("::bind failure");
		}
	}

	udp::~udp()
	{
		logger::logger::log("udp::~udp");
		close(_socket);
		_socket = -1;
	}

	int udp::send(std::vector<unsigned char> & p_buffer)
	{
		logger::logger::log("udp::send");
		_remote_addr.sin_family = AF_INET;
		_remote_addr.sin_addr.s_addr = htonl(get_host_id("localhost"));
		_remote_addr.sin_port = htons(12346);

		int bytes_sent = sendto(_socket, reinterpret_cast<const char *>(p_buffer.data()), p_buffer.size(), 0, (struct sockaddr*)&_remote_addr, sizeof(_remote_addr));
		return (bytes_sent == static_cast<int>(p_buffer.size())) ? 0 : -1;
	}

	int udp::recv(std::vector<unsigned char> & p_buffer)
	{
		logger::logger::log("udp::recv");
		unsigned char msg[65535];        // Allocate memory for possible messages
		int msg_length;
		socklen_t addr_length = sizeof(_remote_addr);
		msg_length = recvfrom(_socket, (char*)msg, sizeof(msg), 0, (struct sockaddr*)&_remote_addr, &addr_length);
		p_buffer.assign(msg, msg + msg_length);
		logger::logger::log("udp::recv: received %d bytes", p_buffer.size());
		return 0;
	}

	unsigned long udp::get_host_id(const char* p_host_name)
	{
	    unsigned long ip_address = 0;

	    if(strcmp(p_host_name, "255.255.255.255") == 0) {
	        ip_address = 0xffffffff;
	    } else {
	        in_addr_t addr = inet_addr(p_host_name);
	        if (addr != (in_addr_t) - 1) {     // host name in XX:XX:XX:XX form
	            ip_address = addr;
	        } else {                               // host name in domain.com form
	            struct hostent* hptr;
	            if ((hptr = gethostbyname(p_host_name)) == 0)
	        	    throw std::invalid_argument("::gethostbyname failure");
	            ip_address = *((unsigned long*)hptr->h_addr_list[0]);
	        }
	    }
	    return htonl(ip_address);
	}
}
