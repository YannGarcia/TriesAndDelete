// This Test Port skeleton header file was generated by the
// TTCN-3 Compiler of the TTCN-3 Test Executor version CRL 113 200/6 R1A
// for U-yann-FSCOM\yann (yann@yann-FSCOM) on Thu Apr 20 16:20:30 2017

// Copyright (c) 2000-2017 Ericsson Telecom AB

// You may modify this file. Add your attributes and prototypes of your
// member functions here.

#pragma once

#include <map>

#include "MyExample.hh"

#include "PCOType2_layer.hh"

namespace MyExample {

class PCOType2 : public PCOType2_BASE, public layer_interface {
    layer_interface * _layer;
    std::map<std::string, std::string> _parms;
public:
    PCOType2(const char *par_port_name = NULL);
    ~PCOType2();

    void set_parameter(const char *parameter_name,
        const char *parameter_value);

    virtual int send_message(OCTETSTRING & p_payload);
    virtual int recv_message(const OCTETSTRING & p_payload);

private:
    /* void Handle_Fd_Event(int fd, boolean is_readable,
        boolean is_writable, boolean is_error); */
    void Handle_Fd_Event_Error(int fd);
    void Handle_Fd_Event_Writable(int fd);
    void Handle_Fd_Event_Readable(int fd);
    /* void Handle_Timeout(double time_since_last_call); */
protected:
    void user_map(const char *system_port);
    void user_unmap(const char *system_port);

    void user_start();
    void user_stop();

    void outgoing_send(const CHARSTRING& send_par);
};

} /* end of namespace */
