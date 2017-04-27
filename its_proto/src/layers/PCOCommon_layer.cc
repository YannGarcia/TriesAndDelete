#include "PCOCommon_layer.hh"
#include "logger/logger.hh"

namespace layers {

	PCOCommon_layer * PCOCommon_layer::_PCOCommon_layer = new PCOCommon_layer();

	PCOCommon_layer::PCOCommon_layer() : layer_interface(), _final_layer(NULL)
	{
		logger::logger::log("PCOCommon_layer::PCOCommon_layer");
		_name = "PCOCommon_layer::PCOCommon_layer";
	}

	PCOCommon_layer::~PCOCommon_layer()
	{
		logger::logger::log("PCOCommon_layer::~PCOCommon_layer");
		if (_final_layer != NULL) {
			delete _final_layer;
		}
	}

	void PCOCommon_layer::register_layer(layer_interface * p_layer)
	{
		logger::logger::log("PCOCommon_layer::register_layer");
		_registered_layers.push_back(p_layer);
		if (_final_layer == NULL) {
			_final_layer = new final_layer();
			logger::logger::log("PCOCommon_layer::register_layer: register to fina_layer: %d", _registered_layers.size());
			_final_layer->register_layer(PCOCommon_layer::_PCOCommon_layer);
		}
	}

	int PCOCommon_layer::send_message(OCTETSTRING & p_payload)
	{
		logger::logger::log("PCOCommon_layer::send");
		return _final_layer->send_message(p_payload);
	}

	int PCOCommon_layer::recv_message(const OCTETSTRING & p_payload)
	{
		logger::logger::log("PCOCommon_layer::recv");
		logger::logger::log("PCOCommon_layer::recv: %d", _registered_layers.size());
		apply_incoming_message(p_payload);
		return 0;
	}

} // End of namespace layers

using namespace layers;

