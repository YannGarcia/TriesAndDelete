#include <cstring>
#include <exception>
#include <stdexcept>
#include <cerrno>

#include "udp_layer.hh"

#include "loggers.hh"


namespace comm {

    udp_layer::udp_layer() : final_layer(), _socket(-1)
    {
        loggers::loggers::log("udp_layer::udp_layer");
        _name = "udp_layer::udp_layer";
        _local_addr.sin_family = AF_INET;
        _local_addr.sin_addr.s_addr = htonl(get_host_id("localhost"));
        _local_addr.sin_port = htons(12345);
        if((_socket = socket(AF_INET,SOCK_DGRAM,0)) < 0) {
            throw std::invalid_argument("::socket failure");
        }
        if(bind(_socket, (struct sockaddr *) &_local_addr, sizeof(_local_addr)) < 0) {
            throw std::invalid_argument("::bind failure");
        }
        Handler_Add_Fd_Read(_socket);
    }

    udp_layer::~udp_layer()
    {
        loggers::loggers::log("udp_layer::~udp_layer");
        Handler_Remove_Fd_Read(_socket);
        close(_socket);
        _socket = -1;
    }

    void udp_layer::Handle_Fd_Event_Readable(int fd)
    {
        loggers::loggers::log("udp_layer::Handle_Fd_Event");
        socklen_t addr_length = sizeof(_remote_addr);
        unsigned char msg[65535];        // Allocate memory for possible messages
        int msg_length = recvfrom(_socket, (char*)msg, sizeof(msg), 0, (struct sockaddr*)&_remote_addr, &addr_length);
        loggers::loggers::log("udp_layer::recv: received %d bytes", msg_length);
        if (msg_length >= 0) {
            OCTETSTRING payload(msg_length, msg);
            loggers::loggers::log("udp_layer::Handle_Fd_Event: Received %d bytes", msg_length);
            recv_message(payload);
        } else {
            loggers::loggers::error("udp_layer::Handle_Fd_Event: recvfrom failure: %s", std::strerror(errno));
        }
    }

    int udp_layer::send_message(OCTETSTRING & p_payload)
    {
        loggers::loggers::log("udp_layer::send_message");
        std::vector<unsigned char> buffer;
        const unsigned char *payload = static_cast<const unsigned char *>(p_payload);
        buffer.assign(payload, payload + p_payload.lengthof());
        _remote_addr.sin_family = AF_INET;
        _remote_addr.sin_addr.s_addr = htonl(get_host_id("localhost"));
        _remote_addr.sin_port = htons(12346);
        int bytes_sent = sendto(_socket, reinterpret_cast<const char *>(buffer.data()), buffer.size(), 0, (struct sockaddr*)&_remote_addr, sizeof(_remote_addr));
        return (bytes_sent == static_cast<int>(buffer.size())) ? 0 : -1;
    }

    int udp_layer::recv_message(const OCTETSTRING & p_payload)
    {
        loggers::loggers::log("udp_layer::recv_message");
        apply_incoming_message(p_payload);
        return 0;
    }

    unsigned long udp_layer::get_host_id(const char* p_host_name)
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
