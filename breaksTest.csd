<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        gkBPM init 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"
        #include "patterns/snareShuffle.orc"
        #include "patterns/hardAmenPattern.orc"


        instr breaks
            ;beatScorelineS( "TempoChanger", 0, 4, {{ 100 }} )
            beatScorelineS( "CloseToMeBreakDiskin", 0, 8, {{ 0 }} )
            beatScorelineS( "CloseToMeBreakDiskgrain", 8, 8, {{ 0 }} )
            beatScorelineS( "CloseToMeBreakDiskin", 16, 8, {{ 0 }} )

            ;beatScorelineS( "CloseToMeBreakDiskgrain", 0, 8, {{ 0 }} )
            ;beatScorelineS( "CloseToMeBreakDiskgrain", 8, 8, {{ 0 }} )
            ;beatScorelineS( "CloseToMeBreakDiskgrain", 16, 8, {{ 0 }} )


            beatScorelineS( "tenThousandYearsBreakDiskin", 8, 8, {{ 2 }} )
            beatScorelineS( "sinkingBreakDiskin", 16, 8, {{ 0 0 }} )
            beatScorelineS( "gumboBreakDiskin", 24, 8, {{ 10 }} )
            beatScorelineS( "hairOfTheDogBreakDiskin", 32, 8, {{ 0 }} )
            beatScorelineS( "gettinHappyBreakDiskin", 40, 8, {{ 0 }} )
            beatScorelineS( "AmenBreakDiskin", 48, 8, {{ 4 }} )
            beatScorelineS( "itsExpectedBreakDiskin", 56, 8, {{ 0 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 64, 8, {{ 4 }} )
            beatScorelineS( "loserInTheEndBreakDiskin", 72, 8, {{ 2 }} )
            beatScorelineS( "transformationDayBreakDiskin", 80, 8, {{ 0 1 }} )
            beatScorelineS( "thinkBreakDiskin", 88, 8, {{ 2 0 }} )
            beatScorelineS( "tastyCakesBreakDiskin", 96, 8, {{ 0 }} )


          /*
            beatScorelineS( "transformationDayBreakDiskin", 4, 4, {{ 0 0 }} )
        */
        ;beatScorelineS( "handInTheHandBreakDiskin", 0, 4, {{ 2 2 }} )

        ;beatScorelineS( "KeyGateBreakDiskin", 0, 4, {{ 0 .5 0 }} )
        ;beatScorelineS( "KeyGateBreakDiskin", 4, 4, {{ 0 .5 0 }} )
        ;beatScorelineS( "funkyDrummerBreakDiskin", 0, 2, {{ 4 0 }})
        ;beatScorelineS( "funkyDrummerBreakDiskin", 2, .5, {{ 5 0 }})
        ;beatScorelineS( "funkyDrummerBreakDiskin", 2.5, .5, {{ 5 0 }})
        ;beatScorelineS( "funkyDrummerBreakDiskin", 3, 1, {{ 1.5 0 }})
        ;beatScorelineS( "funkyDrummerBreakDiskin", 3, 1, {{ 5 0 }})
        ;beatScorelineS( "funkyDrummerBreakDiskgrain", 0, 3.5, {{ 10 1 1 4 }} )

        ;beatScorelineS( "hardAmenPattern", 0, 4, {{ }} )
        ;beatScorelineS( "snareShuffle", 0, 4, {{ }} )

        endin


    </CsInstruments>

    <CsScore>

        #define bpm # 100 #


            m section0
                t 0 [$bpm]

                i "breaks" + 114
                ;i "breaks" + 8
                ;i "breaks" + 8
                ;i "breaks" + 8



            s
            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
