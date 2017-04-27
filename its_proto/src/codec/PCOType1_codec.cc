#include "PCOType1_codec.hh"
#include "logger/logger.hh"

namespace codecs {

	PCOType1_codec::PCOType1_codec() : codec_interface()
	{
		logger::logger::log("PCOType1_codec::PCOType1_codec");
		_name = "PCOType1_codec::PCOType1_codec";
	}

} // End of namespace codecs

using namespace codecs;

