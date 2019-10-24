gSMidiNoteSampleList[giPadC3Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC3Note] filelen gSMidiNoteSampleList[giPadC3Note]
giMidiNoteInterruptList[giPadC3Note] = 0

instr PadC3, 2058
  if giMetronomeIsOn == 1 then
    giMetronomeIsOn = 0
    prints "Metronome is Off"
  else
    giMetronomeIsOn = 1
    prints "Metronome is On"
  endif
endin
