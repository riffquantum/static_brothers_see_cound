gSMidiNoteSampleList[] init 128
giMidiNoteDurationList[] init 128
giMidiNoteInterruptList[] init 128
giTestNotes[] init 30

massign 1, "MidiRouter"
instr MidiRouter
  iNoteNumber notnum
  iNoteVelocity veloc
  kstatus, kchan, kdata1, kdata2  midiin

  if iNoteNumber < 27 then
    iNoteNumber = giTestNotes[iNoteNumber]
  endif

  iFrequency mtof iNoteNumber

  SSamplePath = gSMidiNoteSampleList[iNoteNumber]
  iLengthOfNote = giMidiNoteDurationList[iNoteNumber]

  iInterruptList = giMidiNoteInterruptList[iNoteNumber]


  iInstrumentNumber = 2000 + iNoteNumber

  if iInterruptList != 0 then
    iInterruptListLength ftlen iInterruptList
    iInterruptCounter = 0
    interruptLoop:
      iInstrumentToInterruptNoteNumber table iInterruptCounter, iInterruptList

      iInstrumentToInterrupt = 2000 + iInstrumentToInterruptNoteNumber

      if iInstrumentToInterruptNoteNumber == iNoteNumber then
        iInstrumentNumber interruptThenTrigger iInstrumentNumber
      elseif iInstrumentToInterruptNoteNumber > 3000 then
        turnoff2 iInstrumentToInterruptNoteNumber, 1, 1
      else
        turnoff2 iInstrumentToInterrupt, 1, 1
      endif

    loop_lt iInterruptCounter, 1, iInterruptListLength, interruptLoop
  endif

  event_i   "i", iInstrumentNumber, 0, iLengthOfNote, iNoteVelocity

  ;event_i   "i", "Photoshop", 0, iLengthOfNote, iNoteVelocity/127, iFrequency
endin
