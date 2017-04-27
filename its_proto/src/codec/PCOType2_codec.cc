#include "PCOType2_codec.hh"
#include "loggers.hh"

namespace codecs {

	PCOType2_codec::PCOType2_codec() : codec_interface()
	{
		loggers::loggers::log("PCOType2_codec::PCOType2_codec");
		_name = "PCOType2_codec::PCOType2_codec";
	}

} // End of namespace codecs

using namespace codecs;

