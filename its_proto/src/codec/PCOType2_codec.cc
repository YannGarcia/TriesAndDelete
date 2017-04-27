#include "PCOType2_codec.hh"
#include "logger/logger.hh"

namespace codecs {

	PCOType2_codec::PCOType2_codec() : codec_interface()
	{
		logger::logger::log("PCOType2_codec::PCOType2_codec");
		_name = "PCOType2_codec::PCOType2_codec";
	}

} // End of namespace codecs

using namespace codecs;

