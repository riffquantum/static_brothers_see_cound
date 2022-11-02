<CsoundSynthesizer>
  <CsOptions>
    --messagelevel=0
    ; --midi-device=a
    ; -t100
    ; -t90
    -t70
    -odac
    ; -W -o "Withers.wav
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"
    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/Withers/instruments/orchestra-manifest.orc"
    #include "songs/Withers/patterns/pattern-manifest.orc"

    instr config
      gkWhoIsHeLoopPan = 0
    endin

    instr Pattern1
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 4
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        ; beatScoreline "Kick", iBaseTime+0, .01, 100,  1.1
        ; beatScoreline "Kick", iBaseTime+0.25, .01, 100,  1.1

        ; beatScoreline "Kick", iBaseTime+0.75+0.125, .01, 100,  1.1
        ; beatScoreline "Kick", iBaseTime+1, .01, 100,  1.1

        ; beatScoreline "Kick", iBaseTime+1.75+0.125, .01, 100,  1.1
        ; beatScoreline "Kick", iBaseTime+2, .01, 100,  1.1

        ; beatScoreline "Kick", iBaseTime+2.75+0.125, .01, 100,  1.1
        ; beatScoreline "Kick", iBaseTime+3, .01, 100,  1.1
        ; beatScoreline "Kick", iBaseTime+3.25, .01, 100,  1.1

        ; beatScoreline "Snare", iBaseTime+.5, .01, 100,  .9
        ; beatScoreline "Snare", iBaseTime+3.5, .01, 100,  .9


        ; beatScoreline "OpenHat", iBaseTime+0.0, 16, 80,  .25


        iMeasureCount += 1
      od
    endin

  </CsInstruments>

  <CsScore>
    i "config" -1
    i "WithersLoop2" 0 256
  </CsScore>
</CsoundSynthesizer>
