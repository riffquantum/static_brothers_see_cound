<CsoundSynthesizer>
    <CsOptions>
      -odac
      -d
      --messagelevel=0
      -B512 -b128
      ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        gkBPM init 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"
        #include "songs/thigpen/instruments/orchestra-manifest.orc"


        instr pattern1
            iamplitude = 5
            iPitch = 1
            iStartTime = 0.25
            iEndTime = 1.25

            ;until ibeatCount >= p3 do

              SparamString sprintfk {{ %f %f %f %f }}, iamplitude, iPitch, iStartTime, iEndTime

              beatScorelineS( "Thigpen1", 0, 3, SparamString )

              beatScorelineS("TR606", 0, 1, {{ "kick" 1 1 0 }})
              beatScorelineS("Kick", 0, 1, ".9")

            ;od

        endin

    </CsInstruments>

    <CsScore>
        #define bpm # 100 #

        m section1
          t 0 [$bpm]

          i "pattern1" 0 4
          i "pattern1" + 4
          i "pattern1" + 4
        s

    </CsScore>
</CsoundSynthesizer>
