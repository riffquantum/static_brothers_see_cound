<CsoundSynthesizer>

  <CsOptions>
      ;-odac -m0
      -W -o "getDiluvian.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"

    gkBPM init 85

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

    #include "songs/getDiluvian/instruments/trrSample1.orc"
    #include "songs/getDiluvian/instruments/trrSample2.orc"
    #include "songs/getDiluvian/instruments/trrSample3.orc"
    #include "songs/getDiluvian/instruments/trrSample4.orc"
    #include "songs/getDiluvian/instruments/santanaSample1.orc"
    #include "songs/getDiluvian/instruments/santanaSample2.orc"
    #include "songs/getDiluvian/instruments/santanaSample3.orc"
    #include "songs/getDiluvian/instruments/santanaBell2.orc"

    gkloserInTheEndBreakFader init .75
    gkTR808Fader init .5
    gksantanaSample1Fader init .25
    gksantanaSample2Fader init .25

    #include "songs/getDiluvian/patterns/drumPattern1.orc"
    #include "songs/getDiluvian/patterns/drumPattern2.orc"
    #include "songs/getDiluvian/patterns/choralPattern.orc"
    #include "songs/getDiluvian/patterns/twistedTablas.orc"


    instr Intro
      beatScorelineS("choralPattern", 0, 26, "")

      beatScorelineS( "drumPattern2", 8, 4, "" )
      beatScorelineS( "drumPattern2", 12, 4, "" )
      beatScorelineS( "drumPattern2", 16, 4, "" )
      beatScorelineS( "drumPattern2", 20, 4, "" )
    endin

    instr verse1
      beatScorelineS( "santanaSample3Sndwarp", 0, 8, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 8, 8, ".7 .5 1.7" )

      beatScorelineS( "santanaSample3Sndwarp", 16, 8, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 24, 8, ".7 .5 1.7" )
      beatScorelineS( "santanaSample3Sndwarp", 24, 24, ".4 0 .42")
      beatScorelineS( "santanaSample3Sndwarp", 31, 15, ".4 0 .49")

      beatScorelineS( "santanaSample3Sndwarp", 32, 8, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 40, 8, ".7 .5 1.7" )


      beatScorelineS( "santanaSample1Sndwarp", 0, 4, "1" )
      beatScorelineS( "santanaSample2Sndwarp", 8, 4, "1.5" )
      beatScorelineS( "drumPattern1", 0, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 4, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 8, 4, {{ 1 }})
      beatScorelineS( "drumPattern1", 12, 4, {{ 2 }})


      beatScorelineS( "santanaSample1Sndwarp", 16, 4, "1" )
      beatScorelineS( "santanaSample2Sndwarp", 24, 4, "1.5" )
      beatScorelineS( "drumPattern1", 16 , 4, {{ 3 }})
      beatScorelineS( "drumPattern1", 20, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 24, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 28, 4, {{ 2 }})

      beatScorelineS( "santanaSample1Sndwarp", 32, 4, "1" )
      beatScorelineS( "santanaSample2Sndwarp", 40, 4, "1.5" )
      beatScorelineS( "drumPattern1", 32, 4, {{ 3 }})
      beatScorelineS( "drumPattern1", 36, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 40, 4, {{ 1 }})
      beatScorelineS( "drumPattern1", 44, 4, {{ 12 }})


      beatScorelineS( "twistedTablas", 16, 2, "" )
      beatScorelineS( "twistedTablas", 20, 2, "" )
      beatScorelineS( "twistedTablas", 24, 2, "" )
      beatScorelineS( "twistedTablas", 28, 2, "" )
    endin

    instr verse2
      beatScorelineS( "santanaSample3Sndwarp", 0, 8, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 8, 8, ".7 .5 1.7" )

      beatScorelineS( "santanaSample3Sndwarp", 16, 8, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 24, 8, ".7 .5 1.7" )
      beatScorelineS( "santanaSample3Sndwarp", 24, 24, ".4 0 .42")
      beatScorelineS( "santanaSample3Sndwarp", 31, 15, ".4 0 .49")

      beatScorelineS( "santanaSample3Sndwarp", 32, 8, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 40, 8, ".7 .5 1.7" )


      beatScorelineS( "santanaSample1Sndwarp", 0, 4, "1" )
      beatScorelineS( "santanaSample2Sndwarp", 8, 4, "1.5" )

      beatScorelineS("loserInTheEndBreakDiskin", 0, 2, {{  12 }})
      beatScorelineS( "drumPattern1", 0, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 4, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 8, 4, {{ 1 }})
      beatScorelineS( "drumPattern1", 12, 4, {{ 2 }})


      beatScorelineS( "santanaSample1Sndwarp", 16, 4, "1" )
      beatScorelineS( "santanaSample2Sndwarp", 24, 4, "1.5" )
      beatScorelineS( "santanaSample3Sndwarp", 28, 16, ".4 0 .38" )
      beatScorelineS( "drumPattern1", 16 , 4, {{ 3 }})
      beatScorelineS( "drumPattern1", 20, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 24, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 28, 4, {{ 2 }})

      beatScorelineS( "santanaSample1Sndwarp", 32, 4, "1" )
      beatScorelineS( "santanaSample2Sndwarp", 40, 4, "1.5" )
      beatScorelineS( "drumPattern1", 32, 4, {{ 3 }})
      beatScorelineS( "drumPattern1", 36, 4, {{ 0 }})
      beatScorelineS( "drumPattern1", 40, 4, {{ 1 }})
      beatScorelineS( "drumPattern1", 44, 4, {{ 12 }})


      beatScorelineS( "twistedTablas", 16, 2, "" )
      beatScorelineS( "twistedTablas", 20, 2, "" )
      beatScorelineS( "twistedTablas", 24, 2, "" )
      beatScorelineS( "twistedTablas", 28, 2, "" )
    endin

    instr bridge
      beatScorelineS( "santanaSample3Sndwarp", 0, 16, ".7 .5 1.9" )
      beatScorelineS( "santanaSample3Sndwarp", 16, 16, ".7 .5 1.9" )

      beatScorelineS( "santanaBell2Sndwarp", 2, 16, ".7 0 1.9" )
      beatScorelineS( "santanaBell2Sndwarp", 4, 16, ".7 0 2.1" )

      beatScorelineS( "santanaBell2Sndwarp", 10, 16, ".7 0 1.9" )
      beatScorelineS( "santanaBell2Sndwarp", 14, 16, ".7 0 2.1" )

      beatScorelineS( "santanaBell2Sndwarp", 22, 16, ".7 0 1.3" )
      beatScorelineS( "santanaBell2Sndwarp", 22.333, 16, ".7 0 1.36" )
      beatScorelineS( "santanaBell2Sndwarp", 22.666, 16, ".7 0 1.33" )

      beatScorelineS( "santanaBell2Sndwarp", 28, 16, ".7 0 1.3" )
      beatScorelineS( "santanaBell2Sndwarp", 28.333, 16, ".7 0 1.36" )
      beatScorelineS( "santanaBell2Sndwarp", 28.666, 16, ".7 0 1.33" )


      beatScorelineS( "itsExpectedBreakDiskin", 8, 3, {{ 0 }})
      beatScorelineS( "itsExpectedBreakDiskin", 12, 3, {{ 0 }})
      beatScorelineS( "itsExpectedBreakDiskin", 16, 3, {{ 0 }})
      beatScorelineS( "itsExpectedBreakDiskin", 20, 3, {{ 0 }})
      beatScorelineS( "itsExpectedBreakDiskin", 24, 3, {{ 0 }})
      beatScorelineS( "itsExpectedBreakDiskin", 28, 3, {{ 0 }})

      beatScorelineS( "drumPattern2", 8, 4, "" )
      beatScorelineS( "drumPattern2", 12, 4, "" )
      beatScorelineS( "drumPattern2", 16, 4, "" )
      beatScorelineS( "drumPattern2", 20, 4, "" )
      beatScorelineS( "drumPattern2", 24, 4, "" )
      beatScorelineS( "drumPattern2", 28, 4, "" )

      beatScorelineS( "santanaSample3Sndwarp", 32, 16, ".7 .5 1.9" )

      beatScorelineS( "santanaBell2Sndwarp", 34, 16, ".7 0 1.9" )
      beatScorelineS( "santanaBell2Sndwarp", 36, 16, ".7 0 2.1" )

      beatScorelineS( "santanaBell2Sndwarp", 38, 16, ".7 0 1.3" )
      beatScorelineS( "santanaBell2Sndwarp", 38.333, 16, ".7 0 1.36" )
      beatScorelineS( "santanaBell2Sndwarp", 38.666, 16, ".7 0 1.33" )
    endin

  </CsInstruments>

  <CsScore>
    #define bpm # 85 #

    m section1
      t 0 [$bpm]

      i "Intro" 0 24
      i "verse1" 24 48

      i "bridge" 72 42

      i "verse2" 116 48

      i "choralPattern" 164 26

    s
  </CsScore>
</CsoundSynthesizer>
