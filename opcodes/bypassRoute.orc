opcode bypassRoute, 0, SSS
  SInstrumentName, SDryRoute, SWetRoute xin

  SBypassSwitchName strcat SInstrumentName, "Input"
  SMixerChannelName strcat SInstrumentName, "MixerChannel"

  connect SBypassSwitchName, "OutDryL", SDryRoute, "InL"
  connect SBypassSwitchName, "OutDryR", SDryRoute, "InR"

  connect SBypassSwitchName, "OutWetL", SInstrumentName, "InL"
  connect SBypassSwitchName, "OutWetR", SInstrumentName, "InR"

  connect SInstrumentName, "OutL", SMixerChannelName, "InL"
  connect SInstrumentName, "OutR", SMixerChannelName, "InR"

  connect SMixerChannelName, "OutL", SWetRoute, "InL"
  connect SMixerChannelName, "OutR", SWetRoute, "InR"
endop
