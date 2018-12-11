<CsoundSynthesizer>

    <CsOptions>
        -odac
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRouting.orc"
        
        giBPM = 130

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #
        
        m beat1
        t 0 130
        { 4 loopCNT
            ;Beat 1
            i "TR606" [($loopCNT * $beatsPerMeasure) + 0]       1      "Kick"  1    1 0 0 1
                i "TR606" ^+0     .25    "ClosedHat"    1    1 0 0 0
                i "TR606" +       .25    "ClosedHat"    1    1 0 0 0
                i "TR606" +       .25    "ClosedHat"    1    1 0 0 0

                i "TR808" [($loopCNT * $beatsPerMeasure) + 0]       .25      "KickDrum0005"          1    1 0
                i "TR808" +       1      "KickDrum0005"          1    1 0


            ;Beat 2
            i "TR606" [($loopCNT * $beatsPerMeasure) + 1]       1    "Kick"    1    1 0 0 0
                i "TR606" ^+0       1    "Snare"    1    1 0 0 0
                i "TR606" ^+0     .25    "ClosedHat"    1    1 0 0 1
                i "TR606" +       .25    "ClosedHat"    1    1 0 0 0
                i "TR606" +       .25    "ClosedHat"    1    1 0 0 0
            ;Beat 3
            i "TR606" [($loopCNT * $beatsPerMeasure) + 2]       1    "Kick"    1    1 0 0 1
                i "TR606" ^+0     .25    "ClosedHat"    1    1 0 0 1
                i "TR606" +       .25    "ClosedHat"    1    1 0 0 0
                i "TR606" +       .25    "ClosedHat"    1    1 0 0 0
                i "TR606" +       .25    "OpenHat"    1    1 0 0 0
            ;Beat 4
            i "TR606" [($loopCNT * $beatsPerMeasure) + 3]       1    "Kick"    1    1 0 0 0
                i "TR606" ^+0       1    "Snare"    1    1 0 1 1
                i "TR606" ^+0     1    "Cymbal"    1    1 [$loopCNT - 2] 1 0
                i "TR606" ^+0     .25    "ClosedHat"    1    1 0 1 0
                i "TR606" +       .25    "ClosedHat"    1    1 0 1 0
                i "TR606" +       .25    "ClosedHat"    1    1 0 1 0
        }
        s
        m beat 2
            t 0 130
            i "TR808" 0       .5      "KickDrum0001"          1    1 0
            i "TR808" +       .5      "KickDrum0002"          1    1 0
            i "TR808" +       .5      "KickDrum0003"          1    1 0
            i "TR808" +       .5      "KickDrum0004"          1    1 0
            i "TR808" +       .5      "KickDrum0005"          1    1 0
            i "TR808" +       .5      "KickDrum0006"          1    1 0
            i "TR808" +       .5      "KickDrum0007"          1    1 0
            i "TR808" +       .5      "KickDrum0008"          1    1 0
            i "TR808" +       .5      "KickDrum0009"          1    1 0
            i "TR808" +       .5      "KickDrum0010"          1    1 0
            i "TR808" +       .5      "KickDrum0011"          1    1 0
            i "TR808" +       .5      "KickDrum0012"          1    1 0
            i "TR808" +       .5      "KickDrum0013"          1    1 0
            i "TR808" +       .5      "KickDrum0014"          1    1 0
            i "TR808" +       .5      "KickDrum0015"          1    1 0
            i "TR808" +       .5      "KickDrum0016"          1    1 0
            i "TR808" +       .5      "KickDrum0017"          1    1 0
            i "TR808" +       .5      "KickDrum0018"          1    1 0
            i "TR808" +       .5      "KickDrum0019"          1    1 0
            i "TR808" +       .5      "KickDrum0020"          1    1 0
            i "TR808" +       .5      "KickDrum0021"          1    1 0
            i "TR808" +       .5      "KickDrum0022"          1    1 0
            i "TR808" +       .5      "KickDrum0023"          1    1 0
        s
        n beat1
        m beat 3
        { 4 loopCNT
        t 0 130
        i "TR606" [($loopCNT * $beatsPerMeasure) + 0]       1    "Kick" 1    1 0 0 0
            i "TR606" ^+0.5     .25    "ClosedHat"    1    1 0 0 1

        i "TR606" [($loopCNT * $beatsPerMeasure) + 1]       1    "Kick" 1.5    1 0 0 0
        i "TR606" ^+0.25     .5    "kick"    1    1 0 0 0
            i "TR606" ^+0.5     .25    "ClosedHat"    1    1 0 0 0
            i "TR606" +     .25    "ClosedHat"    1    1 0 0 0

        i "TR606" [($loopCNT * $beatsPerMeasure) + 2]       1    "Kick" 1    1 0 0 0
            i "TR606" ^+0.5     .25    "ClosedHat"    1    1 0 0 1

        i "TR606" [($loopCNT * $beatsPerMeasure) + 3]       1    "Kick" .75    1 0 0 0  
            i "TR606" ^+0.5     .25    "ClosedHat"    1    1 0 0 1
        }
        s

            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
