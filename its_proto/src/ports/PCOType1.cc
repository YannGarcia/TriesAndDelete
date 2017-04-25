// This Test Port skeleton source file was generated by the
// TTCN-3 Compiler of the TTCN-3 Test Executor version CRL 113 200/6 R1A
// for U-yann-FSCOM\yann (yann@yann-FSCOM) on Thu Apr 20 16:20:30 2017

// Copyright (c) 2000-2017 Ericsson Telecom AB

// You may modify this file. Complete the body of empty functions and
// add your member functions here.

#include "PCOType1.hh"
#include "logger.hh"

namespace MyExample {

PCOType1::PCOType1(const char *par_port_name)
	: PCOType1_BASE(par_port_name), layer_interface(), _layer(NULL)
{
	logger::logger::log("PCOType1::PCOType1");
	_name = "PCOType1::PCOType1";
}

PCOType1::~PCOType1()
{
	if (_layer != NULL) {
		delete _layer;
	}
}

void PCOType1::set_parameter(const char * parameter_name, const char * parameter_value)
{
	logger::logger::log("PCOType1::set_parameter (%s, %s)", parameter_name, parameter_value);

}

/*void PCOType1::Handle_Fd_Event(int fd, boolean is_readable,
	boolean is_writable, boolean is_error) {}*/

void PCOType1::Handle_Fd_Event_Error(int /*fd*/)
{

}

void PCOType1::Handle_Fd_Event_Writable(int /*fd*/)
{

}

void PCOType1::Handle_Fd_Event_Readable(int /*fd*/)
{

}

/*void PCOType1::Handle_Timeout(double time_since_last_call) {}*/

void PCOType1::user_map(const char * system_port)
{
	logger::logger::log("PCOType1::user_map %s", system_port);
	_layer = new PCOType1_layer();
	_layer->register_layer(this);
}

void PCOType1::user_unmap(const char * system_port)
{
	logger::logger::log("PCOType1::user_unmap %s", system_port);
	// TODO unregister_layer(this);
	if (_layer != NULL) {
		delete _layer;
		_layer = NULL;
	}
}

void PCOType1::user_start()
{

}

void PCOType1::user_stop()
{

}

void PCOType1::outgoing_send(const CHARSTRING& send_par)
{
	logger::logger::log("PCOType1::outgoing_send");
	// TODO encode
	OCTETSTRING os(send_par.lengthof(), (const unsigned char*)(const char *)send_par);
	send_message(os/*additional params*/);
}

int PCOType1::send_message(OCTETSTRING & p_payload)
{
	logger::logger::log("PCOType1::send");
	return _layer->send_message(p_payload/*additional params*/);
}

int PCOType1::recv_message(const OCTETSTRING & p_payload)
{
	logger::logger::log("PCOType1::recv");
	// TODO decode
	CHARSTRING cs(p_payload.lengthof(), (const char *)(const unsigned char*)p_payload);
	incoming_message(cs);
	return 0;
}

} /* end of namespace */

