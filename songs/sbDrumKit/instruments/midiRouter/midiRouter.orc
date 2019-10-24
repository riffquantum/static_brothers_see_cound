gSMidiNoteSampleList[] init 128
giMidiNoteDurationList[] init 128
giMidiNoteInterruptList[] init 128
giTestNotes[] init 30
giTriggerDecayTimes[] init 128

giCurrentSong = 0
giDoubleKickOn = 1
giHatClutchIsOpen = 1

massign 1, "MidiRouter"
instr MidiRouter
  iNoteNumber notnum
  iNoteVelocity veloc
  kstatus, kchan, kdata1, kdata2  midiin

  ; Convert test notes to equivalent values
  if iNoteNumber < 27 then
    iNoteNumber = giTestNotes[iNoteNumber]
  endif

  ; Check trigger buffer to prevent extra notes from acoustic drum triggers
  iTriggerBuffer triggerBuffer iNoteNumber, iNoteVelocity, giTriggerDecayTimes[iNoteNumber]
  if iTriggerBuffer == 0 then
    goto skipNote
  endif

  ; Sets some note-specific values
  iFrequency mtof iNoteNumber
  iLengthOfNote = giMidiNoteDurationList[iNoteNumber]
  iInterruptList = giMidiNoteInterruptList[iNoteNumber]
  iInstrumentNumber = 2000 + iNoteNumber

  ; Runs through interrupt list
  if iInterruptList != 0 then
    iInterruptListLength ftlen iInterruptList
    iInterruptCounter = 0
    interruptLoop:
      iInstrumentToInterruptNoteNumber table iInterruptCounter, iInterruptList

      iInstrumentToInterrupt = 2000 + iInstrumentToInterruptNoteNumber

      if iInstrumentToInterruptNoteNumber == iNoteNumber then
        iInstrumentNumber interruptThenTrigger iInstrumentNumber
      elseif iInstrumentToInterruptNoteNumber < 2000 then
        turnoff2 iInstrumentToInterruptNoteNumber, 1, 1
      else
        turnoff2 iInstrumentToInterrupt, 1, 1
      endif

    loop_lt iInterruptCounter, 1, iInterruptListLength, interruptLoop
  endif

  ; Triggers note instrument
  event_i   "i", iInstrumentNumber, 0, iLengthOfNote, iNoteVelocity

  ; Global Instruments
  if giCurrentSong == 1 then
    event_i   "i", "Photoshop", 0, .3, iNoteVelocity/127, iFrequency
  endif

  skipNote:
endin
