<CsoundSynthesizer>

    <CsOptions>
      -odac
      -d
      --messagelevel=0
      -t161
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        ; #include "config/defaultMidiAssignments.orc"




        ; gkBPM init (60/(filelen("localSamples/GodRootUntitledSong/riff1.wav")/3))

        #include "opcodes/opcode-manifest.orc"
        #include "config/defaultMidiAssignments.orc"
        #include "config/defaultMidiRouterMapping.orc"
        #include "instruments/orchestra-manifest.orc"
        #include "songs/GodRootUntitled/instruments/orchestra-manifest.orc"
        #include "songs/GodRootUntitled/patterns/pattern-manifest.orc"

        opcode randomVariation, i, 0
        iVariation random -0.07, 0.07
        xout iVariation
      endop

      instr Riff1Pattern
        iPatternLength = secondsToBeats(p3)
        iBeatsPerMeasure = 6
        iMeasureCount = 0

        until iMeasureCount * iBeatsPerMeasure >= iPatternLength do
          iBaseTime = iMeasureCount*iBeatsPerMeasure

          beatScoreline("Riff1", iBaseTime+0.0, 3, 110, 1)
          beatScoreline("Riff1", iBaseTime+3.0, 3, 110, 1)
          beatScoreline("Snare", iBaseTime + 0, 1, 127, 1)
          beatScoreline("Snare", iBaseTime + 3, 1, 127, 1)

          ; beatScoreline("Kick", iBaseTime+3.0, 1, 127, 3)
          ; beatScorelineS("Kick", iBaseTime+1.0, 1, "3.3 1.01")
          ; beatScorelineS("Kick", iBaseTime+2.0, 1, "3.3 1.01")
          ; beatScorelineS("Kick", iBaseTime+3.0, 1, "3.3 1.01")

          ; beatScorelineS("Snare", iBaseTime + 1, 1, "3.3")

          ; beatScoreline("TomLow", iBaseTime + 2, 1, 120)

          ; beatScoreline("TomLow", iBaseTime + 2.33, 1, 120)
          ; ; beatScorelineS("Snare", iBaseTime + 1.333, 1, "3.3")

          ; ; ;beatScorelineS("Snare", iBaseTime + 2, 1, "3.2")

          ; ; beatScorelineS("TomMid", iBaseTime + 2, 1, "3.2")
          ; ; beatScorelineS("TomLow", iBaseTime + 2.5, 1, "3.2")
          ; ; beatScorelineS("TomLow", iBaseTime + 3.5, 1, "3.2")


          ; beatScorelineS("Crash", iBaseTime+0.0, 1.1, "3 .8")
          ; beatScorelineS("Crash", iBaseTime+1, 2, "4 .8")

          ; beatScorelineS("OpenHat", iBaseTime+2, 2, "2.1 .8")
          ; beatScorelineS("OpenHat", iBaseTime+3, 2, "2.1 .8")


          iMeasureCount += 1
        od
      endin
    </CsInstruments>

    <CsScore>
        m section1
          i "dBeat" 0 328
        s
    </CsScore>
</CsoundSynthesizer>

