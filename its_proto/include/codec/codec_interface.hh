#pragma once

#include <string>
#include <TTCN3.hh>

namespace codecs {

	class codec_interface {
	protected:
		std::string _name;
	  
	public:
	  	virtual std::string & to_string() { return _name; };

	}; // End of class codec_interface

} // End of namespace codecs

using namespace codecs;

