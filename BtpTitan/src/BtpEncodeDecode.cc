#include "Btp_EncodeDecode.hh"

namespace Btp__EncodeDecode {

  void log(const char *fmt, ...);

  const unsigned char MessageId = 0x00;


  INTEGER fx__dec__UtInitialize(BITSTRING & p_bitstring, Ut__TypesAndValues::UtInitialize & p_utInitialize) {
    log("Entering fx__dec__UtInitialize");

    // Extract message identifier
    TTCN_Buffer buffer(bit2oct(p_bitstring));
    OCTETSTRING messageId;
    messageId.RAW_decode(*messageId.get_descriptor(), buffer, 8, ORDER_MSB, FALSE, -1, TRUE);
    if (messageId == OCTETSTRING(1, &MessageId)) {
      // Extract hashedId8
      p_utInitialize.hashedId8().RAW_decode(*p_utInitialize.hashedId8().get_descriptor(), buffer, 8 * 8, ORDER_MSB, FALSE, -1, TRUE);
      TTCN_Logger::end_event();
      return 0;
    }

    return -1;
  }

  BITSTRING fx__enc__UtInitialize(Ut__TypesAndValues::UtInitialize const & p_utInitialize) {
    log("Entering fx__enc__UtInitialize");

    TTCN_Buffer buffer;
    p_utInitialize.hashedId8().encode_raw(buffer);
    OCTETSTRING encvalue(buffer.get_len(), buffer.get_data());
    encvalue = OCTETSTRING(1, &MessageId) + encvalue;
    BITSTRING result;
    return oct2bit(encvalue);
  }

  void log(const char *fmt, ...) {
    TTCN_Logger::begin_event (TTCN_DEBUG);
    TTCN_Logger::log_event("Btp__EncodeDecode");
    va_list args;
    va_start(args, fmt);
    TTCN_Logger::log_event_va_list(fmt, args);
    va_end(args);
    TTCN_Logger::end_event();
  }
} // End of namespace Btp__EncodeDecode
