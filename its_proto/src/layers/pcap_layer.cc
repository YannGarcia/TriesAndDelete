#include <cstring>
#include <exception>
#include <stdexcept>
#include <cerrno>


#include "pcap_layer.hh"

#include "loggers.hh"

namespace comm {

    pcap_layer::pcap_layer() : _device(NULL), _pcap_h(-1) {
        loggers::loggers::log("pcap_layer::pcap_layer");
        char error_buffer[PCAP_ERRBUF_SIZE];
        pcap_if_t *devices = NULL;
	std::string device_id("enp0s3");

        if (pcap_findalldevs(&devices, error_buffer) == -1) {
	  throw std::invalid_argument("::pcap_findalldevs");
        }

	// Print the list to user
	// so that a choice can be
	// made
	for(pcap_if_t *d = devices; d != NULL; d = d->next) {
	    if (device_id.compare(d->name) == 0) {
	      break;
	    }
	} // End of 'for' statement
	pcap_freealldevs(devices);
	
	// Fetch the network address and network mask
	bpf_u_int32 pMask;            /* subnet mask */
	bpf_u_int32 pNet;             /* ip address*/
	pcap_lookupnet(device_id.c_str(), &pNet, &pMask, error_buffer);
	loggers::loggers::log("Device %s Network address: %d", device_id.c_str(), pNet);
	_device = pcap_open_live(device_id.c_str(), 65536, 1, 1000, error_buffer);
	if (_device == NULL) {
	  loggers::loggers::log("::pcap_open_live failed: %s", error_buffer);
	  throw std::invalid_argument("::pcap_open_live");
	}
	loggers::loggers::log("Device is opened");

	pcap_setnonblock(_device, 1, error_buffer);
        _pcap_h = pcap_get_selectable_fd(_device);
        Handler_Add_Fd_Read(_pcap_h);
    }

    pcap_layer::~pcap_layer() {
      if (_device != NULL) {
	pcap_close(_device);
      }
    }

    void pcap_layer::Handle_Fd_Event_Readable(int fd) {
        loggers::loggers::log("pcap_layer::Handle_Fd_Event_Readable");
	struct pcap_pkthdr *pkt_header;
	const u_char *pkt_data;
        pcap_next_ex(_device, &pkt_header, &pkt_data);
	
        loggers::loggers::log("pcap_layer::Handle_Fd_Event_Readable: %.6d - %d", pkt_header->ts.tv_usec, pkt_header->len);
    }

}

