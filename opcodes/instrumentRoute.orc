;instrumentRoute
; Sets up a mixer routes for an instrument. This opcode requries that an instrument
; follows certain naming and architectural conventions. It should have a mixer
; channel with the name "{instrument_name}MixerChannel" with stereo inputs and
; outputs named "{instrument_name}In{L or R}" and "{instrument_name}Out{L or R}".

opcode instrumentRoute, 0, SS
	SInstrumentName, SInstrumentRoute xin

  connect SInstrumentName, strcat(SInstrumentName, "OutL"), strcat(SInstrumentName, "MixerChannel"), strcat(SInstrumentName, "InL")
  connect SInstrumentName, strcat(SInstrumentName, "OutR"), strcat(SInstrumentName, "MixerChannel"), strcat(SInstrumentName, "InR")

  connect strcat(SInstrumentName, "MixerChannel"), strcat(SInstrumentName, "OutL"), SInstrumentRoute, strcat(SInstrumentRoute, "InL")
  connect strcat(SInstrumentName, "MixerChannel"), strcat(SInstrumentName, "OutR"), SInstrumentRoute, strcat(SInstrumentRoute, "InR")
endop
