#include "MyExample.hh"

namespace MyExample
{
  const unsigned char MessageId = 0x00;

  BITSTRING fx__encvalue__UtInitialize(const MyExample::UtInitialize & p_utInitialize)
  {
    TTCN_Buffer buffer;
    p_utInitialize.hashedId8().encode_raw(buffer);
    OCTETSTRING encvalue(buffer.get_len(), buffer.get_data());
    encvalue = OCTETSTRING(1, &MessageId) + encvalue;
    return oct2bit(encvalue);
  }

  INTEGER fx__decvalue__UtInitialize(BITSTRING & p_bitstring, MyExample::UtInitialize & p_utInitialize)
  {
    // Extract message identifier
    TTCN_Buffer buffer(bit2oct(p_bitstring));
    OCTETSTRING messageId;
    messageId.RAW_decode(*messageId.get_descriptor(), buffer, 8, ORDER_MSB, FALSE, -1, TRUE);
    if (messageId == OCTETSTRING(1, &MessageId)) {
      // Extract hashedId8
      p_utInitialize.hashedId8().RAW_decode(*p_utInitialize.hashedId8().get_descriptor(), buffer, 8 * 8, ORDER_MSB, FALSE, -1, TRUE);
      return 0;
    }

    return -1;
  }

  BITSTRING fx__encvalue__GnAddress(const MyExample::GN__Address& p_gnAddress)
  {
    TTCN_Buffer buffer;
    for (int field_id = 0; field_id < p_gnAddress.get_count(); field_id++)
      {
	const Base_Type * bt = p_gnAddress.get_at(field_id);
	TTCN_Buffer b;
	bt.encode_raw(b);
	buffer += b;
      }
    OCTETSTRING encvalue(buffer.get_len(), buffer.get_data());
    return oct2bit(encvalue);
  }

  INTEGER fx__decvalue__GnAddress(BITSTRING& p_bitstring, MyExample::GN__Address& p_gnAddress)
  {
    TTCN_Buffer buffer(bit2oct(p_bitstring));
    p_gnAddress.RAW_decode(*p_gnAddress.get_descriptor(), buffer, buffer.get_len(), ORDER_MSB, FALSE, -1, TRUE);
    return 0;
  }

} // End of namespace MyExample

