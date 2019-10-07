<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"

        giBPM = 100

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"
        #include "patterns/snareShuffle.orc"
        #include "patterns/hardAmenPattern.orc"


        instr breaks
            beatScoreline( "closeToMeBreakDiskgrain", 0, 8, {{ 0 }} )
            beatScoreline( "tenThousandYearsBreakDiskgrain", 8, 8, {{ 2 }} )
            beatScoreline( "sinkingBreakDiskgrain", 16, 8, {{ 0 0 }} )
            beatScoreline( "gumboBreakDiskgrain", 24, 8, {{ 10 }} )
            beatScoreline( "hairOfTheDogBreakDiskgrain", 32, 8, {{ 0 }} )
            beatScoreline( "gettinHappyBreakDiskgrain", 40, 8, {{ 0 }} )
            beatScoreline( "AmenBreakDiskgrain", 48, 8, {{ 4 }} )
            beatScoreline( "itsExpectedBreakDiskgrain", 56, 8, {{ 0 }} )
            beatScoreline( "funkyDrummerBreakDiskgrain", 64, 8, {{ 4 }} )
            beatScoreline( "loserInTheEndBreakDiskgrain", 72, 8, {{ 2 }} )
            beatScoreline( "transformationDayBreakDiskgrain", 80, 8, {{ 0 1 }} )
            beatScoreline( "thinkBreakDiskgrain", 88, 8, {{ 2 0 }} )
            beatScoreline( "tastyCakesBreakDiskgrain", 96, 8, {{ 0 }} )


          /*
            beatScoreline( "transformationDayBreakDiskin", 4, 4, {{ 0 0 }} )
        */
        ;beatScoreline( "handInTheHandBreakDiskin", 0, 4, {{ 2 2 }} )

        ;beatScoreline( "KeyGateBreakDiskin", 0, 4, {{ 0 .5 0 }} )
        ;beatScoreline( "KeyGateBreakDiskin", 4, 4, {{ 0 .5 0 }} )
        ;beatScoreline( "funkyDrummerBreakDiskin", 0, 2, {{ 4 0 }})
        ;beatScoreline( "funkyDrummerBreakDiskin", 2, .5, {{ 5 0 }})
        ;beatScoreline( "funkyDrummerBreakDiskin", 2.5, .5, {{ 5 0 }})
        ;beatScoreline( "funkyDrummerBreakDiskin", 3, 1, {{ 1.5 0 }})
        ;beatScoreline( "funkyDrummerBreakDiskin", 3, 1, {{ 5 0 }})
        ;beatScoreline( "funkyDrummerBreakDiskgrain", 0, 3.5, {{ 10 1 1 4 }} )

        ;beatScoreline( "hardAmenPattern", 0, 4, {{ }} )
        ;beatScoreline( "snareShuffle", 0, 4, {{ }} )

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
