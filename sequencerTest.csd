<CsoundSynthesizer>

  <CsOptions>
      -odac -m0
  </CsOptions>

  <CsInstruments>
      #include "config/defaultConfig.orc"
      #include "config/defaultMixerRouting.orc"

      giBPM = 80

      #include "opcodes/opcode-manifest.orc"
      #include "instruments/orchestra-manifest.orc"


      instr pattern1
          iStartTime = 0

          until iStartTime == 4 do
              scoreline_i beatScoreline( "LinnDrum", iStartTime, 1, {{ "kick" 1 1 0}} )
              scoreline_i beatScoreline( "LinnDrum", iStartTime, .5, {{ "HatClosed2" 1 .5 0}} )
              scoreline_i beatScoreline( "LinnDrum", iStartTime + .5, .5, {{ "HatClosed2" 1 .5 0}} )

              if(iStartTime % 2 == 1) then
                  scoreline_i beatScoreline( "LinnDrum", iStartTime, .5, {{ "Snare5" 1 .5 0}} )
              endif
              iStartTime = iStartTime + 1
          od

      endin

      instr pattern2
          iStartTime = 0
              scoreline_i beatScoreline( "LinnDrum", .5, 1, {{ "kick" 1 1 0}} )
              scoreline_i beatScoreline( "LinnDrum", .75, 1, {{ "kick" 1 1 0}} )

          until iStartTime == 4 do
              scoreline_i beatScoreline( "LinnDrum", iStartTime, 1, {{ "kick" 1 1 0}} )
              scoreline_i beatScoreline( "LinnDrum", iStartTime, .5, {{ "HatClosed2" 1 .5 0}} )
              scoreline_i beatScoreline( "LinnDrum", iStartTime + .5, .5, {{ "HatClosed2" 1 .5 0}} )

              if(iStartTime % 2 == 1) then
                  scoreline_i beatScoreline( "LinnDrum", iStartTime, .5, {{ "Snare5" 1 .5 0}} )
              endif
              iStartTime = iStartTime + 1
          od

      endin

      instr breaks
          scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 0, 1.5, {{ 4.9 }} )
              scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 1.5,  1.5, {{ 4.9 }} )
              scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 3,  1, {{ 4.9 }} )

          scoreline_i beatScoreline( "itsExpectedBreakDiskin", 1, 1, {{ 1.5 }})
          scoreline_i beatScoreline( "itsExpectedBreakDiskin", 2.5, 1, {{ 1.5}})

          scoreline_i beatScoreline( "thinkBreakDiskin", 0, 2, {{ 2 0 }})
          scoreline_i beatScoreline( "thinkBreakDiskin", 2, 2, {{ 0 0 }})
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
