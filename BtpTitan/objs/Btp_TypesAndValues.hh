// This C++ header file was generated by the TTCN-3 compiler
// of the TTCN-3 Test Executor version CRL 113 200/6 R1A
// for Yann Garcia (yann@Ubuntu64) on Tue Feb 28 11:22:01 2017

// Copyright (c) 2000-2017 Ericsson Telecom AB

// Do not edit this file unless you know what you are doing.

#ifndef Btp__TypesAndValues_HH
#define Btp__TypesAndValues_HH

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

#undef Btp__TypesAndValues_HH
#endif

namespace Btp__TypesAndValues {

/* Forward declarations of classes */

class BtpHeader;
class BtpHeader_template;
class BtpAHeader;
class BtpAHeader_template;
class BtpBHeader;
class BtpBHeader_template;
class BtpPacket;
class BtpPacket_template;
class BtpPayload;
class BtpPayload_template;
class DecodedBtpPayload;
class DecodedBtpPayload_template;
class anytype;
class anytype_template;
class Frame;
class Frame_template;

} /* end of namespace */

#ifndef Btp__TypesAndValues_HH
#define Btp__TypesAndValues_HH

namespace Btp__TypesAndValues {

/* Type definitions */

typedef INTEGER UInt16;
typedef INTEGER_template UInt16_template;
typedef OCTETSTRING Oct2;
typedef OCTETSTRING_template Oct2_template;
typedef INTEGER BtpPortId;
typedef INTEGER_template BtpPortId_template;
typedef INTEGER BtpPortInfo;
typedef INTEGER_template BtpPortInfo_template;
typedef OCTETSTRING BtpRawPayload;
typedef OCTETSTRING_template BtpRawPayload_template;

/* Class definitions */

class BtpHeader : public Base_Type {
public:
enum union_selection_type { UNBOUND_VALUE = 0, ALT_btpAHeader = 1, ALT_btpBHeader = 2 };
private:
union_selection_type union_selection;
union {
BtpAHeader *field_btpAHeader;
BtpBHeader *field_btpBHeader;
};
Erroneous_descriptor_t* err_descr;
void copy_value(const BtpHeader& other_value);

public:
BtpHeader();
BtpHeader(const BtpHeader& other_value);
~BtpHeader();
BtpHeader& operator=(const BtpHeader& other_value);
boolean operator==(const BtpHeader& other_value) const;
inline boolean operator!=(const BtpHeader& other_value) const { return !(*this == other_value); }
BtpAHeader& btpAHeader();
const BtpAHeader& btpAHeader() const;
BtpBHeader& btpBHeader();
const BtpBHeader& btpBHeader() const;
inline union_selection_type get_selection() const { return union_selection; }
boolean ischosen(union_selection_type checked_selection) const;
boolean is_bound() const;
boolean is_value() const;
void clean_up();
boolean is_equal(const Base_Type* other_value) const;
void set_value(const Base_Type* other_value);
Base_Type* clone() const;
const TTCN_Typedescriptor_t* get_descriptor() const;
void set_err_descr(Erroneous_descriptor_t* p_err_descr) { err_descr=p_err_descr; }
Erroneous_descriptor_t* get_err_descr() const { return err_descr; }
void log() const;
void set_param(Module_Param& param);
Module_Param* get_param(Module_Param_Name& param_name) const;
  void set_implicit_omit();
void encode_text(Text_Buf& text_buf) const;
void decode_text(Text_Buf& text_buf);
void encode(const TTCN_Typedescriptor_t&, TTCN_Buffer&, TTCN_EncDec::coding_t, ...) const;
void decode(const TTCN_Typedescriptor_t&, TTCN_Buffer&, TTCN_EncDec::coding_t, ...);
int RAW_encode(const TTCN_Typedescriptor_t&, RAW_enc_tree&) const;
int RAW_decode(const TTCN_Typedescriptor_t&, TTCN_Buffer&, int, raw_order_t, boolean no_err=FALSE,int sel_field=-1, boolean first_call=TRUE);
int JSON_encode(const TTCN_Typedescriptor_t&, JSON_Tokenizer&) const;
int JSON_decode(const TTCN_Typedescriptor_t&, JSON_Tokenizer&, boolean);
int RAW_encode_negtest(const Erroneous_descriptor_t *, const TTCN_Typedescriptor_t&, RAW_enc_tree&) const;
int JSON_encode_negtest(const Erroneous_descriptor_t*, const TTCN_Typedescriptor_t&, JSON_Tokenizer&) const;
};

class BtpHeader_template : public Base_Template {
union {
struct {
BtpHeader::union_selection_type union_selection;
union {
BtpAHeader_template *field_btpAHeader;
BtpBHeader_template *field_btpBHeader;
};
} single_value;
struct {
unsigned int n_values;
BtpHeader_template *list_value;
} value_list;
};
Erroneous_descriptor_t* err_descr;
void copy_value(const BtpHeader& other_value);

void copy_template(const BtpHeader_template& other_value);

public:
BtpHeader_template();
BtpHeader_template(template_sel other_value);
BtpHeader_template(const BtpHeader& other_value);
BtpHeader_template(const OPTIONAL<BtpHeader>& other_value);
BtpHeader_template(const BtpHeader_template& other_value);
~BtpHeader_template();
void clean_up();
BtpHeader_template& operator=(template_sel other_value);
BtpHeader_template& operator=(const BtpHeader& other_value);
BtpHeader_template& operator=(const OPTIONAL<BtpHeader>& other_value);
BtpHeader_template& operator=(const BtpHeader_template& other_value);
boolean match(const BtpHeader& other_value, boolean legacy = FALSE) const;
boolean is_value() const;BtpHeader valueof() const;
BtpHeader_template& list_item(unsigned int list_index) const;
void set_type(template_sel template_type, unsigned int list_length);
BtpAHeader_template& btpAHeader();
const BtpAHeader_template& btpAHeader() const;
BtpBHeader_template& btpBHeader();
const BtpBHeader_template& btpBHeader() const;
boolean ischosen(BtpHeader::union_selection_type checked_selection) const;
void set_err_descr(Erroneous_descriptor_t* p_err_descr) { err_descr=p_err_descr; }
void valueofv(Base_Type* value) const;
void set_value(template_sel other_value);
void copy_value(const Base_Type* other_value);
Base_Template* clone() const;
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean matchv(const Base_Type* other_value, boolean legacy) const;
void log_matchv(const Base_Type* match_value, boolean legacy) const;
void log() const;
void log_match(const BtpHeader& match_value, boolean legacy = FALSE) const;
void encode_text(Text_Buf& text_buf) const;
void decode_text(Text_Buf& text_buf);
boolean is_present(boolean legacy = FALSE) const;
boolean match_omit(boolean legacy = FALSE) const;
void set_param(Module_Param& param);
Module_Param* get_param(Module_Param_Name& param_name) const;
void check_restriction(template_res t_res, const char* t_name=NULL, boolean legacy = FALSE) const;
};

class BtpAHeader : public Record_Type {
  INTEGER field_destinationPort;
  INTEGER field_sourcePort;
  Base_Type* fld_vec[2];
  void init_vec();
public:
  BtpAHeader();
  BtpAHeader(const BtpAHeader& other_value);
  BtpAHeader(const INTEGER& par_destinationPort,
    const INTEGER& par_sourcePort);
inline BtpAHeader& operator=(const BtpAHeader& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const BtpAHeader& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const BtpAHeader& other_value) const
    { return !is_equal(&other_value); }

  inline INTEGER& destinationPort()
    {return field_destinationPort;}
  inline const INTEGER& destinationPort() const
    {return field_destinationPort;}
  inline INTEGER& sourcePort()
    {return field_sourcePort;}
  inline const INTEGER& sourcePort() const
    {return field_sourcePort;}
Base_Type* clone() const { return new BtpAHeader(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 2; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class BtpAHeader_template : public Record_Template {
void set_specific();
public:
BtpAHeader_template(): Record_Template() {}
BtpAHeader_template(template_sel other_value): Record_Template(other_value) {}
BtpAHeader_template(const BtpAHeader& other_value): Record_Template() { copy_value(&other_value); }
BtpAHeader_template(const OPTIONAL<BtpAHeader>& other_value): Record_Template() { copy_optional(&other_value); }
BtpAHeader_template(const BtpAHeader_template& other_value): Record_Template() { copy_template(other_value); }
BtpAHeader_template& operator=(template_sel other_value);
BtpAHeader_template& operator=(const BtpAHeader& other_value);
BtpAHeader_template& operator=(const OPTIONAL<BtpAHeader>& other_value);
BtpAHeader_template& operator=(const BtpAHeader_template& other_value);
inline boolean match(const BtpAHeader& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const BtpAHeader& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
BtpAHeader valueof() const;
inline BtpAHeader_template& list_item(int list_index) const { return *(static_cast<BtpAHeader_template*>(get_list_item(list_index))); }
INTEGER_template& destinationPort();
const INTEGER_template& destinationPort() const;
INTEGER_template& sourcePort();
const INTEGER_template& sourcePort() const;
Record_Template* create() const { return new BtpAHeader_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class BtpBHeader : public Record_Type {
  INTEGER field_destinationPort;
  INTEGER field_destinationPortInfo;
  Base_Type* fld_vec[2];
  void init_vec();
public:
  BtpBHeader();
  BtpBHeader(const BtpBHeader& other_value);
  BtpBHeader(const INTEGER& par_destinationPort,
    const INTEGER& par_destinationPortInfo);
inline BtpBHeader& operator=(const BtpBHeader& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const BtpBHeader& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const BtpBHeader& other_value) const
    { return !is_equal(&other_value); }

  inline INTEGER& destinationPort()
    {return field_destinationPort;}
  inline const INTEGER& destinationPort() const
    {return field_destinationPort;}
  inline INTEGER& destinationPortInfo()
    {return field_destinationPortInfo;}
  inline const INTEGER& destinationPortInfo() const
    {return field_destinationPortInfo;}
Base_Type* clone() const { return new BtpBHeader(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 2; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class BtpBHeader_template : public Record_Template {
void set_specific();
public:
BtpBHeader_template(): Record_Template() {}
BtpBHeader_template(template_sel other_value): Record_Template(other_value) {}
BtpBHeader_template(const BtpBHeader& other_value): Record_Template() { copy_value(&other_value); }
BtpBHeader_template(const OPTIONAL<BtpBHeader>& other_value): Record_Template() { copy_optional(&other_value); }
BtpBHeader_template(const BtpBHeader_template& other_value): Record_Template() { copy_template(other_value); }
BtpBHeader_template& operator=(template_sel other_value);
BtpBHeader_template& operator=(const BtpBHeader& other_value);
BtpBHeader_template& operator=(const OPTIONAL<BtpBHeader>& other_value);
BtpBHeader_template& operator=(const BtpBHeader_template& other_value);
inline boolean match(const BtpBHeader& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const BtpBHeader& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
BtpBHeader valueof() const;
inline BtpBHeader_template& list_item(int list_index) const { return *(static_cast<BtpBHeader_template*>(get_list_item(list_index))); }
INTEGER_template& destinationPort();
const INTEGER_template& destinationPort() const;
INTEGER_template& destinationPortInfo();
const INTEGER_template& destinationPortInfo() const;
Record_Template* create() const { return new BtpBHeader_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class BtpPacket : public Record_Type {
  BtpHeader field_header;
  OPTIONAL<BtpPayload> field_payload;
  Base_Type* fld_vec[2];
  void init_vec();
public:
  BtpPacket();
  BtpPacket(const BtpPacket& other_value);
  BtpPacket(const BtpHeader& par_header,
    const OPTIONAL<BtpPayload>& par_payload);
inline BtpPacket& operator=(const BtpPacket& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const BtpPacket& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const BtpPacket& other_value) const
    { return !is_equal(&other_value); }

  inline BtpHeader& header()
    {return field_header;}
  inline const BtpHeader& header() const
    {return field_header;}
  inline OPTIONAL<BtpPayload>& payload()
    {return field_payload;}
  inline const OPTIONAL<BtpPayload>& payload() const
    {return field_payload;}
Base_Type* clone() const { return new BtpPacket(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 2; }
int optional_count() const { return 1; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

static const int optional_indexes[];
const int* get_optional_indexes() const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class BtpPacket_template : public Record_Template {
void set_specific();
public:
BtpPacket_template(): Record_Template() {}
BtpPacket_template(template_sel other_value): Record_Template(other_value) {}
BtpPacket_template(const BtpPacket& other_value): Record_Template() { copy_value(&other_value); }
BtpPacket_template(const OPTIONAL<BtpPacket>& other_value): Record_Template() { copy_optional(&other_value); }
BtpPacket_template(const BtpPacket_template& other_value): Record_Template() { copy_template(other_value); }
BtpPacket_template& operator=(template_sel other_value);
BtpPacket_template& operator=(const BtpPacket& other_value);
BtpPacket_template& operator=(const OPTIONAL<BtpPacket>& other_value);
BtpPacket_template& operator=(const BtpPacket_template& other_value);
inline boolean match(const BtpPacket& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const BtpPacket& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
BtpPacket valueof() const;
inline BtpPacket_template& list_item(int list_index) const { return *(static_cast<BtpPacket_template*>(get_list_item(list_index))); }
BtpHeader_template& header();
const BtpHeader_template& header() const;
BtpPayload_template& payload();
const BtpPayload_template& payload() const;
Record_Template* create() const { return new BtpPacket_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class BtpPayload : public Record_Type {
  OPTIONAL<DecodedBtpPayload> field_decodedPayload;
  OCTETSTRING field_rawPayload;
  Base_Type* fld_vec[2];
  void init_vec();
public:
  BtpPayload();
  BtpPayload(const BtpPayload& other_value);
  BtpPayload(const OPTIONAL<DecodedBtpPayload>& par_decodedPayload,
    const OCTETSTRING& par_rawPayload);
inline BtpPayload& operator=(const BtpPayload& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const BtpPayload& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const BtpPayload& other_value) const
    { return !is_equal(&other_value); }

  inline OPTIONAL<DecodedBtpPayload>& decodedPayload()
    {return field_decodedPayload;}
  inline const OPTIONAL<DecodedBtpPayload>& decodedPayload() const
    {return field_decodedPayload;}
  inline OCTETSTRING& rawPayload()
    {return field_rawPayload;}
  inline const OCTETSTRING& rawPayload() const
    {return field_rawPayload;}
Base_Type* clone() const { return new BtpPayload(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 2; }
int optional_count() const { return 1; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

static const int optional_indexes[];
const int* get_optional_indexes() const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class BtpPayload_template : public Record_Template {
void set_specific();
public:
BtpPayload_template(): Record_Template() {}
BtpPayload_template(template_sel other_value): Record_Template(other_value) {}
BtpPayload_template(const BtpPayload& other_value): Record_Template() { copy_value(&other_value); }
BtpPayload_template(const OPTIONAL<BtpPayload>& other_value): Record_Template() { copy_optional(&other_value); }
BtpPayload_template(const BtpPayload_template& other_value): Record_Template() { copy_template(other_value); }
BtpPayload_template& operator=(template_sel other_value);
BtpPayload_template& operator=(const BtpPayload& other_value);
BtpPayload_template& operator=(const OPTIONAL<BtpPayload>& other_value);
BtpPayload_template& operator=(const BtpPayload_template& other_value);
inline boolean match(const BtpPayload& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const BtpPayload& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
BtpPayload valueof() const;
inline BtpPayload_template& list_item(int list_index) const { return *(static_cast<BtpPayload_template*>(get_list_item(list_index))); }
DecodedBtpPayload_template& decodedPayload();
const DecodedBtpPayload_template& decodedPayload() const;
OCTETSTRING_template& rawPayload();
const OCTETSTRING_template& rawPayload() const;
Record_Template* create() const { return new BtpPayload_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};

class DecodedBtpPayload : public Base_Type {
public:
enum union_selection_type { UNBOUND_VALUE = 0, ALT_raw__payload = 1, ALT_payload = 2 };
private:
union_selection_type union_selection;
union {
OCTETSTRING *field_raw__payload;
anytype *field_payload;
};
Erroneous_descriptor_t* err_descr;
void copy_value(const DecodedBtpPayload& other_value);

public:
DecodedBtpPayload();
DecodedBtpPayload(const DecodedBtpPayload& other_value);
~DecodedBtpPayload();
DecodedBtpPayload& operator=(const DecodedBtpPayload& other_value);
boolean operator==(const DecodedBtpPayload& other_value) const;
inline boolean operator!=(const DecodedBtpPayload& other_value) const { return !(*this == other_value); }
OCTETSTRING& raw__payload();
const OCTETSTRING& raw__payload() const;
anytype& payload();
const anytype& payload() const;
inline union_selection_type get_selection() const { return union_selection; }
boolean ischosen(union_selection_type checked_selection) const;
boolean is_bound() const;
boolean is_value() const;
void clean_up();
boolean is_equal(const Base_Type* other_value) const;
void set_value(const Base_Type* other_value);
Base_Type* clone() const;
const TTCN_Typedescriptor_t* get_descriptor() const;
void set_err_descr(Erroneous_descriptor_t* p_err_descr) { err_descr=p_err_descr; }
Erroneous_descriptor_t* get_err_descr() const { return err_descr; }
void log() const;
void set_param(Module_Param& param);
Module_Param* get_param(Module_Param_Name& param_name) const;
  void set_implicit_omit();
void encode_text(Text_Buf& text_buf) const;
void decode_text(Text_Buf& text_buf);
void encode(const TTCN_Typedescriptor_t&, TTCN_Buffer&, TTCN_EncDec::coding_t, ...) const;
void decode(const TTCN_Typedescriptor_t&, TTCN_Buffer&, TTCN_EncDec::coding_t, ...);
int RAW_encode(const TTCN_Typedescriptor_t&, RAW_enc_tree&) const;
int RAW_decode(const TTCN_Typedescriptor_t&, TTCN_Buffer&, int, raw_order_t, boolean no_err=FALSE,int sel_field=-1, boolean first_call=TRUE);
int JSON_encode(const TTCN_Typedescriptor_t&, JSON_Tokenizer&) const;
int JSON_decode(const TTCN_Typedescriptor_t&, JSON_Tokenizer&, boolean);
int RAW_encode_negtest(const Erroneous_descriptor_t *, const TTCN_Typedescriptor_t&, RAW_enc_tree&) const;
int JSON_encode_negtest(const Erroneous_descriptor_t*, const TTCN_Typedescriptor_t&, JSON_Tokenizer&) const;
};

class DecodedBtpPayload_template : public Base_Template {
union {
struct {
DecodedBtpPayload::union_selection_type union_selection;
union {
OCTETSTRING_template *field_raw__payload;
anytype_template *field_payload;
};
} single_value;
struct {
unsigned int n_values;
DecodedBtpPayload_template *list_value;
} value_list;
};
Erroneous_descriptor_t* err_descr;
void copy_value(const DecodedBtpPayload& other_value);

void copy_template(const DecodedBtpPayload_template& other_value);

public:
DecodedBtpPayload_template();
DecodedBtpPayload_template(template_sel other_value);
DecodedBtpPayload_template(const DecodedBtpPayload& other_value);
DecodedBtpPayload_template(const OPTIONAL<DecodedBtpPayload>& other_value);
DecodedBtpPayload_template(const DecodedBtpPayload_template& other_value);
~DecodedBtpPayload_template();
void clean_up();
DecodedBtpPayload_template& operator=(template_sel other_value);
DecodedBtpPayload_template& operator=(const DecodedBtpPayload& other_value);
DecodedBtpPayload_template& operator=(const OPTIONAL<DecodedBtpPayload>& other_value);
DecodedBtpPayload_template& operator=(const DecodedBtpPayload_template& other_value);
boolean match(const DecodedBtpPayload& other_value, boolean legacy = FALSE) const;
boolean is_value() const;DecodedBtpPayload valueof() const;
DecodedBtpPayload_template& list_item(unsigned int list_index) const;
void set_type(template_sel template_type, unsigned int list_length);
OCTETSTRING_template& raw__payload();
const OCTETSTRING_template& raw__payload() const;
anytype_template& payload();
const anytype_template& payload() const;
boolean ischosen(DecodedBtpPayload::union_selection_type checked_selection) const;
void set_err_descr(Erroneous_descriptor_t* p_err_descr) { err_descr=p_err_descr; }
void valueofv(Base_Type* value) const;
void set_value(template_sel other_value);
void copy_value(const Base_Type* other_value);
Base_Template* clone() const;
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean matchv(const Base_Type* other_value, boolean legacy) const;
void log_matchv(const Base_Type* match_value, boolean legacy) const;
void log() const;
void log_match(const DecodedBtpPayload& match_value, boolean legacy = FALSE) const;
void encode_text(Text_Buf& text_buf) const;
void decode_text(Text_Buf& text_buf);
boolean is_present(boolean legacy = FALSE) const;
boolean match_omit(boolean legacy = FALSE) const;
void set_param(Module_Param& param);
Module_Param* get_param(Module_Param_Name& param_name) const;
void check_restriction(template_res t_res, const char* t_name=NULL, boolean legacy = FALSE) const;
};

class anytype : public Base_Type {
public:
enum union_selection_type { UNBOUND_VALUE = 0 };
private:
union_selection_type union_selection;
union {
};
Erroneous_descriptor_t* err_descr;
void copy_value(const anytype& other_value);

public:
anytype();
anytype(const anytype& other_value);
~anytype();
anytype& operator=(const anytype& other_value);
boolean operator==(const anytype& other_value) const;
inline boolean operator!=(const anytype& other_value) const { return !(*this == other_value); }
inline union_selection_type get_selection() const { return union_selection; }
boolean ischosen(union_selection_type checked_selection) const;
boolean is_bound() const;
boolean is_value() const;
void clean_up();
boolean is_equal(const Base_Type* other_value) const;
void set_value(const Base_Type* other_value);
Base_Type* clone() const;
const TTCN_Typedescriptor_t* get_descriptor() const;
void set_err_descr(Erroneous_descriptor_t* p_err_descr) { err_descr=p_err_descr; }
Erroneous_descriptor_t* get_err_descr() const { return err_descr; }
void log() const;
void set_param(Module_Param& param);
Module_Param* get_param(Module_Param_Name& param_name) const;
  void set_implicit_omit();
void encode_text(Text_Buf& text_buf) const;
void decode_text(Text_Buf& text_buf);
};

class anytype_template : public Base_Template {
union {
struct {
anytype::union_selection_type union_selection;
union {
};
} single_value;
struct {
unsigned int n_values;
anytype_template *list_value;
} value_list;
};
Erroneous_descriptor_t* err_descr;
void copy_value(const anytype& other_value);

void copy_template(const anytype_template& other_value);

public:
anytype_template();
anytype_template(template_sel other_value);
anytype_template(const anytype& other_value);
anytype_template(const OPTIONAL<anytype>& other_value);
anytype_template(const anytype_template& other_value);
~anytype_template();
void clean_up();
anytype_template& operator=(template_sel other_value);
anytype_template& operator=(const anytype& other_value);
anytype_template& operator=(const OPTIONAL<anytype>& other_value);
anytype_template& operator=(const anytype_template& other_value);
boolean match(const anytype& other_value, boolean legacy = FALSE) const;
boolean is_value() const;anytype valueof() const;
anytype_template& list_item(unsigned int list_index) const;
void set_type(template_sel template_type, unsigned int list_length);
boolean ischosen(anytype::union_selection_type checked_selection) const;
void set_err_descr(Erroneous_descriptor_t* p_err_descr) { err_descr=p_err_descr; }
void valueofv(Base_Type* value) const;
void set_value(template_sel other_value);
void copy_value(const Base_Type* other_value);
Base_Template* clone() const;
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean matchv(const Base_Type* other_value, boolean legacy) const;
void log_matchv(const Base_Type* match_value, boolean legacy) const;
void log() const;
void log_match(const anytype& match_value, boolean legacy = FALSE) const;
void encode_text(Text_Buf& text_buf) const;
void decode_text(Text_Buf& text_buf);
boolean is_present(boolean legacy = FALSE) const;
boolean match_omit(boolean legacy = FALSE) const;
void set_param(Module_Param& param);
Module_Param* get_param(Module_Param_Name& param_name) const;
void check_restriction(template_res t_res, const char* t_name=NULL, boolean legacy = FALSE) const;
};

class Frame : public Record_Type {
  OCTETSTRING field_data__length;
  OCTETSTRING field_data__stream;
  Base_Type* fld_vec[2];
  void init_vec();
public:
  Frame();
  Frame(const Frame& other_value);
  Frame(const OCTETSTRING& par_data__length,
    const OCTETSTRING& par_data__stream);
inline Frame& operator=(const Frame& other_value) { set_value(&other_value); return *this; }

inline boolean operator==(const Frame& other_value) const { return is_equal(&other_value); }
  inline boolean operator!=(const Frame& other_value) const
    { return !is_equal(&other_value); }

  inline OCTETSTRING& data__length()
    {return field_data__length;}
  inline const OCTETSTRING& data__length() const
    {return field_data__length;}
  inline OCTETSTRING& data__stream()
    {return field_data__stream;}
  inline const OCTETSTRING& data__stream() const
    {return field_data__stream;}
Base_Type* clone() const { return new Frame(*this); }
const TTCN_Typedescriptor_t* get_descriptor() const;
boolean is_set() const { return FALSE; }
Base_Type* get_at(int index_value) { return fld_vec[index_value]; }
const Base_Type* get_at(int index_value) const { return fld_vec[index_value]; }

int get_count() const { return 2; }
static const TTCN_Typedescriptor_t* fld_descriptors[];
const TTCN_Typedescriptor_t* fld_descr(int p_index) const;

static const char* fld_names[];
const char* fld_name(int p_index) const;

boolean can_start_v(const char *, const char *, XERdescriptor_t const&, unsigned int, unsigned int)
{ return FALSE; }
};

class Frame_template : public Record_Template {
void set_specific();
public:
Frame_template(): Record_Template() {}
Frame_template(template_sel other_value): Record_Template(other_value) {}
Frame_template(const Frame& other_value): Record_Template() { copy_value(&other_value); }
Frame_template(const OPTIONAL<Frame>& other_value): Record_Template() { copy_optional(&other_value); }
Frame_template(const Frame_template& other_value): Record_Template() { copy_template(other_value); }
Frame_template& operator=(template_sel other_value);
Frame_template& operator=(const Frame& other_value);
Frame_template& operator=(const OPTIONAL<Frame>& other_value);
Frame_template& operator=(const Frame_template& other_value);
inline boolean match(const Frame& other_value, boolean legacy = FALSE) const { return matchv(&other_value, legacy); }
inline void log_match(const Frame& match_value, boolean legacy = FALSE) const { log_matchv(&match_value, legacy); }
Frame valueof() const;
inline Frame_template& list_item(int list_index) const { return *(static_cast<Frame_template*>(get_list_item(list_index))); }
OCTETSTRING_template& data__length();
const OCTETSTRING_template& data__length() const;
OCTETSTRING_template& data__stream();
const OCTETSTRING_template& data__stream() const;
Record_Template* create() const { return new Frame_template; }
const TTCN_Typedescriptor_t* get_descriptor() const;
const char* fld_name(int p_index) const;
};


/* Global variable declarations */

extern const INTEGER& c__uInt16Max;
extern const TTCN_RAWdescriptor_t UInt16_raw_;
extern const XERdescriptor_t UInt16_xer_;
extern const TTCN_Typedescriptor_t UInt16_descr_;
extern const TTCN_RAWdescriptor_t Oct2_raw_;
extern const XERdescriptor_t Oct2_xer_;
extern const TTCN_Typedescriptor_t Oct2_descr_;
extern const TTCN_RAWdescriptor_t BtpHeader_raw_;
extern const TTCN_JSONdescriptor_t BtpHeader_json_;
extern const TTCN_Typedescriptor_t BtpHeader_descr_;
extern const XERdescriptor_t BtpPortId_xer_;
extern const TTCN_Typedescriptor_t BtpPortId_descr_;
extern const XERdescriptor_t BtpAHeader_destinationPort_xer_;
extern const TTCN_Typedescriptor_t BtpAHeader_destinationPort_descr_;
extern const XERdescriptor_t BtpAHeader_sourcePort_xer_;
extern const TTCN_Typedescriptor_t BtpAHeader_sourcePort_descr_;
extern const TTCN_RAWdescriptor_t BtpAHeader_raw_;
extern const TTCN_JSONdescriptor_t BtpAHeader_json_;
extern const TTCN_Typedescriptor_t BtpAHeader_descr_;
extern const XERdescriptor_t BtpBHeader_destinationPort_xer_;
extern const TTCN_Typedescriptor_t BtpBHeader_destinationPort_descr_;
extern const XERdescriptor_t BtpPortInfo_xer_;
extern const TTCN_Typedescriptor_t BtpPortInfo_descr_;
extern const XERdescriptor_t BtpBHeader_destinationPortInfo_xer_;
extern const TTCN_Typedescriptor_t BtpBHeader_destinationPortInfo_descr_;
extern const TTCN_RAWdescriptor_t BtpBHeader_raw_;
extern const TTCN_JSONdescriptor_t BtpBHeader_json_;
extern const TTCN_Typedescriptor_t BtpBHeader_descr_;
extern const TTCN_RAWdescriptor_t BtpPacket_raw_;
extern const TTCN_JSONdescriptor_t BtpPacket_json_;
extern const TTCN_Typedescriptor_t BtpPacket_descr_;
extern const XERdescriptor_t BtpRawPayload_xer_;
extern const TTCN_Typedescriptor_t BtpRawPayload_descr_;
extern const XERdescriptor_t BtpPayload_rawPayload_xer_;
extern const TTCN_Typedescriptor_t BtpPayload_rawPayload_descr_;
extern const TTCN_RAWdescriptor_t BtpPayload_raw_;
extern const TTCN_JSONdescriptor_t BtpPayload_json_;
extern const TTCN_Typedescriptor_t BtpPayload_descr_;
extern const TTCN_RAWdescriptor_t DecodedBtpPayload_raw_;
extern const TTCN_JSONdescriptor_t DecodedBtpPayload_json_;
extern const TTCN_Typedescriptor_t DecodedBtpPayload_descr_;
extern const XERdescriptor_t DecodedBtpPayload_raw__payload_xer_;
extern const TTCN_Typedescriptor_t DecodedBtpPayload_raw__payload_descr_;
extern const TTCN_Typedescriptor_t anytype_descr_;
extern const XERdescriptor_t Frame_data__length_xer_;
extern const TTCN_Typedescriptor_t Frame_data__length_descr_;
extern const XERdescriptor_t Frame_data__stream_xer_;
extern const TTCN_Typedescriptor_t Frame_data__stream_descr_;
extern const TTCN_RAWdescriptor_t Frame_raw_;
extern const TTCN_JSONdescriptor_t Frame_json_;
extern const TTCN_Typedescriptor_t Frame_descr_;
extern TTCN_Module module_object;

} /* end of namespace */

#endif