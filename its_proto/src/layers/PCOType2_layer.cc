#include "PCOType2_layer.hh"
#include "PCOCommon_layer.hh"
#include "PCOType2_codec.hh"
#include "loggers.hh"

namespace layers {

	PCOType2_layer::PCOType2_layer() : layer_interface(), _codec(*(new PCOType2_codec()))
	{
		loggers::loggers::log("PCOType2_layer::PCOType2_layer");
		_name = "PCOType2_layer::PCOType2_layer";
		PCOCommon_layer::get_instance().register_layer(this);
	}

	int PCOType2_layer::send_message(OCTETSTRING & p_payload)
	{
		loggers::loggers::log("PCOType2_layer::send");
		return PCOCommon_layer::get_instance().send_message(p_payload);
	}

	int PCOType2_layer::recv_message(const OCTETSTRING & p_payload)
	{
		loggers::loggers::log("PCOType2_layer::recv");
		apply_incoming_message(p_payload);
		return 0;
	}

} // End of namespace layers

using namespace layers;
