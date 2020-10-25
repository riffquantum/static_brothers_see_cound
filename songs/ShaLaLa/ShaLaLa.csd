<CsoundSynthesizer>
  <CsOptions>
    -m0
    -Ma
    -t103.2
    -odac
    ; -W -o "ShaLaLa.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    gkBPM init 103.2

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/ShaLaLa/instruments/orchestra-manifest.orc"
    #include "songs/ShaLaLa/patterns/pattern-manifest.orc"

    instr Pattern1
      iPatternLength = secondsToBeats(p3)
      iBeatsPerMeasure = 8
      iMeasureCount = 0
      iSampleMode = 0

      until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
        iBaseTime = iMeasureCount*iBeatsPerMeasure

        ; beatScoreline "ShaLaLaLoop2", iBaseTime, 4, 120, 1
        ; beatScoreline "ShaLaLaLoop1", iBaseTime+4, 4, 120, 1

        iMeasureCount += 1
      od
    endin

  </CsInstruments>

  <CsScore>
    m section1
      i "ShaLaLaBounce" 0 64

    s
  </CsScore>
</CsoundSynthesizer>
