// This C++ header file was generated by the TTCN-3 compiler
// of the TTCN-3 Test Executor version CRL 113 200/6 R1A
// for Yann Garcia (yann@Ubuntu64) on Tue Feb 28 11:22:00 2017

// Copyright (c) 2000-2017 Ericsson Telecom AB

// Do not edit this file unless you know what you are doing.

#ifndef Btp__Templates_HH
#define Btp__Templates_HH

#ifndef TITAN_RUNTIME_2
#error Generated code does not match with used runtime.\
 Code was generated with -R option but -DTITAN_RUNTIME_2 was not used.
#endif

/* Header file includes */

#include <TTCN3.hh>
#include "Btp_TestSystem.hh"

#if TTCN3_VERSION != 60100
#error Version mismatch detected.\
 Please check the version of the TTCN-3 compiler and the base library.\
 Run make clean and rebuild the project if the version of the compiler changed recently.
#endif

#ifndef LINUX
#error This file should be compiled on LINUX
#endif

namespace Btp__Templates {

/* Function prototypes */

extern Btp__TestSystem::BtpInd_template mw__btpInd(const Btp__TypesAndValues::BtpPacket_template& p__btpPkt);
extern Btp__TypesAndValues::BtpPacket_template mw__btpA(const INTEGER_template& p__destPort, const INTEGER_template& p__srcPort, const Btp__TypesAndValues::BtpPayload_template& p__payload);
extern Btp__TypesAndValues::BtpPacket_template mw__btpB(const INTEGER_template& p__destPort, const INTEGER_template& p__destPortInfo, const Btp__TypesAndValues::BtpPayload_template& p__payload);
extern Btp__TypesAndValues::Frame_template mw__frame(const OCTETSTRING_template& p__data__length, const OCTETSTRING_template& p__data__stream);

/* Global variable declarations */

extern const OCTETSTRING_template& mw__frame_p__data__length_defval;
extern const OCTETSTRING_template& mw__frame_p__data__stream_defval;
extern TTCN_Module module_object;

} /* end of namespace */

#endif