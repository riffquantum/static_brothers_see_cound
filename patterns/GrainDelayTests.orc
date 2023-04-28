$BREAK_SAMPLE(GrainDelayTestSample1'PatchDelayInput'localSamples/punishmentAwaits.wav'2)
$RECURSIVE_GRAIN_DELAY(PatchDelay'Mixer'Mixer)

$BREAK_SAMPLE(GrainDelayTestSample2'GrainToDelayInput'localSamples/punishmentAwaits.wav'2)
$GRAIN_TO_DELAY(GrainToDelay'Mixer'Mixer)

$BREAK_SAMPLE(GrainDelayTestSample3'DelayToGrainInput'localSamples/punishmentAwaits.wav'2)
$DELAY_TO_GRAIN(DelayToGrain'Mixer'Mixer)

instr PatchDelayTest
  gkPatchDelayGrainTimeStretch = 0.251 + poscil:a(.25, .2)
  gkPatchDelayGrainGrainSizeAdjustment = 5
  gkPatchDelayGrainGrainFrequencyAdjustment = 1 + poscil:a(.25, .1)
  gkPatchDelayGrainPitch = 1 + poscil:a(.25, .2)
  gkPatchDelayGrainGrainOverlapPercentageAdjustment = 1 + poscil:a(.25, .5)

  _ "PatchDelay", 0, stb(p3)

  $PATTERN_LOOP(12)
    _ "GrainDelayTestSample1", i0, 2, 100, .65, .6
  $END_PATTERN_LOOP
endin

instr GrainToDelayTest
  gkGrainToDelayGrainTimeStretch = 0.251 + poscil:a(.25, .2)
  gkGrainToDelayGrainGrainSizeAdjustment = 5
  gkGrainToDelayGrainGrainFrequencyAdjustment = 1 + poscil:a(.25, .1)
  gkGrainToDelayGrainPitch = 1 + poscil:a(.25, .2)
  gkGrainToDelayGrainGrainOverlapPercentageAdjustment = 1 + poscil:a(.25, .5)

  _ "GrainToDelay", 0, stb(p3)\

  $PATTERN_LOOP(12)
    _ "GrainDelayTestSample2", i0, 2, 100, .65, .6
  $END_PATTERN_LOOP
endin

instr DelayToGrainTest
  gkDelayToGrainGrainTimeStretch = 0.251 + poscil:a(.25, .2)
  gkDelayToGrainGrainGrainSizeAdjustment = 5
  gkDelayToGrainGrainGrainFrequencyAdjustment = 1 + poscil:a(.25, .1)
  gkDelayToGrainGrainPitch = 1 + poscil:a(.25, .2)
  gkDelayToGrainGrainGrainOverlapPercentageAdjustment = 1 + poscil:a(.25, .5)

  _ "DelayToGrain", 0, stb(p3)

  $PATTERN_LOOP(12)
    _ "GrainDelayTestSample3", i0, 2, 100, .65, .6
  $END_PATTERN_LOOP
endin

instr GrainDelayTests
  $PATTERN_LOOP(36)
    _ "PatchDelayTest", i0, 12
    _ "DelayToGrainTest", i0+12, 12
    _ "GrainToDelayTest", i0+24, 12
  $END_PATTERN_LOOP
endin
