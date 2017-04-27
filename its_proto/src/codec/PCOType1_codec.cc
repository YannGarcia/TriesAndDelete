#include "PCOType1_codec.hh"
#include "loggers.hh"

namespace codecs {

	PCOType1_codec::PCOType1_codec() : codec_interface()
	{
		loggers::loggers::log("PCOType1_codec::PCOType1_codec");
		_name = "PCOType1_codec::PCOType1_codec";
	}

} // End of namespace codecs

using namespace codecs;

