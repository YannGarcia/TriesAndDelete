#include "PCOType1_layer.hh"
#include "PCOCommon_layer.hh"
#include "PCOType1_codec.hh"

#include "loggers.hh"

namespace layers {

	PCOType1_layer::PCOType1_layer() : layer_interface(), _codec(*(new PCOType1_codec()))
	{
		loggers::loggers::log("PCOType1_layer::PCOType1_layer");
		_name = "PCOType1_layer::PCOType1_layer";
		PCOCommon_layer::get_instance().register_layer(this);
	}

	int PCOType1_layer::send_message(OCTETSTRING & p_payload)
	{
		loggers::loggers::log("PCOType1_layer::send");
		return PCOCommon_layer::get_instance().send_message(p_payload);
	}

	int PCOType1_layer::recv_message(const OCTETSTRING & p_payload)
	{
		loggers::loggers::log("PCOType1_layer::recv");
		apply_incoming_message(p_payload);
		return 0;
	}

} // End of namespace layers

using namespace layers;

