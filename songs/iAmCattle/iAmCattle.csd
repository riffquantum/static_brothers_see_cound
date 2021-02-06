<CsoundSynthesizer>

  <CsOptions>
      -odac -m0
      ;-W -o "IAmCattle.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"
    #include "config/defaultMidiRouterMapping.orc"

    gkBPM init 100

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"
    #include "songs/IAmCattle/instruments/orchestra-manifest.orc"

    instr pattern1
      /*
      beatScorelineS( "walkInTheSoftRainSampleDiskin", 0, 3.3, {{ 8.2 1 }} )
      beatScorelineS( "FunkyDrummerBreak", 0, 2, {{ 4 1 }})
        beatScorelineS( "FunkyDrummerBreak", 2, .5, {{ 5 1 }})
        beatScorelineS( "FunkyDrummerBreak", 2.5, .5, {{ 5 1 }})
      beatScorelineS( "TR808", 1, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      beatScorelineS( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      beatScorelineS( "TR808", 3, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      */
        beatScorelineS( "FunkyDrummerBreak", 0, 1, {{ .5 1 }})
        beatScorelineS( "FunkyDrummerBreak", 0, .75, {{ 4 1 }})

        beatScorelineS( "FunkyDrummerBreak", 1, 1, {{ 2 1 }})
        beatScorelineS( "FunkyDrummerBreak", 1, .75, {{ 5 1 }})

        beatScorelineS( "FunkyDrummerBreak", 2, 1, {{ 3 1 }})
        beatScorelineS( "FunkyDrummerBreak", 2, .75, {{ 5 1 }})

        beatScorelineS( "FunkyDrummerBreak", 3, 1, {{ 1.5 1 }})
        beatScorelineS( "FunkyDrummerBreak", 3, .75, {{ 4 1 }})
      beatScorelineS( "walkInTheSoftRainSampleDiskin", 0, 3, {{ 32 1 }} )
      ;beatScorelineS( "handInTheHandBreakDiskin", 0, 1, {{ 2 1 }} )
      ;beatScorelineS( "handInTheHandBreakDiskin", 1, 2, {{ 0 1 }} )
    endin

    instr pattern2
      beatScorelineS( "walkInTheSoftRainSampleDiskin", 0, 4, {{ 4.2 1 }} )
      beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      beatScorelineS( "TR808", 1, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      beatScorelineS( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      beatScorelineS( "TR808", 3, 2, {{ "KickDrum5" 1 1 0 0 1 }})
      /*
      beatScorelineS( "FunkyDrummerBreak", 0, 2, {{ 4 1 }})
        beatScorelineS( "FunkyDrummerBreak", 2, .5, {{ 5 1 }})
      */
        beatScorelineS( "FunkyDrummerBreak", 2.5, .5, {{ 5 1 }})
        beatScorelineS( "FunkyDrummerBreak", 3, 1, {{ 1.5 1 }})
        beatScorelineS( "FunkyDrummerBreak", 3, 1, {{ 5 1 }})
      ;beatScorelineS( "walkInTheSoftRainSampleDiskin", 0, 3, {{ 32 1 }} )
      beatScorelineS( "handInTheHandBreakDiskin", 0, 1, {{ 2 1 }} )
      beatScorelineS( "handInTheHandBreakDiskin", 1, 2, {{ 0 1 }} )
      ;beatScorelineS( "handInTheHandBreakDiskin", 0, 8, {{ 0 1 }} )
    endin

  </CsInstruments>

  <CsScore>
    #define bpm # 100 #

    m section1
      t 0 [$bpm]

      i "pattern1" 0 4
      i "pattern1" 4 4
      i "pattern1" 8 4
      i "pattern2" 12 4

      i "pattern1" 16 4
      i "pattern1" 20 4
      i "pattern1" 24 4
      i "pattern2" 28 4
    s
  </CsScore>
</CsoundSynthesizer>
