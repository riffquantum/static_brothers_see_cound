$SNDWARP_SAMPLER(PalaceWarp'Mixer'localSamples/brokedownPalaceIntro.wav'9'0)
$MINCER_SAMPLER(PalaceMince'Mixer'localSamples/brokedownPalaceIntro.wav'9'0)
$PARTIKKEL_SAMPLER(PalacePart'Mixer'localSamples/brokedownPalaceIntro.wav'9'0)
$BREAK_SAMPLE(Palace'LiveMinceInput'localSamples/brokedownPalaceIntro.wav'9)
$PITCH_SHIFTER(PitchTest'Mixer'Mixer)
$LIVE_MINCER(LiveMince'Mixer'Mixer)

instr PitchTests
  ; gkPalaceMincePitchAdjustment = oscil(.25, .2) + 1
  ; gkPalaceMinceTimeStretch = oscil(.25, .2) + 1

  $PATTERN_LOOP(8)
    _ "Palace", i0, 8, 100, 0.5, 5.4
    ; _ "PalaceMince", i0, 16, 100, 4, 2
    ; _ "PalaceMince", i0, 8, 100, 4.08, .25, iMeasureIndex % 2
    ; _ "PalaceWarp", i0+8, 8, 100, 4 + iMeasureIndex/100, .25
    ; _ "PalaceWarp", i0+4, 4, 100, 1, 1
    if iMeasureCount % 2 == 0 then
      _ "LiveMince", i0, 8, semitone(iMeasureCount)
    endif
  $END_PATTERN_LOOP
endin
