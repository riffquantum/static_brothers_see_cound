opcode selectTuningSystemAndReturnFrequency, i, io
  iPitch, iTuningSystem xin
  iTuningSystem = iTuningSystem == 0 ? giGlobalTuningSystem : iTuningSystem

  iOctave, iNoteNumber splitPitchClass iPitch

  if iTuningSystem == 0 then
    ;Csound's cpspch - Note From the Manual: The conversion from pch, oct, or midinn into cps is not a linear operation but involves an exponential process that could be time-consuming when executed repeatedly. Csound now uses a built-in table lookup to do this efficiently, even at audio rates. Because the table index is truncated without interpolation, pitch resolution when using one of these opcodes is limited to 8192 discrete and equal divisions of the octave, and some pitches of the standard 12-tone equally-tempered scale are very slightly mistuned (by at most 0.15 cents). If you need more precision in the calculation, use cps2pch or cpsxpch instead.
    iFrequency = cpspch(iOctave + (iNoteNumber/100) + 4)
  elseif iTuningSystem == 1 then
    ; 12 Tone Equal Temperment
    iFrequency = equalTempermentFrequency(iOctave, iNoteNumber)
  elseif iTuningSystem == 2 then
    ; 24 Tone Equal Temperment
    iFrequency = equalTempermentFrequency(iOctave, iNoteNumber, 24)
  elseif iTuningSystem == 3 then
    ; 12 Tone Pythagorean
    iFrequency = pythagoreanFrequency(iOctave, iNoteNumber)
  elseif iTuningSystem == 4 then
    ; Quarter Comma Mean Tone
    iFrequency = quarterCommaMeanToneFrequency(iOctave, iNoteNumber)
  elseif iTuningSystem == 5 then
    ; Custom Set of Intervals
    iFrequency = customTuningFrequency(iOctave, iNoteNumber)
  elseif iTuningSystem == 6 then
    ; Partch Scale
    iFrequency = customTuningFrequency(iOctave, iNoteNumber, giPartchRatios)
  elseif iTuningSystem == 7 then
    ; Bohlen-Pierce Equal Temperment
    iFrequency = equalTempermentFrequency(iOctave, iNoteNumber, 13, 0, 3)
  elseif iTuningSystem == 8 then
    ; Just Bohlen-Pirece
    iFrequency = customTuningFrequency(iOctave, iNoteNumber, giBohlenPierceRatios, 0, 3)
  elseif iTuningSystem == 9 then
    ; 432hz 12 Tone Equal Temperment
    iFrequency = equalTempermentFrequency(iOctave, iNoteNumber, 12, 432)
  elseif iTuningSystem == 10 then
    ; Csound's cps2pch
    iFrequency = cps2pch((iOctave + (iNoteNumber/100) + 4), giDivisionsInTuningSystem)
  elseif iTuningSystem == 11 then
    ; Turkish (?) Scale
    iFrequency = customTuningFrequency(iOctave, iNoteNumber, giTurkishRatios)
  elseif iTuningSystem == 12 then
    ; https://en.wikipedia.org/wiki/Arab_tone_system
    ; https://en.wikipedia.org/wiki/17_equal_temperament
    ; https://en.wikipedia.org/wiki/Arabic_maqam#Tuning_system
    iFrequency = equalTempermentFrequency(iOctave, iNoteNumber, 17)
  elseif iTuningSystem == 13 then
    ; TO DO: https://en.wikipedia.org/wiki/Shruti_(music) and https://en.wikipedia.org/wiki/Just_intonation#Indian_scales
    ; Some sets based on Indian systems of 22 discernable tones.
  endif

  xout iFrequency
endop
