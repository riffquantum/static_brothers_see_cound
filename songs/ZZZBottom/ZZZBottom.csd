<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t57.6
    ; -t72 ;and it's in 5
    -odac
    ; -W -o "ZZZBottom.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/ZZZBottom/config/midiAssignments.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/ZZZBottom/instruments/orchestra-manifest.orc"
    #include "songs/ZZZBottom/patterns/pattern-manifest.orc"

    instr config
      gkItsOnlyLoveFader = 1.5
      gkKickFader = .5
      gkBassPluckFader = .25
      gkGrowlOnFader = .8
      gkDescentTwinkleFader = .7
    endin

    instr Pattern1
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 4
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        beatScoreline "ItsOnlyLove", iBaseTime+0, iBeatsPerMeasure, 100,  3.09

        if iMeasureCount > 1 then
          beatScoreline "GrowlOn", iBaseTime+0, 2, 100,  2.02
          beatScoreline "GrowlOn", iBaseTime+2, 1, 100,  2.01
        endif
        beatScoreline "ClosedHat", iBaseTime+0, 1, 100,  1.1
        beatScoreline "ClosedHat", iBaseTime+.25, 1, 60,  1.1
        beatScoreline "ClosedHat", iBaseTime+.5, 1, 60,  1.1
        beatScoreline "OpenHat", iBaseTime+1.333, 4, 50,  1.1

        beatScoreline "Kick", iBaseTime+0, 1, 100,  1.1
        beatScoreline "Kick", iBaseTime+1/3, 1, 100,  1.1
        beatScoreline "Kick", iBaseTime+2, 1, 100,  1.1
        beatScoreline "Kick", iBaseTime+2.25, 1, 100,  1.1
        beatScoreline "Kick", iBaseTime+2.5, 1, 100,  1.1
        beatScoreline "Kick", iBaseTime+3, 1, 100,  1.1

        beatScoreline "ClosedHat", iBaseTime+2.25, 1, 100,  1.2
        beatScoreline "ClosedHat", iBaseTime+3.25, 1, 100,  1.2
        beatScoreline "OpenHat", iBaseTime+3, 4, 50,  1.1


        iMeasureCount += 1
      od
    endin

    instr TwinklePattern
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        ; beatScoreline "DescentTwinkle", iBaseTime+0, .75, 100,  5.03
        ; beatScoreline "DescentTwinkle", iBaseTime+.5, 2, 100,  5.02

        beatScoreline "DescentTwinkle", iBaseTime+0, 8, 50,  3.07

        iMeasureCount += 1
      od
    endin

    instr TwinklePattern2
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        if iMeasureCount == 2 then
          beatScoreline "DescentTwinkle", iBaseTime+3.92, 4, 70,  4.06
          beatScoreline "DescentTwinkle", iBaseTime+2.92, 1, 74,  5.06
        endif

        if iMeasureCount > 2 then
          beatScoreline "DescentTwinkle", iBaseTime+-.05, .69, 70,  5.03
          beatScoreline "DescentTwinkle", iBaseTime+.69, 3.25, 70,  5.02

          beatScoreline "DescentTwinkle", iBaseTime+3.92, 4, 70,  4.06
        endif

        iMeasureCount += 1
      od
    endin

    instr TwinklePattern3
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

          beatScoreline "DescentTwinkle", iBaseTime+0, 1/3, 70,  5.10
          beatScoreline "DescentTwinkle", iBaseTime+2/3, 1/3, 74,  6.09
          beatScoreline "DescentTwinkle", iBaseTime+4/3, 1/3, 74,  6.10
          beatScoreline "DescentTwinkle", iBaseTime+3.75, 2, 74,  5.06

        iMeasureCount += 1
      od
    endin

    instr BassLine1
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        beatScoreline "BassPluck", iBaseTime+0, 2, 100,  2.01
        beatScoreline "BassPluck", iBaseTime+2, 1, 100,  2.00
        beatScoreline "BassPluck", iBaseTime+3, 5, 100,  1.08
        beatScoreline "BassPluck", iBaseTime+4, 4, 100,  2.08

        iMeasureCount += 1
      od
    endin


    instr PatternRecorder
      iPatternLength = p4
      kTimeSinceStart timeinsts


      ;instrument event

    endin

  </CsInstruments>

  <CsScore>
    m section1
      i "config" 0 .1
      ; i "Pattern1" 0 128
      ; i "TwinklePattern3" 0 128
      i "Pattern1" 0 56
      i "TwinklePattern2" 0 56
      i "TwinklePattern" 56 8
      i "Pattern1" 64 56
      i "TwinklePattern2" 40 80
      ; i "BassLine1" 0 128
    s
  </CsScore>
</CsoundSynthesizer>
