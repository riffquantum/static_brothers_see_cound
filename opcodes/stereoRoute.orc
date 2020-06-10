;stereoRoute

opcode stereoRoute, 0, SS
	SInstrumentName, SInstrumentRoute xin

  connect SInstrumentName, "OutL", SInstrumentRoute, "InL"
  connect SInstrumentName, "OutR", SInstrumentRoute, "InR"
endop
