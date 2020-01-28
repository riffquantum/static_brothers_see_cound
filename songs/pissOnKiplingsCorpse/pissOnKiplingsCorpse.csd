<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMidiAssignments.orc"

        gkBPM init 170

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"

        instr pattern1
            itablaFactor = i(gkBPM) / 149.5

            SsampleString sprintfk {{ "tablasitarloop1.wav" %f 0}}, itablaFactor

            beatScorelineS( "generalSamplerDiskin", 0, 8, SsampleString )
        endin

        instr breakbeatPattern
            beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 1.5, 1, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 0}} )


            beatScorelineS( "funkyDrummerBreakDiskin", 0, 2, {{ 4 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 2, 2, {{ 10 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 4, 3, {{ 4 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 7, 1, {{ 11 }} )

            beatScorelineS( "AmenBreakDiskin", 0, 8, {{ 4 }} )
        endin

        instr breakbeatPattern2
            beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 1.5, 1, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 6.5, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "funkyDrummerBreakDiskin", 0, 2, {{ 4 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 2, 2, {{ 1 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 4, 3, {{ 4 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 7, 1, {{ 11 }} )


            ;beatScorelineS( "AmenBreakDiskin", 0, 8, {{ 4 }} )
        endin

        instr breakbeatPattern3
            beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 1.5, 1, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 0}} )


            beatScorelineS( "funkyDrummerBreakDiskin", 0, .25, {{ 4 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", .25, 1, {{ 4 }} )

            beatScorelineS( "funkyDrummerBreakDiskin", .25, .25, {{ .5 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", .5, 1.5,
                {{ .25 }} )


            beatScorelineS( "funkyDrummerBreakDiskin", 2, 2, {{ 1 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 4, 2, {{ .5 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 6, 2, {{ .5 }} )

            ;beatScorelineS( "AmenBreakDiskin", 0, 8, {{ 4 }} )
        endin

        instr breakbeatPattern4
            beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            ;beatScorelineS( "TR808", 1.5, 1, {{ "KickDrum5" 1 2 0 0 0}} )
            beatScorelineS( "TR808", 2.5, 2, {{ "KickDrum5" 1 1 0 0 0}} )

            beatScorelineS( "TR808", 4, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            beatScorelineS( "TR808", 6.5, 1.5, {{ "KickDrum5" 1.3 1 0 0 0}} )
            beatScorelineS( "TR808", 6.75, 2, {{ "KickDrum5" 1.2 1.2 0 0 0}} )

            beatScorelineS( "funkyDrummerBreakDiskin", 1, .55, {{ .5 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 3, .55, {{ .5 }} )

            beatScorelineS( "funkyDrummerBreakDiskin", 5, .55, {{ .5 }} )
            beatScorelineS( "funkyDrummerBreakDiskin", 7, .55, {{ .5 }} )


            beatScorelineS( "TR606", .5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 1.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 2.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 3.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 4.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 5.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 6, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 6.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            ;beatScorelineS( "TR606", 7, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            ;beatScorelineS( "TR606", 7.25, .3, {{ "ClosedHat" 1 1 0 0 0 }})
            beatScorelineS( "TR606", 7.5, .3, {{ "ClosedHat" 1 1 0 0 0 }})


        endin

        instr pattern2
            itablaFactor = i(gkBPM) / 146

            SsampleString sprintfk {{ "tablaloop2.wav" %f 0}}, itablaFactor

            beatScorelineS( "generalSamplerDiskin", 0, 16, SsampleString )
        endin

        instr pattern3
            itablaFactor = i(gkBPM) / 146

            SsampleString sprintfk {{ "tablarasaranga2.wav" %f 0}}, itablaFactor

            beatScorelineS( "generalSamplerDiskin", 0, 8, SsampleString )
        endin

        instr pattern4
            itablaFactor = i(gkBPM) / 153
            itablaSkipTime = p4

            SsampleString sprintfk {{ "tablabreakdown.wav" %f %f}}, itablaFactor, itablaSkipTime

            beatScorelineS( "generalSamplerDiskin", 0, 8, SsampleString )
        endin


    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 170 #




            m intro
                t 0 [$bpm]
               i "breakbeatPattern4" 0 8
               i "breakbeatPattern4" 8 8
               i "breakbeatPattern4" 16 8
               i "breakbeatPattern4" 24 8

                i "pattern3" 28 8
                i "breakbeatPattern" 28 8

                i "AmenBreakFader" 28 8 0 1
                i "funkyDrummerBreakFader" 28 8 0 1
            s


            m section1
                t 0 [$bpm]
                ;i "pattern3" 0 8
                i "pattern4" 0 8 12.3
                i "pattern4" + 8 12.3
                i "pattern4" + 8 12.3
                i "pattern4" + 8 12.3

                i "breakbeatPattern" 0 8
                i "breakbeatPattern" + 8
                i "breakbeatPattern" + 8
                i "breakbeatPattern" + 8
            s

            m section0
                t 0 [$bpm]
                i "breakbeatPattern" 0 8
                i "breakbeatPattern" + 8
                i "breakbeatPattern" + 8
                i "breakbeatPattern" + 8
                i "breakbeatPattern" + 8
                i "breakbeatPattern" + 8


                i "pattern1" 0 8
                i "pattern1" + 8
                i "pattern1" ^+24 8
                i "pattern1" + 8

                i "pattern3" 8 8
                i "pattern2" 16 16
            s



            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
