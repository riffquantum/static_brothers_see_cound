/*
  selectTuningSystemAndReturnFrequency
  Accepts a pitch class input and returns a frequency in Hertz according
  to a chosen tuning system.

  Global Variables
    giGlobalTuningSystem - i - Should be defined in a song's config file as
    an integer that corresponds to a tuning system as defined in the body of
    this opcode.

  Input Arugments:
    iPitch - A pitch class value to be converted to Hertz.
    iTuningSystem - An integer referring to the tuning system through which the
      pitch class should be should be interpreted. Integers are associated with
      particular tuning systems in the body of the opcode. If none is provided,
      the opcode falls back to the giGlobalTuningSystem Value.
  Outputs:
    iFrequency - a frequency value in Hertz.

  To Do:
    Consider better ways of defining the tuning system list and pairing number of
    divisions with them somehow.
*/

opcode selectTuningSystemAndReturnFrequency, i, ij
  iPitch, iTuningSystem xin
  iTuningSystem = iTuningSystem == -1 ? giGlobalTuningSystem : iTuningSystem

  iOctave, iNoteNumber splitPitchClass iPitch

  if iTuningSystem == 0 then
    /*
      Csound's cpspch - Due to the particular implementation of this opcode
      some pitches of the standard 12-tone equally-tempered scale are very
      slightly mistuned (by at most 0.15 cents).
    */
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
    ; Turkish (?) Scale -- 24 tone scale based on 53-TET intervals
    iFrequency = customTuningFrequency(iOctave, iNoteNumber, giTurkishRatios)
  elseif iTuningSystem == 12 then
    ; https://en.wikipedia.org/wiki/Arab_tone_system
    ; https://en.wikipedia.org/wiki/17_equal_temperament
    ; https://en.wikipedia.org/wiki/Arabic_maqam#Tuning_system
    iFrequency = equalTempermentFrequency(iOctave, iNoteNumber, 17)
  elseif iTuningSystem == 13 then
    ; TO DO: https://en.wikipedia.org/wiki/Shruti_(music) and https://en.wikipedia.org/wiki/Just_intonation#Indian_scales
    ; Some sets based on Indian systems of 22 discernable tones.
  elseif iTuningSystem == 14 then
    iFrequency = customTuningFrequency(iOctave, iNoteNumber, giJustBaglama)
  endif

  xout iFrequency
endop
