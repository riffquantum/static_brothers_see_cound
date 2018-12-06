<CsoundSynthesizer>

    <CsOptions>
        -odac -m0
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"

        giBPM = 170

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        #include "patterns/sixteenthHats606.orc"

        instr pattern1
            itablaFactor = giBPM / 149.5

            SsampleString sprintfk {{ "tablasitarloop1.wav" %f 0}}, itablaFactor

            scoreline_i beatScoreline( "generalSamplerDiskin", 0, 8, SsampleString )
        endin

        instr breakbeatPattern
            scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            scoreline_i beatScoreline( "TR808", 1.5, 1, {{ "KickDrum5" 1 1 0 0 0}} )
            scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1 1 0 0 0}} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 0, 2, {{ 4 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 2, 2, {{ 10 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 4, 3, {{ 4 }} )
            scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 7, 1, {{ 11 }} )
            scoreline_i beatScoreline( "AmenBreakDiskin", 0, 8, {{ 4 }} )
        endin

        instr pattern2
            itablaFactor = giBPM / 146

            SsampleString sprintfk {{ "tablaloop2.wav" %f 0}}, itablaFactor

            scoreline_i beatScoreline( "generalSamplerDiskin", 0, 16, SsampleString )
        endin

        instr pattern3
            itablaFactor = giBPM / 146

            SsampleString sprintfk {{ "tablarasaranga2.wav" %f 0}}, itablaFactor

            scoreline_i beatScoreline( "generalSamplerDiskin", 0, 8, SsampleString )
        endin

        instr pattern4
            itablaFactor = giBPM / 153
            itablaSkipTime = p4

            SsampleString sprintfk {{ "tablabreakdown.wav" %f %f}}, itablaFactor, itablaSkipTime

            scoreline_i beatScoreline( "generalSamplerDiskin", 0, 8, SsampleString )
        endin

        
    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #

        #define bpm # 170 #
            m intro
                t 0 [$bpm]
                i "pattern3" 0 8
                i "breakbeatPattern" 0 8

                i "AmenBreakFader" 0 8 0 1
                i "funkyDrummerBreakFader" 0 8 0 1
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
