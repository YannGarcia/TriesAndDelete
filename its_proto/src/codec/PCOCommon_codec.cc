#include "PCOCommon_codec.hh"
#include "loggers.hh"

namespace codecs {

	PCOCommon_codec::PCOCommon_codec() : codec_interface()
	{
		loggers::loggers::log("PCOCommon_codec::PCOCommon_codec");
		_name = "PCOCommon_codec::PCOCommon_codec";
	}

} // End of namespace codecs

using namespace codecs;

