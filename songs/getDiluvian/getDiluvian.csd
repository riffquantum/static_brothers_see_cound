<CsoundSynthesizer>

  <CsOptions>
      ;-odac -m0
      -W -o "getDiluvian.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "songs/getDiluvian/config/mixerRoutes.orc"

    giBPM = 85

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
      scoreline_i beatScoreline("choralPattern", 0, 26, "")

      scoreline_i beatScoreline( "drumPattern2", 8, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 12, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 16, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 20, 4, "" )
    endin

    instr verse1
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 0, 8, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 8, 8, ".7 .5 1.7" )

      scoreline_i beatScoreline( "santanaSample3Sndwarp", 16, 8, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 24, 8, ".7 .5 1.7" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 24, 24, ".4 0 .42")
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 31, 15, ".4 0 .49")

      scoreline_i beatScoreline( "santanaSample3Sndwarp", 32, 8, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 40, 8, ".7 .5 1.7" )


      scoreline_i beatScoreline( "santanaSample1Sndwarp", 0, 4, "1" )
      scoreline_i beatScoreline( "santanaSample2Sndwarp", 8, 4, "1.5" )
      scoreline_i beatScoreline( "drumPattern1", 0, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 4, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 8, 4, {{ 1 }})
      scoreline_i beatScoreline( "drumPattern1", 12, 4, {{ 2 }})


      scoreline_i beatScoreline( "santanaSample1Sndwarp", 16, 4, "1" )
      scoreline_i beatScoreline( "santanaSample2Sndwarp", 24, 4, "1.5" )
      scoreline_i beatScoreline( "drumPattern1", 16 , 4, {{ 3 }})
      scoreline_i beatScoreline( "drumPattern1", 20, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 24, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 28, 4, {{ 2 }})

      scoreline_i beatScoreline( "santanaSample1Sndwarp", 32, 4, "1" )
      scoreline_i beatScoreline( "santanaSample2Sndwarp", 40, 4, "1.5" )
      scoreline_i beatScoreline( "drumPattern1", 32, 4, {{ 3 }})
      scoreline_i beatScoreline( "drumPattern1", 36, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 40, 4, {{ 1 }})
      scoreline_i beatScoreline( "drumPattern1", 44, 4, {{ 12 }})


      scoreline_i beatScoreline( "twistedTablas", 16, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 20, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 24, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 28, 2, "" )
    endin

    instr verse2
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 0, 8, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 8, 8, ".7 .5 1.7" )

      scoreline_i beatScoreline( "santanaSample3Sndwarp", 16, 8, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 24, 8, ".7 .5 1.7" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 24, 24, ".4 0 .42")
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 31, 15, ".4 0 .49")

      scoreline_i beatScoreline( "santanaSample3Sndwarp", 32, 8, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 40, 8, ".7 .5 1.7" )


      scoreline_i beatScoreline( "santanaSample1Sndwarp", 0, 4, "1" )
      scoreline_i beatScoreline( "santanaSample2Sndwarp", 8, 4, "1.5" )

      scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 2, {{  12 }})
      scoreline_i beatScoreline( "drumPattern1", 0, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 4, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 8, 4, {{ 1 }})
      scoreline_i beatScoreline( "drumPattern1", 12, 4, {{ 2 }})


      scoreline_i beatScoreline( "santanaSample1Sndwarp", 16, 4, "1" )
      scoreline_i beatScoreline( "santanaSample2Sndwarp", 24, 4, "1.5" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 28, 16, ".4 0 .38" )
      scoreline_i beatScoreline( "drumPattern1", 16 , 4, {{ 3 }})
      scoreline_i beatScoreline( "drumPattern1", 20, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 24, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 28, 4, {{ 2 }})

      scoreline_i beatScoreline( "santanaSample1Sndwarp", 32, 4, "1" )
      scoreline_i beatScoreline( "santanaSample2Sndwarp", 40, 4, "1.5" )
      scoreline_i beatScoreline( "drumPattern1", 32, 4, {{ 3 }})
      scoreline_i beatScoreline( "drumPattern1", 36, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 40, 4, {{ 1 }})
      scoreline_i beatScoreline( "drumPattern1", 44, 4, {{ 12 }})


      scoreline_i beatScoreline( "twistedTablas", 16, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 20, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 24, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 28, 2, "" )
    endin

    instr bridge
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 0, 16, ".7 .5 1.9" )
      scoreline_i beatScoreline( "santanaSample3Sndwarp", 16, 16, ".7 .5 1.9" )

      scoreline_i beatScoreline( "santanaBell2Sndwarp", 2, 16, ".7 0 1.9" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 4, 16, ".7 0 2.1" )

      scoreline_i beatScoreline( "santanaBell2Sndwarp", 10, 16, ".7 0 1.9" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 14, 16, ".7 0 2.1" )

      scoreline_i beatScoreline( "santanaBell2Sndwarp", 22, 16, ".7 0 1.3" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 22.333, 16, ".7 0 1.36" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 22.666, 16, ".7 0 1.33" )

      scoreline_i beatScoreline( "santanaBell2Sndwarp", 28, 16, ".7 0 1.3" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 28.333, 16, ".7 0 1.36" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 28.666, 16, ".7 0 1.33" )


      scoreline_i beatScoreline( "itsExpectedBreakDiskin", 8, 3, {{ 0 }})
      scoreline_i beatScoreline( "itsExpectedBreakDiskin", 12, 3, {{ 0 }})
      scoreline_i beatScoreline( "itsExpectedBreakDiskin", 16, 3, {{ 0 }})
      scoreline_i beatScoreline( "itsExpectedBreakDiskin", 20, 3, {{ 0 }})
      scoreline_i beatScoreline( "itsExpectedBreakDiskin", 24, 3, {{ 0 }})
      scoreline_i beatScoreline( "itsExpectedBreakDiskin", 28, 3, {{ 0 }})

      scoreline_i beatScoreline( "drumPattern2", 8, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 12, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 16, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 20, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 24, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 28, 4, "" )

      scoreline_i beatScoreline( "santanaSample3Sndwarp", 32, 16, ".7 .5 1.9" )

      scoreline_i beatScoreline( "santanaBell2Sndwarp", 34, 16, ".7 0 1.9" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 36, 16, ".7 0 2.1" )

      scoreline_i beatScoreline( "santanaBell2Sndwarp", 38, 16, ".7 0 1.3" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 38.333, 16, ".7 0 1.36" )
      scoreline_i beatScoreline( "santanaBell2Sndwarp", 38.666, 16, ".7 0 1.33" )

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
