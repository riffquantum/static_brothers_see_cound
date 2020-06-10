;instrumentRoute
; Sets up a mixer routes for an instrument. This opcode requries that an instrument
; follows certain naming and architectural conventions. It should have a mixer
; channel with the name "{instrument_name}MixerChannel" with stereo inputs and
; outputs named "In{L or R}" and "Out{L or R}".

opcode instrumentRoute, 0, SS
	SInstrumentName, SInstrumentRoute xin

  stereoRoute SInstrumentName, strcat(SInstrumentName, "MixerChannel")
  stereoRoute strcat(SInstrumentName, "MixerChannel"), SInstrumentRoute
endop
