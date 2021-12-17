instr SetTuning
  giGlobalTuningSystem = p4
  giDivisionsInTuningSystem = p5
endin

instr mysteriousStomp
  gkLayeredBassSynthFader = .75
  gkGlobalFxChorusAmount = oscil(.5, .2) + 1

  gaGlobalFxTapeWobbleAmount = .05
  gaGlobalFxTapeWobbleSpeed = 1/beatsToSeconds(8)

  beatScoreline "LayeredBassSynthFxChorus", 0, -1
  beatScoreline "GlobalFxChorus", 0, -1
  ; beatScoreline "GlobalFxReverb", 0, -1

  $PATTERN_LOOP(4)
    beatScoreline "LayeredBassSynth", iBaseTime+0, 1.75, 120, 5.0
    beatScoreline "LayeredBassSynth", iBaseTime+1.75, .25, 120, 3.05
    beatScoreline "LayeredBassSynth", iBaseTime+2, .75, 120, 4.08
    beatScoreline "LayeredBassSynth", iBaseTime+2.75, .25, 120, 6.08
    beatScoreline "LayeredBassSynth", iBaseTime+3, .75, 120, 4.08
    beatScoreline "LayeredBassSynth", iBaseTime+3.75, .25, 120, 3.08
    beatScoreline "BirdshitKick", iBaseTime+0, 4, 90, 1
    ; beatScoreline "BirdshitKick", iBaseTime+(1/6), 4, 90, 1
    ; beatScoreline "BirdshitKick", iBaseTime+(.25), 4, 90, 1
    ; beatScoreline "BirdshitKick", iBaseTime+(2), 4, 90, 1

    beatScoreline "BirdshitCrash", iBaseTime+2, 4, 60, 1
    beatScoreline "BirdshitKick", iBaseTime+0.75, 4, 90, 1
    beatScoreline "BirdshitKick", iBaseTime+1.5, 4, 90, 1
    beatScoreline "BirdshitKick", iBaseTime+2, 4, 90, 1
    beatScoreline "BirdshitSnare", iBaseTime+1, .1, 120, 1
    beatScoreline "BirdshitSnare", iBaseTime+3, 4, 120, 1
    beatScoreline "BirdshitPitchedDownCrash", iBaseTime, 4, 40, 1

    iAmenPitch = iMeasureCount % 4 != 0 ? 5/6 : 1

    beatScoreline "AmenBreak", iBaseTime, 4, 100, iAmenPitch

    beatScoreline "Distorted808Kick", iBaseTime, 4, 127, .5
    beatScoreline "Distorted808Kick", iBaseTime+1+2/3, 4, 127, .5
    beatScoreline "Distorted808Kick", iBaseTime+3, 4, 127, .5
    beatScoreline "Distorted808Kick", iBaseTime, 4, 127, 1.5
    beatScoreline "Distorted808Kick", iBaseTime+1+2/3, 4, 127, 1
    beatScoreline "Distorted808Kick", iBaseTime+3, 4, 127, 2
    ; beatScoreline "TestInstrument", iBaseTime+0, 4, 70, -3.0, 4.25
    ; beatScoreline "TestInstrument", iBaseTime+0, 4, 70, 3.0, 6
    ; beatScoreline "TestInstrument", iBaseTime+0, 4, 70, 3.0, 0
  $END_PATTERN_LOOP

  $PATTERN_LOOP(16)
    if iMeasureCount % 2 == 0 then
      ; beatScoreline "GlobalFxTapeWobble", iBaseTime+0, 16
      beatScoreline "SetTuning", iBaseTime+0, 16, 6, ftlen(giPartchRatios)
    else
      beatScoreline "SetTuning", iBaseTime+0, 16, 1, 12
    endif

    beatScoreline "Ocarina", iBaseTime+0.0079819, 1.046107, 115, 4.100000
    beatScoreline "Ocarina", iBaseTime+1.0088435, 1.075132, 111, 5.000000
    beatScoreline "Ocarina", iBaseTime+2.0047468, 2.101890, 76, 4.060000
    beatScoreline "Ocarina", iBaseTime+4.0184429, 0.893726, 120, 4.100000
    beatScoreline "Ocarina", iBaseTime+6.0021466, 1.961602, 107, 4.060000
    beatScoreline "Ocarina", iBaseTime+5.0051550, 10.869841, 81, 5.000000
    beatScoreline "Ocarina", iBaseTime+8.0030234, 7.921391, 99, 5.060000
    beatScoreline "Ocarina", iBaseTime+8.0012094, 7.954044, 107, 4.100000

    beatScoreline "GlobalFxTapeWobbleNudge", iBaseTime+2, .5, .03, .1
    beatScoreline "GlobalFxTapeWobbleNudge", iBaseTime+8, 2, .015, 2, -1/beatsToSeconds(.5)
  $END_PATTERN_LOOP
endin
