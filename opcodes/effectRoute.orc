opcode effectRoute, 0, SSS
  SInstrumentName, SDryRoute, SWetRoute xin

  SBypassSwitchName strcat SInstrumentName, "Input"
  SMixerChannelName strcat SInstrumentName, "MixerChannel"

  connect SInstrumentName, "OutDryL", SDryRoute, "InL"
  connect SInstrumentName, "OutDryR", SDryRoute, "InR"

  connect SInstrumentName, "OutWetL", SMixerChannelName, "InL"
  connect SInstrumentName, "OutWetR", SMixerChannelName, "InR"

  connect SMixerChannelName, "OutL", SWetRoute, "InL"
  connect SMixerChannelName, "OutR", SWetRoute, "InR"
endop
