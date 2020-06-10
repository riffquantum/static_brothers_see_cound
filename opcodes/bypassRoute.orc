opcode bypassRoute, 0, S
  SInstrumentName xin

  SBypassSwitchName strcat SInstrumentName, "Input"
  SMixerChannelName strcat SInstrumentName, "MixerChannel"

  connect SBypassSwitchName, "OutDryL", SMixerChannelName, "InL"
  connect SBypassSwitchName, "OutDryR", SMixerChannelName, "InR"

  connect SBypassSwitchName, "OutWetL", SInstrumentName, "InL"
  connect SBypassSwitchName, "OutWetR", SInstrumentName, "InR"

  connect SInstrumentName, "OutL", SMixerChannelName, "InL"
  connect SInstrumentName, "OutR", SMixerChannelName, "InR"
endop
