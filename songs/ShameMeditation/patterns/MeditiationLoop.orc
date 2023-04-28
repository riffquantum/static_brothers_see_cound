instr MeditationLoop
  ; gkSpectralDelayDelayTimeMod = oscil(.4, .1) + .5 ; linseg(1, beatsToSeconds(4), 1, beatsToSeconds(16), .1)

  _ "SpectralDelay", 0, stb(p3)

  if stb(p3) > 24 then
    _ "ChangeSpectralDelayTables2", 24, 12
  endif

  if stb(p3) > 48 then
    _ "ChangeSpectralDelayTables", 48, 12
  endif

  ; gaDrumsPointer = linseg:a(0, 4, .5, 1, .4, 1, .5, 1, .4)

  $PATTERN_LOOP(8)
    _ "DrumsScratch", i0, 8
    _ "Drums", i0, 8, 120, 1, iMeasureCount % 2 == 0 ? 8 : 0

    if iMeasureCount % 8 == 3 then
      _ "MoonScratch", i0+6, 8
    elseif iMeasureCount % 3 == 0 then
      _ "MoonScratch", i0, 8, 1
    elseif iMeasureCount % 4 == 1 then
      _ "MoonScratch", i0+3, 8, 2
    endif
  $END_PATTERN_LOOP

  ; $PATTERN_LOOP(4)
  ;   _ "DefaultClosedHat", i0+0.0, 1, 100, 1.05
  ;   ; _ "DefaultClosedHat", i0+0.5, 1, 70, 1
  ;   _ "DefaultClosedHat", i0+1.0, 1, 70, 1.0
  ;   ; _ "DefaultClosedHat", i0+1.5, 1, 70, 1
  ;   _ "DefaultClosedHat", i0+2.0, 1, 100, 1.05
  ;   ; _ "DefaultClosedHat", i0+2.5, 1, 70, 1
  ;   _ "DefaultClosedHat", i0+3.0, 1, 70, 1.0
  ;   ; _ "DefaultClosedHat", i0+3.5, 1, 70, 1
  ; $END_PATTERN_LOOP

  gkGrainDelayGrainFrequencyAdjustment = 1 + oscil(.05, .1, -1, .5)

  $PATTERN_LOOP(12)
    if iMeasureCount % 2 == 0 then
      _ "GrainDelay", i0, 12
    endif
    if iMeasureCount % 5 == 0 then
      _ "Tin", i0, 6, 80, -2/3, 2
    else
      _ "Tin", i0, 6, 80, -2/3, 0
    endif

    if iMeasureCount % 4 == 0 then
      _ "Tin", i0+6, 3, 30, -2/3, 5
    endif
  $END_PATTERN_LOOP
endin
