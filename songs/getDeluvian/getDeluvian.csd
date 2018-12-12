<CsoundSynthesizer>

  <CsOptions>
      -odac -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "songs/getDeluvian/config/mixerRoutes.orc"

    giBPM = 85

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

    #include "songs/getDeluvian/instruments/trrSample1.orc"
    #include "songs/getDeluvian/instruments/trrSample2.orc"
    #include "songs/getDeluvian/instruments/trrSample3.orc"
    #include "songs/getDeluvian/instruments/trrSample4.orc"
    #include "songs/getDeluvian/instruments/santanaSample1.orc"
    #include "songs/getDeluvian/instruments/santanaSample2.orc"

    gkloserInTheEndBreakFader init .75

    gkTR808Fader init .5

    instr twistedTablas

      scoreline_i beatScoreline( "trrSample2Sndwarp", 1, .5, "1" )


      scoreline_i beatScoreline( "trrSample1Sndwarp", 3, 1.25, "1" )


      scoreline_i beatScoreline( "trrSample3Sndwarp", 3.5, 2, "1" )
      scoreline_i beatScoreline( "trrSample4Sndwarp", 2, 2, "1" )

      scoreline_i beatScoreline( "trrSample2Sndwarp", 2, .33, "1" )

    endin

    #include "songs/getDeluvian/patterns/drumPattern1.orc"
    #include "songs/getDeluvian/patterns/drumPattern2.orc"

    instr Intro
      scoreline_i beatScoreline( "drumPattern2", 0, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 4, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 8, 4, "" )
      scoreline_i beatScoreline( "drumPattern2", 12, 4, "" )
    endin

    instr verse1
      ;scoreline_i beatScoreline( "santanaSample1Sndwarp", 0, 4, "1" )
      scoreline_i beatScoreline( "drumPattern1", 0, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 4, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 8, 4, {{ 1 }})
      scoreline_i beatScoreline( "drumPattern1", 12, 4, {{ 2 }})

      ;scoreline_i beatScoreline( "santanaSample1Sndwarp", 16, 4, "1" )
      scoreline_i beatScoreline( "drumPattern1", 16 , 4, {{ 3 }})
      scoreline_i beatScoreline( "drumPattern1", 20, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 24, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 28, 4, {{ 2 }})

      ;scoreline_i beatScoreline( "santanaSample1Sndwarp", 32, 4, "1" )
      scoreline_i beatScoreline( "drumPattern1", 32, 4, {{ 3 }})
      scoreline_i beatScoreline( "drumPattern1", 36, 4, {{ 0 }})
      scoreline_i beatScoreline( "drumPattern1", 40, 4, {{ 1 }})
      scoreline_i beatScoreline( "drumPattern1", 44, 4, {{ 12 }})


      scoreline_i beatScoreline( "twistedTablas", 16, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 20, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 24, 2, "" )
      scoreline_i beatScoreline( "twistedTablas", 28, 2, "" )
    endin

    instr sampleTests

      ;scoreline_i beatScoreline( "santanaSample2Sndwarp", 3, 4, "1" )

      ;scoreline_i beatScoreline( "santanaSample1Sndwarp", 3.66, .7, "1 3.1" )
      ;scoreline_i beatScoreline( "santanaSample1Sndwarp", 4.33, .7, "1 3.3" )

    endin

    instr chorus1
      scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})
      scoreline_i beatScoreline( "TR808", .5, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})

      scoreline_i beatScoreline( "TR808", 1.25, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})
      scoreline_i beatScoreline( "TR808", 1.5, 2, {{ "KickDrum5" 1.1 2 0 0 0 }})

      scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1 2 0 0 0 }})

      scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 1, {{  2 }})
      scoreline_i beatScoreline("loserInTheEndBreakDiskin", 1, 1, {{  2 }})
      scoreline_i beatScoreline("loserInTheEndBreakDiskin", 2, 2, {{  10 }})

    endin

  </CsInstruments>

  <CsScore>
    #define bpm # 85 #

    m section1
      t 0 [$bpm]
      i "generalSamplerFader" 0 .1 .025 .025


      i "santanaSample1Fader" 0 .1 .25 .25
      i "santanaSample2Fader" 0 .1 .25 .25
      i "Intro" 0 16
      i "verse1" 16 48

      i "chorus1" 64 4
      i "chorus1" 68 4

      i "verse1" 72 48

      i "chorus1" 120 4
      i "chorus1" 124 4
    s

    ; 1  2  3  4  5  6  7  8  9  10  11 12
    ; A  A# B  C  C# D  D# E  F  F#  G  G#

  </CsScore>
</CsoundSynthesizer>
