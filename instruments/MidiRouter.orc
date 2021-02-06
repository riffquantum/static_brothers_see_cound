giMidiNoteInterruptList[][] init 20, 128
giEventsForNoteInstruments[][][] init 20, 128, 20
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

opcode twelveToneEqualTempermentPitchToMidiNoteNumber, i, i
  iPitch xin

  iNoteOctave = floor(iPitch)
  iNoteDecimal = iPitch - iNoteOctave

  iMidiNoteNumnbrOfC0 = 12
  iNoteNumber = round(iNoteOctave * 12 + iMidiNoteNumnbrOfC0 + iNoteDecimal * 100)

  xout iNoteNumber
endop


instr MidiRouter
  iNoteNumber notnum
  iNoteVelocity veloc
  kstatus, kchan, kdata1, kdata2  midiin
  iNoteVelocity = iNoteVelocity == 0 && p4 != 0 ? p4 : iNoteVelocity
  kstatus = kstatus == 144 && iNoteVelocity == 0 ? 128 : kstatus

  ; Convert Pitch values to midi notes
  if iNoteNumber == 0 && p5 != 0 then
    iNoteNumber = twelveToneEqualTempermentPitchToMidiNoteNumber(p5)
  endif

  iNoteNumber = iNoteNumber < 27 ? giTestNotes[iNoteNumber] : iNoteNumber

  handleNoteInterupts(giMidiNoteInterruptList[giCurrentSong][iNoteNumber])


  iEventsIndex = 0
  until iEventsIndex == lenarray(giEventsForNoteInstruments, 3) do
    iMidiEventTable = giEventsForNoteInstruments[giCurrentSong][iNoteNumber][iEventsIndex]
    if iMidiEventTable != 0 then
      iEventInstrumentNumber table 0, iMidiEventTable
      iEventStartTime table 1, iMidiEventTable
      iEventDuration table 2, iMidiEventTable

      iEventVelocity table 3, iMidiEventTable
      iEventVelocity = iEventVelocity == 0 ? iNoteVelocity : iEventVelocity

      iEventPitch table 4, iMidiEventTable
      iEventP6 table 5, iMidiEventTable
      iEventP7 table 6, iMidiEventTable
      iEventP8 table 7, iMidiEventTable
      iEventP9 table 8, iMidiEventTable
      iEventP10 table 9, iMidiEventTable

      event_i "i", iEventInstrumentNumber, iEventStartTime, iEventDuration, iEventVelocity, iEventPitch, iEventP6, iEventP7, iEventP8, iEventP9, iEventP10
    endif

    iEventsIndex = iEventsIndex + 1
  od

  skipNote:
endin
