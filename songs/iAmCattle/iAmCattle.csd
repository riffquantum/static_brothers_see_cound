<CsoundSynthesizer>

  <CsOptions>
      -odac -m0
      ;-W -o "iAmCattle.wav" -m0
  </CsOptions>

  <CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMidiAssignments.orc"

    giBPM = 100

    #include "opcodes/opcode-manifest.orc"
    #include "songs/iAmCattle/instruments/orchestra-manifest.orc"

    instr pattern1
      /*
      beatScoreline( "walkInTheSoftRainSampleDiskin", 0, 3.3, {{ 8.2 1 }} )
      beatScoreline( "funkyDrummerBreakDiskin", 0, 2, {{ 4 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 2, .5, {{ 5 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 2.5, .5, {{ 5 0 }})
      beatScoreline( "TR808", 1, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      beatScoreline( "TR808", 3, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      */
        beatScoreline( "funkyDrummerBreakDiskin", 0, 1, {{ .5 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 0, .75, {{ 4 0 }})

        beatScoreline( "funkyDrummerBreakDiskin", 1, 1, {{ 2 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 1, .75, {{ 5 0 }})

        beatScoreline( "funkyDrummerBreakDiskin", 2, 1, {{ 3 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 2, .75, {{ 5 0 }})

        beatScoreline( "funkyDrummerBreakDiskin", 3, 1, {{ 1.5 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 3, .75, {{ 4 0 }})
      beatScoreline( "walkInTheSoftRainSampleDiskin", 0, 3, {{ 32 1 }} )
      ;beatScoreline( "handInTheHandBreakDiskin", 0, 1, {{ 2 1 }} )
      ;beatScoreline( "handInTheHandBreakDiskin", 1, 2, {{ 0 0 }} )
    endin

    instr pattern2
      beatScoreline( "walkInTheSoftRainSampleDiskin", 0, 4, {{ 4.2 0 }} )
      beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      beatScoreline( "TR808", 1, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      beatScoreline( "TR808", 3, 2, {{ "KickDrum5" 1 1 0 0 0 }})
      /*
      beatScoreline( "funkyDrummerBreakDiskin", 0, 2, {{ 4 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 2, .5, {{ 5 0 }})
      */
        beatScoreline( "funkyDrummerBreakDiskin", 2.5, .5, {{ 5 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 3, 1, {{ 1.5 0 }})
        beatScoreline( "funkyDrummerBreakDiskin", 3, 1, {{ 5 0 }})
      ;beatScoreline( "walkInTheSoftRainSampleDiskin", 0, 3, {{ 32 1 }} )
      beatScoreline( "handInTheHandBreakDiskin", 0, 1, {{ 2 1 }} )
      beatScoreline( "handInTheHandBreakDiskin", 1, 2, {{ 0 0 }} )
      ;beatScoreline( "handInTheHandBreakDiskin", 0, 8, {{ 0 0 }} )
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
