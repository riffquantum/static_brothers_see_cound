/* Return a frequency input value or MIDI input. Explicit input can accept numerical pitches (e.g. 6.01) or Hz values (e.g. 261.1). */
/* To Do: Build Midi Pitch bend into this */
opcode flexiblePitchInput, i, ioo
  iPitch, iTuningSystem, iDivisionsInTuningSystem xin
  iTuningSystem = iTuningSystem == 0 ? giGlobalTuningSystem : iTuningSystem
  iDivisionsInTuningSystem = iDivisionsInTuningSystem == 0 ? giDivisionsInTuningSystem : iDivisionsInTuningSystem

  if iPitch == 0 then
    iPitch midiNoteNumberToPitchClassValue notnum(), iDivisionsInTuningSystem
  endif

  if iPitch < 15 then
    iFrequency selectTuningSystemAndReturnFrequency iPitch, iTuningSystem
  else
    iFrequency = iPitch
  endif

  xout iFrequency
endop
