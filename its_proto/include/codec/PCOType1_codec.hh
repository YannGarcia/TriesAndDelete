#pragma once

#include "codec_interface.hh"

namespace codecs {

	class PCOType1_codec : public codec_interface {
	public:
		PCOType1_codec();
		~PCOType1_codec() {};
	}; // End of class PCOType1_codec

} // End of namespace codecs

using namespace codecs;

