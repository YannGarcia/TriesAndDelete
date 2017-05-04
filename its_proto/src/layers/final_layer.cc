#include "final_layer.hh"
#include "loggers.hh"

namespace layers {

	final_layer::final_layer() : PORT("final_layer"), layer_interface()
	{
		loggers::loggers::log("final_layer::final_layer");
		_name = "final_layer::final_layer";
	}

	final_layer::~final_layer()
	{
		loggers::loggers::log("final_layer::~final_layer");
	}

//    void final_layer::Handle_Fd_Event_Readable(int fd)
//	{
//		loggers::loggers::log("final_layer::Handle_Fd_Event");
//		std::vector<unsigned char> buffer;
//		_udp.recv(buffer);
//		OCTETSTRING payload(buffer.size(), buffer.data());
//		loggers::loggers::log("final_layer::Handle_Fd_Event: Received %d bytes", buffer.size());
//		recv_message(payload);
//	}

//	int final_layer::send_message(OCTETSTRING & p_payload)
//	{
//		loggers::loggers::log("final_layer::send");
//		std::vector<unsigned char> buffer;
//		const unsigned char *payload = static_cast<const unsigned char *>(p_payload);
//		buffer.assign(payload, payload + p_payload.lengthof());
//		return _udp.send(buffer);
//	}

//	int final_layer::recv_message(const OCTETSTRING & p_payload)
//	{
//		loggers::loggers::log("final_layer::recv");
//		loggers::loggers::log("final_layer::recv: %d", _registered_layers.size());
//		apply_incoming_message(p_payload);
//		return 0;
//	}

} // End of namespace layers

using namespace layers;

