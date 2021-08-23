giMidiNoteInterruptList[/* song number */][/* midi note */] init 20, 128
giEventsForNoteInstruments[/* song number */][/* midi note */][/* event index*/] init 20, 128, 20
giGlobalEvents[/* song number */][/* event index */] init 20, 20
giCurrentSong = 0

opcode handleNoteInterupts, 0, i
  iInterruptList xin
  if iInterruptList != 0 then
    iInterruptCounter = 0
    interruptLoop:
      iInstrumentToInterrupt table iInterruptCounter, iInterruptList
      turnoff2 iInstrumentToInterrupt, 1, 1
    loop_lt iInterruptCounter, 1, ftlen(iInterruptList), interruptLoop
  endif
endop

opcode triggerEventFromTable, 0, ioo
  iEventTable, iNoteVelocity, iNotePitch xin

  iInterruptSelf table 0, iEventTable
  iEventInstrumentNumber table 1, iEventTable
  iEventStartTime table 2, iEventTable
  iEventDuration table 3, iEventTable

  iEventVelocity table 4, iEventTable
  iEventVelocity = iEventVelocity == 0 ? iNoteVelocity : iEventVelocity

  iEventPitch table 5, iEventTable
  iEventPitch = iEventPitch == 0 ? iNotePitch : iEventPitch

  iEventP6 table 6, iEventTable
  iEventP7 table 7, iEventTable
  iEventP8 table 8, iEventTable
  iEventP9 table 9, iEventTable
  iEventP10 table 10, iEventTable

  if iInterruptSelf == 0 then
    event_i "i", iEventInstrumentNumber, iEventStartTime, iEventDuration, iEventVelocity, iEventPitch, iEventP6, iEventP7, iEventP8, iEventP9, iEventP10
  else
    interruptThenTrigger iEventInstrumentNumber, iEventDuration, iEventVelocity, iEventPitch, iEventP6, iEventP7, iEventP8, iEventP9, iEventP10
  endif
endop

opcode triggerEventsForNoteNumber, 0, ii
  iNoteNumber, iNoteVelocity xin
  iEventsIndex = 0
  eventsLoop:
    iIndexToUse = lenarray(giGlobalEvents, 2) - 1 - iEventsIndex
    iEventTable = giEventsForNoteInstruments[giCurrentSong][iNoteNumber][iIndexToUse]

    if iEventTable != 0 then
      triggerEventFromTable(iEventTable, iNoteVelocity)
    endif
  loop_lt iEventsIndex, 1, lenarray(giEventsForNoteInstruments, 3), eventsLoop
endop

opcode triggerGlobalEvents, 0, ii
  iNoteNumber, iNoteVelocity xin
  iEventsIndex = 0

  giTestArray1[] init 1
  giTestArray1[0] = 1

  giTestArray2[][] init 1, 1
  giTestArray2[0][0] = 1

  eventsLoop:
    iEventTable = giGlobalEvents[giCurrentSong][iEventsIndex]

    if iEventTable != 0 then
      triggerEventFromTable(iEventTable, iNoteVelocity, midiNoteNumberToPitchClassValue(iNoteNumber))
    endif
  loop_lt iEventsIndex, 1, lenarray(giGlobalEvents, 2), eventsLoop
endop

instr MidiRouter
  iNoteNumber notnum
  iNoteVelocity veloc
  kstatus, kchan, kdata1, kdata2  midiin
  iNoteVelocity = iNoteVelocity == 0 && p4 != 0 ? p4 : iNoteVelocity
  kstatus = kstatus == 144 && iNoteVelocity == 0 ? 128 : kstatus

  ; Convert Pitch values to midi notes
  if iNoteNumber == 0 && p5 != 0 then
    iNoteNumber = pitchClassToIntegerNote(p5)
  endif

  iNoteNumber = iNoteNumber < 27 ? giTestNotes[iNoteNumber] : iNoteNumber

  triggerEventsForNoteNumber(iNoteNumber, iNoteVelocity)
  handleNoteInterupts(giMidiNoteInterruptList[giCurrentSong][iNoteNumber])
  triggerGlobalEvents(iNoteNumber, iNoteVelocity)
endin
