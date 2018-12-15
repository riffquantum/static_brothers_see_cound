<CsoundSynthesizer>
    <CsOptions>
        -odac -Ma  -m0
        ;-+rtmidi=virtual
    </CsOptions>

    <CsInstruments>
        #include "config/defaultConfig.orc"
        #include "config/defaultMixerRoutes.orc"
        
        giBPM = 120
        
        #include "opcodes/opcode-manifest.orc"
        #include "instruments/orchestra-manifest.orc"

        massign 2, "ChorusedSynthQuarterTone"
        massign 3, "ChorusedSynthMidiIn"

    </CsInstruments>

    <CsScore>
        i "Reverb1DelayKnob" 0 0.1 1 1
        i "Reverb1CutoffKnob" 0 3600 .100 300
        
    </CsScore>
</CsoundSynthesizer>