gSMidiNoteSampleList[giPadC3Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC3Note] filelen gSMidiNoteSampleList[giPadC3Note]
giMidiNoteInterruptList[giPadC3Note] = 0

instr PadC3, 2058
  event_i "i", "MetronomeSwitch", 0, 1/sr
endin
