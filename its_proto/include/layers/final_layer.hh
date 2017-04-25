#pragma once

#include "layer_interface.hh"
#include "udp.hh"

namespace layers {

	class final_layer : public Fd_Event_Handler,/*public PORT,*/ public layer_interface {
		udp & _udp;

		void Handle_Fd_Event(int fd, boolean is_readable, boolean is_writeable, boolean is_error);
	public:
		final_layer();
		~final_layer();
		int send_message(OCTETSTRING & p_payload);
		int recv_message(const OCTETSTRING & p_payload);
	}; // End of class final_layer

} // End of namespace layers

using namespace layers;

