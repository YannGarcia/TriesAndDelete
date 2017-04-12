
#pragma once

#include <TTCN3.hh>

namespace Btp__EncodeDecode {
  INTEGER fx__dec__UtInitialize(BITSTRING&, Ut__TypesAndValues::UtInitialize&);
  BITSTRING fx__enc__UtInitialize(Ut__TypesAndValues::UtInitialize const&);
} / End of namespace Btp__EncodeDecode
