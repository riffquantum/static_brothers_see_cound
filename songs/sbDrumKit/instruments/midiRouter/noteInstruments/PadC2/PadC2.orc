gSMidiNoteSampleList[giPadC2Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC2Note] filelen gSMidiNoteSampleList[giPadC2Note]
giMidiNoteInterruptList[giPadC2Note] = 0

instr 2057 ;, PadC2
  if giDoubleKickOn == 1 then
    giDoubleKickOn = 0
    prints "Double Kick Off"
  else
    giDoubleKickOn = 1
    prints "Double Kick On"
  endif
endin
