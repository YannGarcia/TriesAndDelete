#pragma once

#include "codec_interface.hh"

namespace codecs {

	class PCOType2_codec : public codec_interface {
	public:
		PCOType2_codec();
		~PCOType2_codec() {};
	}; // End of class PCOType2_codec

} // End of namespace codecs

using namespace codecs;

