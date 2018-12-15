<CsoundSynthesizer>

    <CsOptions>
        -odac
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"
        
        giBPM = 120

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 4 #
        m beat1

        t 0 120
        { 4 loopCNT

            ;Beat 1
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       1      "kick"          1    .5 0
                i "LinnDrum" ^+0   .5    "HatClosed2"   1    .2


                i "LinnDrum" ^+0   0.25    "hatopen"       1    .1 [$loopCNT % 2 - 1]

                i "LinnDrum" +     .25     "HatClosed2"    1    .25 [$loopCNT % 2 - 1]

                i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0.25]     1    "snare9"       1    .3 [$loopCNT % 2 - 1]

                i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0.5]       1      "kick"          1    .5 0


            ;Beat 2
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "kick"          1    .5 0
                i "LinnDrum" ^+0     1    "snare9"       1    .5
                i "LinnDrum" ^+0     .5     "HatClosed2"   1    .2

                i "LinnDrum" +     .5     "HatClosed5"    1    .25

                i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1.75]     1    "snare9"       1    .25

            ;Beat 3
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 2]       1    "kick"          1    .5
                i "LinnDrum" ^+0     .5     "HatClosed2"   1    .2
                i "LinnDrum" +     .5     "HatClosed7"    1    .25



                i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 2.25]     1    "snare9"       1    .3
            ;Beat 4
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "kick"          1    .5
                i "LinnDrum" ^+0     1    "snare8"       1    .6
                i "LinnDrum" ^+0     .5     "HatClosed2"   1    .2
                i "LinnDrum" +     .5     "HatClosed2"    1    .25

            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "Tambourine"          1    .5 [($loopCNT + 1) % 4]
        }
        s

        #define beatsPerMeasure # 4 #
        m beat2
        t 0 130
        { 4 loopCNT
            ;Beat 1
            i "TR808" [($loopCNT * $beatsPerMeasure) + 0]       1      "KickDrum0005"          1    1 0
                i "TR808" ^+0   .5    "Closed HiHat0001"   1    1


                i "TR808" ^+0   0.25    "Open Hihat0001"       1    1 [$loopCNT % 2 - 1]

                i "TR808" +     .25     "Closed HiHat0001"    1    1 [$loopCNT % 2 - 1]

                i "TR808" [($loopCNT * $beatsPerMeasure) + 0.25]     1    "SnareDrum0001"       1    1 [$loopCNT % 2 - 1]

                i "TR808" [($loopCNT * $beatsPerMeasure) + 0.5]       1      "KickDrum0005"          1    1 0


            ;Beat 2
            i "TR808" [($loopCNT * $beatsPerMeasure) + 1]       1    "KickDrum0005"          1    1 0
                i "TR808" ^+0     1    "SnareDrum0001"       1    1
                i "TR808" ^+0     .5     "Closed HiHat0001"   1    1

                i "TR808" +     .5     "Closed HiHat0002"    1    1

                i "TR808" [($loopCNT * $beatsPerMeasure) + 1.75]     1    "SnareDrum0001"       1    1

            ;Beat 3
            i "TR808" [($loopCNT * $beatsPerMeasure) + 2]       1    "KickDrum0005"          1    1
                i "TR808" ^+0     .5     "Closed HiHat0001"   1    1
                i "TR808" +     .5     "Closed HiHat0003"    1    1



                i "TR808" [($loopCNT * $beatsPerMeasure) + 2.25]     1    "SnareDrum0001"       1    1 0
            ;Beat 4
            i "TR808" [($loopCNT * $beatsPerMeasure) + 3]       1    "KickDrum0005"          1    1 0
                i "TR808" ^+0     1    "SnareDrum0001"       1    1 0
                i "TR808" ^+0     .5     "Closed HiHat0001"   1    1
                i "TR808" +     .5     "Closed HiHat0001"    1    1

            i "TR808" [($loopCNT * $beatsPerMeasure) + 3]       1    "Clav"          1    1 [($loopCNT + 1) % 4]

        }
        s

        n beat1


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
