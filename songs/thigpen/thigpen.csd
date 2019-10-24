<CsoundSynthesizer>
    <CsOptions>
        -odac -m0
        ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        giBPM = 120

        #include "opcodes/opcode-manifest.orc"
        #include "songs/thigpen/instruments/orchestra-manifest.orc"


        instr pattern1
            iamplitude = 5
            iPitch = 1
            iStartTime = 0.25
            iEndTime = 1.25

            ;until ibeatCount >= p3 do

              SparamString sprintfk {{ %f %f %f %f }}, iamplitude, iPitch, iStartTime, iEndTime

              beatScoreline( "thigpen1", 0, 4, SparamString )

              beatScoreline("TR606", 0, 1, {{ "kick" 1 1 0 }})
              ;beatScoreline("kick", 0, 1, ".9")

            ;od

        endin

    </CsInstruments>

    <CsScore>
        #define bpm # 120 #

        m section1
          t 0 [$bpm]

          i "pattern1" 0 4
          i "pattern1" 4 4
          i "pattern1" 8 4
        s

    </CsScore>
</CsoundSynthesizer>
