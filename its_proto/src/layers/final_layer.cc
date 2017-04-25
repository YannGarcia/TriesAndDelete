#include <vector>

#include "final_layer.hh"
#include "PCOCommon_layer.hh"
#include "logger.hh"

#include </home/ubuntu/frameworks/titan/titan.core/core/Fd_And_Timeout_User.hh>

namespace layers {

	final_layer::final_layer() : /*PORT(NULL),*/Fd_Event_Handler(), layer_interface(), _udp(*(new udp()))
	{
		logger::logger::log("final_layer::final_layer");
		_name = "final_layer::final_layer";
		Fd_And_Timeout_User::add_fd(_udp.get_socket(), this, FD_EVENT_RD);
	}

	final_layer::~final_layer()
	{
		logger::logger::log("final_layer::~final_layer");
		Fd_And_Timeout_User::remove_fd(_udp.get_socket(), this,
		    static_cast<fd_event_type_enum>(
		    static_cast<int>(FD_EVENT_RD | FD_EVENT_WR | FD_EVENT_ERR)));
	}

	void final_layer::Handle_Fd_Event(int fd, boolean is_readable, boolean is_writable, boolean is_error)
	{
		logger::logger::log("final_layer::Handle_Fd_Event");
		std::vector<unsigned char> buffer;
		_udp.recv(buffer);
		OCTETSTRING payload(buffer.size(), buffer.data());
		logger::logger::log("final_layer::Handle_Fd_Event: Received %d bytes", buffer.size());
		recv_message(payload);
	}

	int final_layer::send_message(OCTETSTRING & p_payload)
	{
		logger::logger::log("final_layer::send");
		std::vector<unsigned char> buffer;
		const unsigned char *payload = static_cast<const unsigned char *>(p_payload);
		buffer.assign(payload, payload + p_payload.lengthof());
		return _udp.send(buffer);
	}

	int final_layer::recv_message(const OCTETSTRING & p_payload)
	{
		logger::logger::log("final_layer::recv");
		logger::logger::log("final_layer::recv: %d", _registered_layers.size());
		apply_incoming_message(p_payload);
		return 0;
	}

} // End of namespace layers

using namespace layers;

