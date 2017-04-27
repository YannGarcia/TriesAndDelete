#pragma once

#include "layer_interface.hh"
#include "codec_interface.hh"

namespace layers {

	class PCOType1_layer : public layer_interface {
		codec_interface & _codec;
	public:
		PCOType1_layer();
		~PCOType1_layer() {};
		int send_message(OCTETSTRING & p_payload);
		int recv_message(const OCTETSTRING & p_payload);
	}; // End of class PCOType1_layer

} // End of namespace layers

using namespace layers;

