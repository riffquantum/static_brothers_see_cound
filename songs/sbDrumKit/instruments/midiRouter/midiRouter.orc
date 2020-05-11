gSMidiNoteSampleList[] init 128
giMidiNoteDurationList[] init 128
giMidiNoteInterruptList[] init 128
giTriggerDecayTimes[] init 128

giCurrentSong = 1
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

  if kstatus == 144 && iNoteVelocity == 0 then
    kstatus = 128
  endif

  ; Check trigger buffer to prevent extra notes from acoustic drum triggers
  iTriggerBuffer triggerBuffer iNoteNumber, iNoteVelocity, giTriggerDecayTimes[iNoteNumber]

  print giTriggerDecayTimes[iNoteNumber]
  print iTriggerBuffer

  if iTriggerBuffer == 0 then
    goto skipNote
  endif

  ; Sets some note-specific values
  iFrequency mtof iNoteNumber
  iLengthOfNote = (giMidiNoteDurationList[iNoteNumber] != 0 ? giMidiNoteDurationList[iNoteNumber] : 1/sr)
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
        interruptThenTrigger iInstrumentNumber, iLengthOfNote, iNoteVelocity
      elseif iInstrumentToInterruptNoteNumber < 2000 then
        turnoff2 iInstrumentToInterruptNoteNumber, 1, 1
        event_i   "i", iInstrumentNumber, 0, iLengthOfNote, iNoteVelocity
      else
        turnoff2 iInstrumentToInterrupt, 1, 1
        event_i   "i", iInstrumentNumber, 0, iLengthOfNote, iNoteVelocity
      endif

    loop_lt iInterruptCounter, 1, iInterruptListLength, interruptLoop
  else
    ; Triggers note instrument
    event_i   "i", iInstrumentNumber, 0, iLengthOfNote, iNoteVelocity
  endif

  ; Global Instruments
  if giCurrentSong == 1 then
    ; event_i   "i", "Photoshop", 0, 1, iNoteVelocity/127, iFrequency
    event_i   "i", "PhotoshopSamples", 0, 1, velocityToAmplitude(iNoteVelocity), iNoteNumber
  endif

  skipNote:
endin
