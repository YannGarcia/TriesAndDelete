
#include "pcap_layer.hh"

namespace comm {

    pcap_layer::pcap_layer() : _device(NULL), _pcap_h(-1) {
        char error_buffer[64];
        pcap_if_t devices = NULL;

        if (pcap_findalldevs(devices, error_buffer) == -1) {
            // Add throw exception
        }

        _pcap_h = pcap_get_selectable(_device);
        Handler_Add_Fd_Read(_pcap_h);
    }

    pcap_layer::~pcap_layer() {

    }

    void pcap_layer::Handle_Fd_Event_Readable(int fd) {

    }

}

