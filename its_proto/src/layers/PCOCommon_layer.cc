#include "PCOCommon_layer.hh"
<<<<<<< HEAD
#include "PCOCommon_codec.hh"
=======
>>>>>>> 003fccd81355db525e16e7175d4878b2af1bda0b
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
			_final_layer = new final_layer();
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

