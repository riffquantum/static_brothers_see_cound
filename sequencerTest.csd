<CsoundSynthesizer>

  <CsOptions>
      -odac -m0
  </CsOptions>

  <CsInstruments>
      #include "config/defaultConfig.orc"
      #include "config/defaultMidiAssignments.orc"

      gkBPM init 80

      #include "opcodes/opcode-manifest.orc"
      #include "instruments/orchestra-manifest.orc"


      instr pattern1
          iStartTime = 0

          until iStartTime == 4 do
              beatScorelineS( "LinnDrum", iStartTime, 1, {{ "kick" 1 1 0}} )
              beatScorelineS( "LinnDrum", iStartTime, .5, {{ "HatClosed2" 1 .5 0}} )
              beatScorelineS( "LinnDrum", iStartTime + .5, .5, {{ "HatClosed2" 1 .5 0}} )

              if(iStartTime % 2 == 1) then
                  beatScorelineS( "LinnDrum", iStartTime, .5, {{ "Snare5" 1 .5 0}} )
              endif
              iStartTime = iStartTime + 1
          od

      endin

      instr pattern2
          iStartTime = 0
              beatScorelineS( "LinnDrum", .5, 1, {{ "kick" 1 1 0}} )
              beatScorelineS( "LinnDrum", .75, 1, {{ "kick" 1 1 0}} )

          until iStartTime == 4 do
              beatScorelineS( "LinnDrum", iStartTime, 1, {{ "kick" 1 1 0}} )
              beatScorelineS( "LinnDrum", iStartTime, .5, {{ "HatClosed2" 1 .5 0}} )
              beatScorelineS( "LinnDrum", iStartTime + .5, .5, {{ "HatClosed2" 1 .5 0}} )

              if(iStartTime % 2 == 1) then
                  beatScorelineS( "LinnDrum", iStartTime, .5, {{ "Snare5" 1 .5 0}} )
              endif
              iStartTime = iStartTime + 1
          od

      endin

      instr breaks
          beatScorelineS( "funkyDrummerBreakDiskin", 0, 1.5, {{ 4.9 }} )
              beatScorelineS( "funkyDrummerBreakDiskin", 1.5,  1.5, {{ 4.9 }} )
              beatScorelineS( "funkyDrummerBreakDiskin", 3,  1, {{ 4.9 }} )

          beatScorelineS( "itsExpectedBreakDiskin", 1, 1, {{ 1.5 }})
          beatScorelineS( "itsExpectedBreakDiskin", 2.5, 1, {{ 1.5}})

          beatScorelineS( "thinkBreakDiskin", 0, 2, {{ 2 0 }})
          beatScorelineS( "thinkBreakDiskin", 2, 2, {{ 0 0 }})
      endin
  </CsInstruments>

  <CsScore>
    #define beatsPerMeasure # 4 #

    #define bpm # 80 #


        t 0 [$bpm]


        i "pattern1" 0 4
        i "breaks" 0 4
        i "breaks" + 4
        i "breaks" + 4
        i "breaks" + 4

        i "pattern2" 4 4


        i "pattern2" + 4
        i "pattern2" + 4


        { 4 loopCount
        i "TR808" [($loopCount * $beatsPerMeasure) + 0]       1      "KickDrum5"          1    1 0

        i "TR808" [($loopCount * $beatsPerMeasure) + 2]       1      "KickDrum5"          1    1 0



        }

        ; 1  2  3  4  5  6  7  8  9  10  11 12
        ; A  A# B  C  C# D  D# E  F  F#  G  G#

  </CsScore>
</CsoundSynthesizer>
