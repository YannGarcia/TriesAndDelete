// This Test Port skeleton header file was generated by the
// TTCN-3 Compiler of the TTCN-3 Test Executor version CRL 113 200/5 R3A
// for U-ERICSSON\ethgry (ethgry@HU00078339) on Fri Aug 14 21:19:06 2015

// Copyright Ericsson Telecom AB 2000-2014

// You may modify this file. Add your attributes and prototypes of your
// member functions here.

#ifndef BtpPort_HH
#define BtpPort_HH

#include "Btp_TestSystem.hh"

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

namespace Btp__TestSystem {

    class BtpPort: public BtpPort_BASE {
        public:
            BtpPort(const char *par_port_name = NULL);
            ~BtpPort();

            void set_parameter(const char *parameter_name, const char *parameter_value);
            void Event_Handler(const fd_set *read_fds, const fd_set */*write_fds*/, const fd_set */*error_fds*/, double /*time_since_last_call*/);

        private:
            void Handle_Fd_Event_Error(int fd);
            void Handle_Fd_Event_Writable(int fd);
            void Handle_Fd_Event_Readable(int fd);
            /* void Handle_Timeout(double time_since_last_call); */
        protected:
            void user_map(const char *system_port);
            void user_unmap(const char *system_port);

            void user_start();
            void user_stop();

            void outgoing_send(const BtpReq& send_par);

        private:
            bool is_port_mapped;
            bool debugging;
            int target_fd;
            struct sockaddr_in local_address;

            void log(const char *fmt, ...);
            void logHex(const char *prompt, const OCTETSTRING& msg);
            void init_socket();
            void close_socket();
            unsigned long get_host_id(const char* host_name);
    };

} /* end of namespace */

#endif