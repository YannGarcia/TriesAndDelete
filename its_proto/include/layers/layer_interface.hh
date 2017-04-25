#pragma once

#include <vector>
#include <string>
#include <TTCN3.hh>

namespace layers {

	class layer_interface {
	protected:
		std::string _name;
		std::vector<layer_interface *> _registered_layers; // Use a std::map<std::string, layer_interface *>

	public:
	    layer_interface() : _registered_layers() { _name = "layers::final_layer::final_layer"; };
	    virtual ~layer_interface() {};
		virtual inline void register_layer(layer_interface * p_layer) { _registered_layers.push_back(p_layer); };
		virtual int send_message(OCTETSTRING & p_payload) = 0;
		virtual int recv_message(const OCTETSTRING & p_payload) = 0;

		virtual inline void apply_incoming_message(const OCTETSTRING & p_payload) {
			for (std::vector<layer_interface *>::iterator it = _registered_layers.begin(); it != _registered_layers.end(); ++it) {
				(*it)->recv_message(p_payload);
			} // End of 'for' statement
		}
		virtual std::string & to_string() { return _name; };

	}; // End of class layer_interface

} // End of namespace layers

using namespace layers;

