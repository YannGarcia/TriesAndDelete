#pragma once

#include <pcap.h>

#include "final_layer.hh"

namespace comm {

    class pcap_layer : public final_layer {
        pcap_t *_device;
        int _pcap_h;
    public:
        pcap_layer();
        virtual ~pcap_layer();

        void Handle_Fd_Event_Readable(int fd);

        int send_message(OCTETSTRING & p_payload) { return -1; };
        int recv_message(const OCTETSTRING & p_payload) { return -1; };
    };

}


using namespace comm;
