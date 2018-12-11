<CsoundSynthesizer>
<CsOptions>
    -odac
</CsOptions>


<CsInstruments>
    #include "config/defaultConfig.orc"
    #include "config/defaultMixerRouting.orc"
    
    giBPM = 120

    #include "opcodes/opcode-manifest.orc"
    #include "instruments/orchestra-manifest.orc"

</CsInstruments>


<CsScore>



    { 40 loopCount
    i "TR808"    +       1      "KickDrum0005" 1    .5  1
    i "ChorusedSynth" 0 2 0.05 7
    i "LinnDrum" +       1      "Kick"         1    .5 0

    i "Reverb1DelayKnob" [$loopCount * 4] 1 0 [$loopCount / 20]
    i "ChorusedSynth" [$loopCount * 4] 4 0.25 [3600 - ($loopCount * 10)]
    i "ChorusedSynthPan" [$loopCount * 4] 2 0 100
    i "ChorusedSynthPan" + 2 100 0
    i "LinnDrumPan" [$loopCount * 4] 2 100 0
    i "LinnDrumPan" + 2 0 100
    i "LinnDrumFader" [$loopCount * 4] 4 .25 1
    i "LinnDrum" +       1      "Kick"         1    .5 0
    i "LinnDrum" +       1      "Kick"         1    .5 0
    i "LinnDrum" +       1      "Kick"         1    .5 0

    i "LinnDrum" [$loopCount * 4 + 1]       2      "Snare9"         1    .5 0
    i "LinnDrum" +       2      "Snare9"         1    .5 0

    i "LinnDrum" [$loopCount * 4]       0.5      "HatClosed6"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed5"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed5"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed5"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed5"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed6"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed5"   1    .25 0
    i "LinnDrum" +       0.5      "HatClosed5"   1    .25 0
}

    i "LinnDrum" +       1      "Kick"   1    .5 0
    i "LinnDrumPan" 1 1 0 0

    i "LinnDrum" +       1      "Kick"   1    .5 0
    i "LinnDrumPan" 2 1 100 100

    i "LinnDrum" +       1      "Kick"   1    .5 0
    i "LinnDrumPan" 3 1 10 10

    i "LinnDrum" +       1      "Kick"   1    .5 0

    i "ChorusedSynth" 0       2    1 6.5
    i "ChorusedSynthFader" 0 1 0 1
    i "ChorusedSynthPan" 0 2 100 0
    i "ChorusedSynthPan" 2 1 50 50
    i "ChorusedSynth" +       2    1 6.49

        i "AmenBreak" 0 1 100
        i "Sample" 1 1 10 1
        i "Sample" ^+2 1 8 200
        i "Sample" ^+2 1 8 100
        i "Sample" ^+2 1 8 400
        i "AmenBreak" + 1 450
        i "LinnDrum" 0       1      "Kick"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "LinnDrum" ^+0     1      "Snare9"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "LinnDrum" ^+0     1      "Snare9"          1    .5 0
        i "LinnDrum" +       1      "Kick"          1    .5 0
        i "AmenBreak" 0 4 7
        i "AmenBreak" 4 4 10
        i "AmenBreak" 0 8 2


    i "ChorusedSynth"  0   1   0.5    8.03 ;B
    i "Sample" 0 1 0.3 10
    i "LinnDrum" 0       1      "Kick"          1    .5 0
    i "Signal" 0 1 0.3 7.03
    i "Signal" + 1 0.3 7.04
    i "Signal" + 1 0.3 7.0425
    i "Signal" + 1 0.3 7.0375
        i "Signal" + 1 0.3 7.03
    i "Signal" + 1 0.3 7.04
    i "Signal" + 1 0.3 7.0425
    i "Signal" + 1 0.3 7.0375
        i "Signal" + 1 0.3 7.03
    i "Signal" + 1 0.3 7.04
    i "Signal" + 1 0.3 7.0425
    i "Signal" + 1 0.3 7.0375




    i "Signal" + 1 0.3 7.03
    i "Signal" ^+0 1 0.3 7.0425
    i "Signal" ^+2 1 0.3 7.03
    i "Signal" ^+0 1 0.3 7.0425

</CsScore>
</CsoundSynthesizer>
