giBohlenPierceRatios ftgen 0, 0, 0, 2, 1/1, 27/25, 25/21, 9/7, 7/5, 75/49, 5/3, 9/5, 49/25, 15/7, 7/3, 63/25, 25/9

opcode bohlenPierceMidiTuning, i, io
  iNoteNumber, iTuneJustly xin

  if iTuneJustly == 0 then
    iFrequency equalTempermentMidiTuning iNoteNumber, 13, 0, 3
  else
    ; iFrequency customMidiTuning iNoteNumber, giBohlenPierceRatios, 188.989, 3
    iFrequency customMidiTuning iNoteNumber, giBohlenPierceRatios, 440, 3
  endif

  xout iFrequency
endop
