#pragma once

#include <vector>

#include "layer_interface.hh"
#include "codec_interface.hh"

namespace layers {

	class PCOCommon_layer : public layer_interface {
		layer_interface * _final_layer;
		codec_interface & _codec;
		static PCOCommon_layer * _PCOCommon_layer;

		PCOCommon_layer(); // Singleton
	public:
		~PCOCommon_layer();
		inline static PCOCommon_layer & get_instance() {return *_PCOCommon_layer;};
		void register_layer(layer_interface * p_layer);
		int send_message(OCTETSTRING & p_payload);
		int recv_message(const OCTETSTRING & p_payload);
	}; // End of class PCOCommon_layer

} // End of namespace layers

using namespace layers;

