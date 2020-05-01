;stereoRoute

opcode stereoRoute, 0, SS
	SInstrumentName, SInstrumentRoute xin

  connect SInstrumentName, strcat(SInstrumentName, "OutL"), SInstrumentRoute, strcat(SInstrumentRoute, "InL")
  connect SInstrumentName, strcat(SInstrumentName, "OutR"), SInstrumentRoute, strcat(SInstrumentRoute, "InR")
endop
