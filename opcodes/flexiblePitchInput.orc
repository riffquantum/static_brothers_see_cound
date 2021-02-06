/* Return a frequency input value or MIDI input. Explicit input can accept numerical pitches (e.g. 6.01) or Hz values (e.g. 261.1). */

giGlobalTuningSystem = 1

opcode selectTuningSystemAndReturnFrequency, i, iio
  iPitch, iPitchOrNoteNumber, iTuningSystem xin
  iTuningSystem = iTuningSystem == 0 ? giGlobalTuningSystem : iTuningSystem

  ; if iTuningSystem <= 1 then
  ;   iFrequency = iPitchOrNoteNumber == 0 ? equalTempermentFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100) : equalTempermentMidiTuning(iPitch)
  ; elseif iTuningSystem == 2 then
  ;   iFrequency = iPitchOrNoteNumber == 0 ? pythagoreanFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100) : pythagoreanMidiTuning(iPitch)
  ; elseif iTuningSystem == 3 then
  ;   iFrequency = iPitchOrNoteNumber == 0 ? quarterCommaMeanToneFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100) : quarterCommaMeanToneMidiTuning(iPitch)
  ; elseif iTuningSystem >= 4 then
  ;   iFrequency = iPitchOrNoteNumber == 0 ? customTuningFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100) : customMidiTuning(iPitch)
  ; endif

  if iTuningSystem <= 1 then
    if iPitchOrNoteNumber == 0 then
      iFrequency = equalTempermentFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100)
    else
      iFrequency = equalTempermentMidiTuning(iPitch)
    endif
  elseif iTuningSystem == 2 then
    if iPitchOrNoteNumber == 0 then
      iFrequency = pythagoreanFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100)
    else
      iFrequency = pythagoreanMidiTuning(iPitch)
    endif
  elseif iTuningSystem == 3 then
    if iPitchOrNoteNumber == 0 then
      iFrequency = quarterCommaMeanToneFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100)
    else
      iFrequency = quarterCommaMeanToneMidiTuning(iPitch)
    endif
  elseif iTuningSystem >= 4 then
    if iPitchOrNoteNumber == 0 then
      iFrequency = customTuningFrequency(floor(iPitch), (iPitch - floor(iPitch)) * 100)
    else
      iFrequency = customMidiTuning(iPitch)
    endif
  endif

  xout iFrequency
endop

opcode flexiblePitchInput, i, io
  iPitch, iTuningSystem xin

  if iPitch != 0 && iPitch < 15 then
    iFrequency selectTuningSystemAndReturnFrequency iPitch, 0, iTuningSystem
  elseif iPitch > 15 then
    iFrequency = iPitch
  else
    iNoteNumber notnum
    iFrequency selectTuningSystemAndReturnFrequency iNoteNumber, 1, iTuningSystem
  endif

  xout iFrequency
endop



