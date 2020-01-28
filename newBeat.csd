<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"

        gkBPM init 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"

        instr kickSnare1
            beatScorelineS( "TR606", 0, 1, {{ "Kick" 1 1 0 0 0}} )
            beatScorelineS( "TR606", 1, 1, {{ "Kick" 1 1 0}} )
            beatScorelineS( "TR606", 2, 1, {{ "Kick" 1 1 0 1 1}} )
            beatScorelineS( "TR606", 3, 1, {{ "Kick" 1 1 0 1 1}} )

            beatScorelineS( "TR808", 0, 1, {{ "KickDrum5" 1 .5 0 0 0}} )
            beatScorelineS( "TR808", 1, 1, {{ "KickDrum5" 1 .5 0}} )
            beatScorelineS( "TR808", 2, 1, {{ "KickDrum5" 1 .5 0 1 1}} )
            beatScorelineS( "TR808", 3, 1, {{ "KickDrum5" 1 .5 0 1 1}} )

            beatScorelineS( "TR606", 1, 1, {{ "Snare" 1 1 0 0 0}} )
            beatScorelineS( "TR606", 3, 1, {{ "Snare" 1 1 0 1 1}} )
        endin

        instr breaks
            beatScorelineS( "thinkBreakDiskin", 0, 4, {{ 0 "1" }} )
            beatScorelineS( "AmenBreakDiskin", 0, 4, {{ 4 "1" }} )
        endin

        instr breakTesting
            ;beatScorelineS( "thinkBreakDiskin", 0, 4, {{ 0 "1" }} )
            ;beatScorelineS( "itsExpectedBreakDiskin", 0, 4, {{ 4 "1" }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 0, 2, {{ 2 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 2, 2, {{ 1 }} )

            beatScorelineS( "LinnDrum", 0, 1, {{ "kick" 1 1 0 }} )

            beatScorelineS( "LinnDrum", .5, 1, {{ "kick" 1 1 0 }} )

            beatScorelineS( "LinnDrum", 2.5, 1, {{ "kick" 1 1 0 }} )
            beatScorelineS( "LinnDrum", 3.5, .5, {{ "kick" 1 1 0 }} )


            beatScorelineS( "LinnDrum", 0, 2, {{ "crash" 1 .1 0 }} )
            beatScorelineS( "LinnDrum", 2, 2, {{ "ride" 1 .1 0 }} )

            ;beatScorelineS( "AmenBreakDiskin", 0, 4, {{ 4 "1" }} )
        endin

        instr breakTesting2
            ;beatScorelineS( "thinkBreakDiskin", 0, 4, {{ 0 "1" }} )
            ;beatScorelineS( "itsExpectedBreakDiskin", 0, 4, {{ 4 "1" }} )
            beatScorelineS( "thinkBreakDiskin", 0, 2, {{ 2 "4" }} )
            beatScorelineS( "thinkBreakDiskin", 2, 2, {{ 0 "3" }} )

            beatScorelineS( "LinnDrum", 0, 1, {{ "kick" 1 1 0 }} )

            beatScorelineS( "LinnDrum", .5, 1, {{ "kick" 1 1 0 }} )

            beatScorelineS( "LinnDrum", 2.5, 1, {{ "kick" 1 1 0 }} )
            beatScorelineS( "LinnDrum", 3.5, .5, {{ "kick" 1 1 0 }} )


            beatScorelineS( "LinnDrum", 0, 2, {{ "crash" 1 .1 0 }} )
            ;beatScorelineS( "LinnDrum", 2, 2, {{ "ride" 1 .1 0 }} )

            ;beatScorelineS( "AmenBreakDiskin", 0, 4, {{ 4 "1" }} )
        endin
    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 100 #


            m section0
                t 0 [$bpm]
                i "breakTesting" 0 4
                i "breakTesting" + 4
                i "breakTesting2" 8 4
                i "breakTesting2" + 4

            s

            m section1
                t 0 [$bpm]
                { 2 loopCount
                    i "breaks" + 4
                    i "breaks" + 4
                    i "breaks" + 8

                }

                { 2 loopCount
                    i "sixteenthHats606" + 4 .25 10 3 .0
                    i "sixteenthHats606" + 4 .25 0 0 0
                    i "sixteenthHats606" + 4 .25 0 0 .05
                    i "sixteenthHats606" + 4 .25 50 3 .03

                }


                i "kickSnare1" 16 4
                i "kickSnare1" + 4
                i "kickSnare1" + 4
                i "kickSnare1" + 4

                i "AmenBreakFader" 0 32 1 .1
                i "thinkBreakFader" 0 32 .1 1
                i "AmenBreakPan" 0 32 0 100
                i "thinkBreakPan" 0 32 100 0
            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
