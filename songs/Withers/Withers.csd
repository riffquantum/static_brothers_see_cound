<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t30
    -odac
    ; -W -o "Withers.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    gkBPM init 30

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/Withers/instruments/orchestra-manifest.orc"
    #include "songs/Withers/patterns/pattern-manifest.orc"

    instr Pattern1
      iPatternLength = p3 * i(gkBPM)/60
      iBeatsPerMeasure = 4
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        beatScoreline "Kick", iBaseTime+0, .01, 70,  1.1
        beatScoreline "Kick", iBaseTime+0.25, .01, 70,  1.1

        beatScoreline "Kick", iBaseTime+0.75+0.125, .01, 70,  1.1
        beatScoreline "Kick", iBaseTime+1, .01, 70,  1.1

        beatScoreline "Kick", iBaseTime+1.75+0.125, .01, 70,  1.1
        beatScoreline "Kick", iBaseTime+2, .01, 70,  1.1

        beatScoreline "Kick", iBaseTime+2.75+0.125, .01, 70,  1.1
        beatScoreline "Kick", iBaseTime+3, .01, 70,  1.1
        beatScoreline "Kick", iBaseTime+3.25, .01, 70,  1.1

        beatScoreline "Snare", iBaseTime+.5, .01, 70,  .9
        beatScoreline "Snare", iBaseTime+1.5, .01, 70,  .9
        beatScoreline "Snare", iBaseTime+2.5, .01, 70,  .9
        beatScoreline "Snare", iBaseTime+3.5, .01, 70,  .9

        ; beatScoreline "Snare", iBaseTime+1, .01, 70,  .9
        ; beatScoreline "Snare", iBaseTime+3, .01, 70,  .9

        ; repeatNotes "ClosedHat", iBaseTime, iBeatsPerMeasure, 8, .125, 80, 1000, 3, .00

        beatScoreline "OpenHat", iBaseTime+0.0, 16, 80,  .25

        ; beatScoreline "Freezer", iBaseTime+1, 3, 1

        ; beatScoreline "PitchShifter", iBaseTime+1, 3, 1.5, .5

        ; beatScoreline "Freezer", iBaseTime+1.5, 4/8, .125, .125

        ; beatScoreline "Freezer", iBaseTime+2.5, 4/8, 1/16, 2/16

        iMeasureCount += 1
      od
    endin


  </CsInstruments>

  <CsScore>
    m section1
      i "WithersLoop1" 0 8
      i "WithersLoop2" 8 8
      i "WithersLoop1" 16 8
      i "WithersLoop2" 24 8
      i "Pattern1" 0 32
    s
  </CsScore>
</CsoundSynthesizer>
