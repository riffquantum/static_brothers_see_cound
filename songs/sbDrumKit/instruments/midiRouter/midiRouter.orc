gSMidiNoteSampleList[] init 128
giMidiNoteDurationList[] init 128
giMidiNoteInterruptList[] init 128
giMidiNoteInstanceList[][] init 128
giMidiNoteLastUsedFractionalModifierList[] init 128

massign 1, "MidiRouter"
instr MidiRouter
  iNoteNumber notnum

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
        if giMidiNoteLastUsedFractionalModifierList[iNoteNumber] == 0 then
          giMidiNoteLastUsedFractionalModifierList[iNoteNumber] = 1
        endif

        iInstrumentToInterrupt = iInstrumentToInterrupt + (giMidiNoteLastUsedFractionalModifierList[iNoteNumber] - 1)/1000
        iInstrumentNumber = iInstrumentNumber + (giMidiNoteLastUsedFractionalModifierList[iNoteNumber] )/1000

        if giMidiNoteLastUsedFractionalModifierList[iNoteNumber] == 999 then
          giMidiNoteLastUsedFractionalModifierList[iNoteNumber] = 1
        else
          giMidiNoteLastUsedFractionalModifierList[iNoteNumber] = giMidiNoteLastUsedFractionalModifierList[iNoteNumber] + 1
        endif

        turnoff2 iInstrumentToInterrupt, 4, 1
      else
        turnoff2 iInstrumentToInterrupt, 1, 1
      endif

    loop_lt iInterruptCounter, 1, iInterruptListLength, interruptLoop
  endif

  event_i   "i", iInstrumentNumber, 0, iLengthOfNote
endin
