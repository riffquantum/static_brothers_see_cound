<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t87.5
    -odac
    ; -W -o "TriplePortrait.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    gkBPM init 87.5

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/TriplePortrait/instruments/orchestra-manifest.orc"
    #include "songs/TriplePortrait/patterns/pattern-manifest.orc"

    instr Pattern1
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        beatScoreline "TriplePortraitLoop2", iBaseTime, 4, 120, 1
        beatScoreline "TriplePortraitLoop1", iBaseTime+4, 4, 120, 1

        iMeasureCount += 1
      od
    endin

  </CsInstruments>

  <CsScore>
    m section1
      i "Pattern1" 0 64

    s
  </CsScore>
</CsoundSynthesizer>
