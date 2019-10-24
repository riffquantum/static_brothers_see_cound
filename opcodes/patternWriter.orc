opcode patternWriter 0, i
  iPatternLength xin

  ;play a tone at the beginning of each loop

  ;monitor midi input
  kStatusCode, kChannel, kData1, kData2 midiin
  ktrigger  changed  kStatusCode, kChannel, kData1, kData2

  ;write each event as a scoreline event
  if ktrigger=1 && kStatusCode!=0 then
  ; instrumentName, startTime, Duration, NoteNumber, Velocity
  endif
endop
