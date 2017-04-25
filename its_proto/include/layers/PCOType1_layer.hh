#pragma once

#include "layer_interface.hh"

namespace layers {

	class PCOType1_layer : public layer_interface {
	public:
		PCOType1_layer();
		~PCOType1_layer() {};
		int send_message(OCTETSTRING & p_payload);
		int recv_message(const OCTETSTRING & p_payload);
	}; // End of class PCOType1_layer

} // End of namespace layers

using namespace layers;

