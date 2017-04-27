#pragma once

#include <TTCN3.hh>

namespace loggers {

	class loggers {
	public:
		inline static void log_to_hexa(TTCN_Buffer * buffer);
		inline static void log_to_hexa(const char *prompt, const OCTETSTRING& msg);
		inline static void log(const char *fmt, ...);
	};

	void loggers::log_to_hexa(TTCN_Buffer* buffer)
	{
		int len = buffer->get_read_len();
		const unsigned char* ptr = buffer->get_read_data();
		for(int i = buffer->get_pos(); i < len; i++)
		{
			TTCN_Logger::log_event(" %02X", ptr[i]);
		}
	}

	void loggers::log_to_hexa(const char *prompt, const OCTETSTRING& msg)
	{
	  TTCN_Logger::begin_event(TTCN_DEBUG);
	  TTCN_Logger::log_event_str(prompt);
	  TTCN_Logger::log_event("Size: %d,\nMsg: ",msg.lengthof());

	  for(int i=0; i<msg.lengthof(); i++)
		TTCN_Logger::log_event(" %02x", ((const unsigned char*)msg)[i]);
	  TTCN_Logger::log_event("\n");
	  TTCN_Logger::end_event();
	}

	void loggers::log(const char *fmt, ...)
	{
		TTCN_Logger::begin_event(TTCN_DEBUG);
		va_list args;
		va_start(args, fmt);
		TTCN_Logger::log_event_va_list(fmt, args);
		va_end(args);
		TTCN_Logger::end_event();
	}

}

using namespace loggers;
