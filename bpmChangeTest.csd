<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"

        giBPM = 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"

        instr kickSnare1
            scoreline_i beatScoreline( "TR606", 0, 1, {{ "Kick" 1 1 0 0 0}} )
            scoreline_i beatScoreline( "TR606", 1, 1, {{ "Kick" 1 1 0}} )
            scoreline_i beatScoreline( "TR606", 2, 1, {{ "Kick" 1 1 0 1 1}} )
            scoreline_i beatScoreline( "TR606", 3, 1, {{ "Kick" 1 1 0 1 1}} )

            scoreline_i beatScoreline( "TR808", 0, 1, {{ "KickDrum5" 1 .5 0 0 0}} )
            scoreline_i beatScoreline( "TR808", 1, 1, {{ "KickDrum5" 1 .5 0}} )
            scoreline_i beatScoreline( "TR808", 2, 1, {{ "KickDrum5" 1 .5 0 1 1}} )
            scoreline_i beatScoreline( "TR808", 3, 1, {{ "KickDrum5" 1 .5 0 1 1}} )

            scoreline_i beatScoreline( "TR606", 1, 1, {{ "Snare" 1 1 0 0 0}} )
            scoreline_i beatScoreline( "TR606", 3, 1, {{ "Snare" 1 1 0 1 1}} )
        endin

        instr breaks
            scoreline_i beatScoreline( "thinkBreakDiskin", 0, 4, {{ 0 "1" }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 0, 4, {{ 4 "1" }} )
        endin


    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 100 #


            m section0
                t 0 100 8 100 8.1 170
                i "setBPM" 8 .1 170


                i "breaks" + 4
                i "breaks" + 4

                i "breaks" + 4
                i "breaks" + 4

                i "kickSnare1" + 4
                i "kickSnare1" + 4

                i "kickSnare1" + 4
                i "kickSnare1" + 4

            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
