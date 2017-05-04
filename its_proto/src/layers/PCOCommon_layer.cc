#include "PCOCommon_layer.hh"
#include "PCOCommon_codec.hh"
#include "udp_layer.hh"
#include "pcap_layer.hh"
#include "loggers.hh"

namespace layers {

    PCOCommon_layer * PCOCommon_layer::_PCOCommon_layer = new PCOCommon_layer();

    PCOCommon_layer::PCOCommon_layer() : layer_interface(), _final_layer(NULL), _codec(*(new PCOCommon_codec()))
    {
        loggers::loggers::log("PCOCommon_layer::PCOCommon_layer");
        _name = "PCOCommon_layer::PCOCommon_layer";
    }

    PCOCommon_layer::~PCOCommon_layer()
    {
        loggers::loggers::log("PCOCommon_layer::~PCOCommon_layer");
        if (_final_layer != NULL) {
            delete _final_layer;
        }
    }

    void PCOCommon_layer::register_layer(layer_interface * p_layer)
    {
        loggers::loggers::log("PCOCommon_layer::register_layer");
        _registered_layers.push_back(p_layer);
        if (_final_layer == NULL) {
	  //            _final_layer = new udp_layer();
            _final_layer = new pcap_layer();
            loggers::loggers::log("PCOCommon_layer::register_layer: register to final_layer: %d", _registered_layers.size());
            _final_layer->register_layer(PCOCommon_layer::_PCOCommon_layer);
        }
    }

    int PCOCommon_layer::send_message(OCTETSTRING & p_payload)
    {
        loggers::loggers::log("PCOCommon_layer::send");
        return _final_layer->send_message(p_payload);
    }

    int PCOCommon_layer::recv_message(const OCTETSTRING & p_payload)
    {
        loggers::loggers::log("PCOCommon_layer::recv");
        loggers::loggers::log("PCOCommon_layer::recv: %d", _registered_layers.size());
        apply_incoming_message(p_payload);
        return 0;
    }

} // End of namespace layers

using namespace layers;

