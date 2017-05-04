#pragma once

#include "layer_interface.hh"

namespace layers {

  class final_layer : public PORT, public layer_interface {

    virtual void Handle_Fd_Event_Readable(int fd) {};
 
	public:
		final_layer();
		~final_layer();
		virtual int send_message(OCTETSTRING & p_payload) { return -1; };
		virtual int recv_message(const OCTETSTRING & p_payload) { return -1; };
	}; // End of class final_layer

} // End of namespace layers

using namespace layers;

