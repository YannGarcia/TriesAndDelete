// This C++ header file was generated by the TTCN-3 compiler
// of the TTCN-3 Test Executor version CRL 113 200/6 R1A
// for Yann Garcia (yann@Ubuntu64) on Wed Feb 15 15:41:26 2017

// Copyright (c) 2000-2016 Ericsson Telecom AB

// Do not edit this file unless you know what you are doing.

#ifndef UDPasp__Types_HH
#define UDPasp__Types_HH

#ifndef TITAN_RUNTIME_2
#error Generated code does not match with used runtime.\
 Code was generated with -R option but -DTITAN_RUNTIME_2 was not used.
#endif

/* Header file includes */

#include <TTCN3.hh>

#if TTCN3_VERSION != 60100
#error Version mismatch detected.\
 Please check the version of the TTCN-3 compiler and the base library.\
 Run make clean and rebuild the project if the version of the compiler changed recently.
#endif

#ifndef LINUX
#error This file should be compiled on LINUX
#endif

#undef UDPasp__Types_HH
#endif

namespace UDPasp__Types {

/* Forward declarations of classes */

class ASP__UDP;
class ASP__UDP_template;
class ASP__UDP__message;
class ASP__UDP__message_template;
class ASP__UDP__open;
class ASP__UDP__open_template;
class ASP__UDP__open__result;
class ASP__UDP__open__result_template;
class ASP__UDP__close;
class ASP__UDP__close_template;

} /* end of namespace */

#ifndef UDPasp__Types_HH
#define UDPasp__Types_HH

namespace UDPasp__Types {

/* Type definitions */

typedef OCTETSTRING PDU__UDP;
typedef OCTETSTRING_template PDU__UDP_template;
typedef CHARSTRING AddressType;
typedef CHARSTRING_template AddressType_template;
typedef INTEGER PortType;
typedef INTEGER_template PortType_template;

/* Class definitions */

class ASP__UDP : public Record_Type {
  OCTETSTRING field_data;
  CHARSTRING field_addressf;
  INTEGER field_portf;
  Base_Type* fld_vec[3];
  void init_vec();
public:
  ASP__UDP();
  ASP__UDP(const ASP__UDP& other_value);
  ASP__UDP(const OCTETSTRING& par_data,
    const CHARSTRING& par_addressf,
    const INTEGER& par_portf);
inline ASP__UDP& operator=(const ASP__UDP& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const ASP__UDP& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const ASP__UDP& other_value) const
    { return !is_equal(&other_value); }

  inline OCTETSTRING& data()
    {return field_data;}
  inline const OCTETSTRING& data() const
    {return field_data;}
  inline CHARSTRING& addressf()
    {return field_addressf;}
  inline const CHARSTRING& addressf() const
    {return field_addressf;}
  inline INTEGER& portf()
    {return field_portf;}
  inline const INTEGER& portf() const
    {return field_portf;}
Base_Type* clone() const { return new ASP__UDP(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 3; }
boolean default_as_optional() const { return TRUE; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class ASP__UDP_template : public Record_Template {
void set_specific();
public:
ASP__UDP_template(): Record_Template() {}
ASP__UDP_template(template_sel other_value): Record_Template(other_value) {}
ASP__UDP_template(const ASP__UDP& other_value): Record_Template() { copy_value(&other_value); }
ASP__UDP_template(const OPTIONAL<ASP__UDP>& other_value): Record_Template() { copy_optional(&other_value); }
ASP__UDP_template(const ASP__UDP_template& other_value): Record_Template() { copy_template(other_value); }
ASP__UDP_template& operator=(template_sel other_value);
ASP__UDP_template& operator=(const ASP__UDP& other_value);
ASP__UDP_template& operator=(const OPTIONAL<ASP__UDP>& other_value);
ASP__UDP_template& operator=(const ASP__UDP_template& other_value);
inline boolean match(const ASP__UDP& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const ASP__UDP& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
ASP__UDP valueof() const;
inline ASP__UDP_template& list_item(int list_index) const { return *(static_cast<ASP__UDP_template*>(get_list_item(list_index))); }
OCTETSTRING_template& data();
const OCTETSTRING_template& data() const;
CHARSTRING_template& addressf();
const CHARSTRING_template& addressf() const;
INTEGER_template& portf();
const INTEGER_template& portf() const;
Record_Template* create() const { return new ASP__UDP_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class ASP__UDP__message : public Record_Type {
  OCTETSTRING field_data;
  OPTIONAL<CHARSTRING> field_remote__addr;
  OPTIONAL<INTEGER> field_remote__port;
  OPTIONAL<INTEGER> field_id;
  Base_Type* fld_vec[4];
  void init_vec();
public:
  ASP__UDP__message();
  ASP__UDP__message(const ASP__UDP__message& other_value);
  ASP__UDP__message(const OCTETSTRING& par_data,
    const OPTIONAL<CHARSTRING>& par_remote__addr,
    const OPTIONAL<INTEGER>& par_remote__port,
    const OPTIONAL<INTEGER>& par_id);
inline ASP__UDP__message& operator=(const ASP__UDP__message& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const ASP__UDP__message& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const ASP__UDP__message& other_value) const
    { return !is_equal(&other_value); }

  inline OCTETSTRING& data()
    {return field_data;}
  inline const OCTETSTRING& data() const
    {return field_data;}
  inline OPTIONAL<CHARSTRING>& remote__addr()
    {return field_remote__addr;}
  inline const OPTIONAL<CHARSTRING>& remote__addr() const
    {return field_remote__addr;}
  inline OPTIONAL<INTEGER>& remote__port()
    {return field_remote__port;}
  inline const OPTIONAL<INTEGER>& remote__port() const
    {return field_remote__port;}
  inline OPTIONAL<INTEGER>& id()
    {return field_id;}
  inline const OPTIONAL<INTEGER>& id() const
    {return field_id;}
Base_Type* clone() const { return new ASP__UDP__message(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 4; }
int optional_count() const { return 3; }
boolean default_as_optional() const { return TRUE; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

static const int optional_indexes[];
const int* get_optional_indexes() const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class ASP__UDP__message_template : public Record_Template {
void set_specific();
public:
ASP__UDP__message_template(): Record_Template() {}
ASP__UDP__message_template(template_sel other_value): Record_Template(other_value) {}
ASP__UDP__message_template(const ASP__UDP__message& other_value): Record_Template() { copy_value(&other_value); }
ASP__UDP__message_template(const OPTIONAL<ASP__UDP__message>& other_value): Record_Template() { copy_optional(&other_value); }
ASP__UDP__message_template(const ASP__UDP__message_template& other_value): Record_Template() { copy_template(other_value); }
ASP__UDP__message_template& operator=(template_sel other_value);
ASP__UDP__message_template& operator=(const ASP__UDP__message& other_value);
ASP__UDP__message_template& operator=(const OPTIONAL<ASP__UDP__message>& other_value);
ASP__UDP__message_template& operator=(const ASP__UDP__message_template& other_value);
inline boolean match(const ASP__UDP__message& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const ASP__UDP__message& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
ASP__UDP__message valueof() const;
inline ASP__UDP__message_template& list_item(int list_index) const { return *(static_cast<ASP__UDP__message_template*>(get_list_item(list_index))); }
OCTETSTRING_template& data();
const OCTETSTRING_template& data() const;
CHARSTRING_template& remote__addr();
const CHARSTRING_template& remote__addr() const;
INTEGER_template& remote__port();
const INTEGER_template& remote__port() const;
INTEGER_template& id();
const INTEGER_template& id() const;
Record_Template* create() const { return new ASP__UDP__message_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class ASP__UDP__open : public Record_Type {
  OPTIONAL<CHARSTRING> field_remote__addr;
  OPTIONAL<INTEGER> field_remote__port;
  OPTIONAL<CHARSTRING> field_local__addr;
  OPTIONAL<INTEGER> field_local__port;
  Base_Type* fld_vec[4];
  void init_vec();
public:
  ASP__UDP__open();
  ASP__UDP__open(const ASP__UDP__open& other_value);
  ASP__UDP__open(const OPTIONAL<CHARSTRING>& par_remote__addr,
    const OPTIONAL<INTEGER>& par_remote__port,
    const OPTIONAL<CHARSTRING>& par_local__addr,
    const OPTIONAL<INTEGER>& par_local__port);
inline ASP__UDP__open& operator=(const ASP__UDP__open& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const ASP__UDP__open& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const ASP__UDP__open& other_value) const
    { return !is_equal(&other_value); }

  inline OPTIONAL<CHARSTRING>& remote__addr()
    {return field_remote__addr;}
  inline const OPTIONAL<CHARSTRING>& remote__addr() const
    {return field_remote__addr;}
  inline OPTIONAL<INTEGER>& remote__port()
    {return field_remote__port;}
  inline const OPTIONAL<INTEGER>& remote__port() const
    {return field_remote__port;}
  inline OPTIONAL<CHARSTRING>& local__addr()
    {return field_local__addr;}
  inline const OPTIONAL<CHARSTRING>& local__addr() const
    {return field_local__addr;}
  inline OPTIONAL<INTEGER>& local__port()
    {return field_local__port;}
  inline const OPTIONAL<INTEGER>& local__port() const
    {return field_local__port;}
Base_Type* clone() const { return new ASP__UDP__open(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 4; }
int optional_count() const { return 4; }
boolean default_as_optional() const { return TRUE; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

static const int optional_indexes[];
const int* get_optional_indexes() const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class ASP__UDP__open_template : public Record_Template {
void set_specific();
public:
ASP__UDP__open_template(): Record_Template() {}
ASP__UDP__open_template(template_sel other_value): Record_Template(other_value) {}
ASP__UDP__open_template(const ASP__UDP__open& other_value): Record_Template() { copy_value(&other_value); }
ASP__UDP__open_template(const OPTIONAL<ASP__UDP__open>& other_value): Record_Template() { copy_optional(&other_value); }
ASP__UDP__open_template(const ASP__UDP__open_template& other_value): Record_Template() { copy_template(other_value); }
ASP__UDP__open_template& operator=(template_sel other_value);
ASP__UDP__open_template& operator=(const ASP__UDP__open& other_value);
ASP__UDP__open_template& operator=(const OPTIONAL<ASP__UDP__open>& other_value);
ASP__UDP__open_template& operator=(const ASP__UDP__open_template& other_value);
inline boolean match(const ASP__UDP__open& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const ASP__UDP__open& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
ASP__UDP__open valueof() const;
inline ASP__UDP__open_template& list_item(int list_index) const { return *(static_cast<ASP__UDP__open_template*>(get_list_item(list_index))); }
CHARSTRING_template& remote__addr();
const CHARSTRING_template& remote__addr() const;
INTEGER_template& remote__port();
const INTEGER_template& remote__port() const;
CHARSTRING_template& local__addr();
const CHARSTRING_template& local__addr() const;
INTEGER_template& local__port();
const INTEGER_template& local__port() const;
Record_Template* create() const { return new ASP__UDP__open_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class ASP__UDP__open__result : public Record_Type {
  CHARSTRING field_local__addr;
  INTEGER field_local__port;
  INTEGER field_id;
  Base_Type* fld_vec[3];
  void init_vec();
public:
  ASP__UDP__open__result();
  ASP__UDP__open__result(const ASP__UDP__open__result& other_value);
  ASP__UDP__open__result(const CHARSTRING& par_local__addr,
    const INTEGER& par_local__port,
    const INTEGER& par_id);
inline ASP__UDP__open__result& operator=(const ASP__UDP__open__result& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const ASP__UDP__open__result& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const ASP__UDP__open__result& other_value) const
    { return !is_equal(&other_value); }

  inline CHARSTRING& local__addr()
    {return field_local__addr;}
  inline const CHARSTRING& local__addr() const
    {return field_local__addr;}
  inline INTEGER& local__port()
    {return field_local__port;}
  inline const INTEGER& local__port() const
    {return field_local__port;}
  inline INTEGER& id()
    {return field_id;}
  inline const INTEGER& id() const
    {return field_id;}
Base_Type* clone() const { return new ASP__UDP__open__result(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 3; }
boolean default_as_optional() const { return TRUE; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class ASP__UDP__open__result_template : public Record_Template {
void set_specific();
public:
ASP__UDP__open__result_template(): Record_Template() {}
ASP__UDP__open__result_template(template_sel other_value): Record_Template(other_value) {}
ASP__UDP__open__result_template(const ASP__UDP__open__result& other_value): Record_Template() { copy_value(&other_value); }
ASP__UDP__open__result_template(const OPTIONAL<ASP__UDP__open__result>& other_value): Record_Template() { copy_optional(&other_value); }
ASP__UDP__open__result_template(const ASP__UDP__open__result_template& other_value): Record_Template() { copy_template(other_value); }
ASP__UDP__open__result_template& operator=(template_sel other_value);
ASP__UDP__open__result_template& operator=(const ASP__UDP__open__result& other_value);
ASP__UDP__open__result_template& operator=(const OPTIONAL<ASP__UDP__open__result>& other_value);
ASP__UDP__open__result_template& operator=(const ASP__UDP__open__result_template& other_value);
inline boolean match(const ASP__UDP__open__result& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const ASP__UDP__open__result& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
ASP__UDP__open__result valueof() const;
inline ASP__UDP__open__result_template& list_item(int list_index) const { return *(static_cast<ASP__UDP__open__result_template*>(get_list_item(list_index))); }
CHARSTRING_template& local__addr();
const CHARSTRING_template& local__addr() const;
INTEGER_template& local__port();
const INTEGER_template& local__port() const;
INTEGER_template& id();
const INTEGER_template& id() const;
Record_Template* create() const { return new ASP__UDP__open__result_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class ASP__UDP__close : public Record_Type {
  INTEGER field_id;
  Base_Type* fld_vec[1];
  void init_vec();
public:
  ASP__UDP__close();
  ASP__UDP__close(const ASP__UDP__close& other_value);
  ASP__UDP__close(const INTEGER& par_id);
inline ASP__UDP__close& operator=(const ASP__UDP__close& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const ASP__UDP__close& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const ASP__UDP__close& other_value) const
    { return !is_equal(&other_value); }

  inline INTEGER& id()
    {return field_id;}
  inline const INTEGER& id() const
    {return field_id;}
Base_Type* clone() const { return new ASP__UDP__close(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 1; }
boolean default_as_optional() const { return TRUE; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class ASP__UDP__close_template : public Record_Template {
void set_specific();
public:
ASP__UDP__close_template(): Record_Template() {}
ASP__UDP__close_template(template_sel other_value): Record_Template(other_value) {}
ASP__UDP__close_template(const ASP__UDP__close& other_value): Record_Template() { copy_value(&other_value); }
ASP__UDP__close_template(const OPTIONAL<ASP__UDP__close>& other_value): Record_Template() { copy_optional(&other_value); }
ASP__UDP__close_template(const ASP__UDP__close_template& other_value): Record_Template() { copy_template(other_value); }
ASP__UDP__close_template& operator=(template_sel other_value);
ASP__UDP__close_template& operator=(const ASP__UDP__close& other_value);
ASP__UDP__close_template& operator=(const OPTIONAL<ASP__UDP__close>& other_value);
ASP__UDP__close_template& operator=(const ASP__UDP__close_template& other_value);
inline boolean match(const ASP__UDP__close& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const ASP__UDP__close& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
ASP__UDP__close valueof() const;
inline ASP__UDP__close_template& list_item(int list_index) const { return *(static_cast<ASP__UDP__close_template*>(get_list_item(list_index))); }
INTEGER_template& id();
const INTEGER_template& id() const;
Record_Template* create() const { return new ASP__UDP__close_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};


/* Global variable declarations */

extern const TTCN_Typedescriptor_t PDU__UDP_descr_;
extern const TTCN_Typedescriptor_t AddressType_descr_;
extern const TTCN_Typedescriptor_t PortType_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP_data_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP_addressf_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP_portf_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__message_data_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__message_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__message_id_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__open_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__open__result_local__addr_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__open__result_local__port_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__open__result_id_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__open__result_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__close_id_descr_;
extern const TTCN_Typedescriptor_t ASP__UDP__close_descr_;
extern TTCN_Module module_object;

} /* end of namespace */

#endif
