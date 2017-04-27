#include "PCOCommon_codec.hh"
#include "logger/logger.hh"

namespace codecs {

	PCOCommon_codec::PCOCommon_codec() : codec_interface()
	{
		logger::logger::log("PCOCommon_codec::PCOCommon_codec");
		_name = "PCOCommon_codec::PCOCommon_codec";
	}

} // End of namespace codecs

using namespace codecs;

