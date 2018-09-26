<CsoundSynthesizer>

    <CsOptions>
        -odac
    </CsOptions>

    <CsInstruments>
        sr = 48000          ; audio sampling rate is 44.1 kHz
        kr = 4800           ; control rate is 4410 Hz
        ksmps = 10          ; number of samples in a control period (sr/kr)
        nchnls = 2          ; number of channels of audio output
        0dbfs = 1           ;

        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

    </CsInstruments>

    <CsScore>
        #define beatsPerMeasure # 8 #
        m beat1

         t 0 148

        { 5 loopCNT

            ;Beat 1
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       1      "Kick"          1    .5 0

            ;Beat 2
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "Kick"          1    .5 0


            ;Beat 3
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 2]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 4
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "Kick"          1    .5

            ;Beat 5
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 4]       1      "Kick"          1    .5 0

            ;Beat 6
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 5]       1    "Kick"          1    .5 0


            ;Beat 7
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 6]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 8
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 7]       1    "Kick"          1    .5


            i "AmenBreak" + 8 [($loopCNT+1) * 0.1]

            i "ChorusedSynth"  +  8 0.15    [(8.03 - ($loopCNT/100))] ;B
        }
        s

        m beat1

         t 0 148
        { 3 loopCNT

            ;Beat 1
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       1      "Kick"          1    .5 0

            ;Beat 2
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "Kick"          1    .5 0


            ;Beat 3
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 2]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 4
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "Kick"          1    .5

            ;Beat 5
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 4]       1      "Kick"          1    .5 0

            ;Beat 6
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 5]       1    "Kick"          1    .5 0


            ;Beat 7
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 6]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 8
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 7]       1    "Kick"          1    .5




            i "AmenBreak" + 8 0.5

            i "ChorusedSynth"  +  8 0.15    [(9.03 - ($loopCNT/100))]

        }
        s

        m bridge

        i "AmenBreak" 0 0.25    1
        i "AmenBreak" + 0.25    1
        i "AmenBreak" + 1    1
        i "AmenBreak" 0 1    0.5
        i "AmenBreak" + 1      300
        { 4 loopCNT
            i "AmenBreak" [$loopCNT * 3.5] 3.5    1

            i "AmenBreak" [$loopCNT * 3.5] 1      70
            i "AmenBreak" + 1      200
            i "AmenBreak" + 1      20
        }

            i "AmenBreak" + 2      70
            i "AmenBreak" + 2      75
            i "AmenBreak" + 2      45
            i "AmenBreak" + 0.75    0.75


        s

        m beatTriplets

         t 0 148
        { 4 loopCNT

            ;Beat 1
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       1      "Kick"          1    .5 0

            ;Beat 2
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "Kick"          1    .5 0


            ;Beat 3
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 2]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 4
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "Kick"          1    .5

            ;Beat 5
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 4]       1      "Kick"          1    .5 0

            ;Beat 6
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 5]       1    "Kick"          1    .5 0


            ;Beat 7
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 6]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 8
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 7]       1    "Kick"          1    .5




            i "AmenBreak" + 8 0.75

            i "ChorusedSynth"  +  8 0.15    [(7.03 + ($loopCNT/100 + 0.1))]

        }
        s

        m bridge
            i "AmenBreak" + 0.5  0.55
            i "AmenBreak" + 0.1  0.55
            i "AmenBreak" + 0.1  0.55
            i "AmenBreak" + 0.1  0.55
            i "AmenBreak" + 0.3  0.55
            i "AmenBreak" + 0.1  0.55
            i "AmenBreak" + 0.1  0.55

        s

        m beat2

         t 0 148
        { 2 loopCNT

            ;Beat 1
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 0]       1      "Kick"          1    .5 0

            ;Beat 2
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 1]       1    "Kick"          1    .5 0


            ;Beat 3
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 2]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 4
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 3]       1    "Kick"          1    .5

            ;Beat 5
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 4]       1      "Kick"          1    .5 0

            ;Beat 6
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 5]       1    "Kick"          1    .5 0


            ;Beat 7
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 6]       1    "Kick"          1    .5
                i "LinnDrum" ^+0       1    "Snare9"          1    1 0

            ;Beat 8
            i "LinnDrum" [($loopCNT * $beatsPerMeasure) + 7]       1    "Kick"          1    .5


            i "AmenBreak" + 8 0.5

        }
        s
        m endpiece
            i "AmenBreak" + 3 0.3333
        s


            ; 1  2  3  4  5  6  7  8  9  10  11 12
            ; A  A# B  C  C# D  D# E  F  F#  G  G#

    </CsScore>
</CsoundSynthesizer>
