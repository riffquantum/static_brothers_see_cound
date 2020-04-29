gSMidiNoteSampleList[giPadC1Note] = "songs/sbDrumKit/samples/EA7804_R8_Oh.wav"
giMidiNoteDurationList[giPadC1Note] filelen gSMidiNoteSampleList[giPadC1Note]
giMidiNoteInterruptList[giPadC1Note] = 0

instr 2052 ;PadC1
  ; if giHatClutchIsOpen == 1 then
  ;   giHatClutchIsOpen = 0
  ;   printsBlock "Hi Hat Clutch Off"
  ; else
  ;   giHatClutchIsOpen = 1
  ;   printsBlock "Hi Hat Clutch On"
  ; endif
endin
