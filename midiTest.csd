<CsoundSynthesizer>
	<CsOptions>
		-odac -Ma  -m0
		;-+rtmidi=virtual
	</CsOptions>

	<CsInstruments>
		sr = 48000          ; audio sampling rate is 44.1 kHz
        kr = 4800           ; control rate is 4410 Hz
        ksmps = 10          ; number of samples in a control period (sr/kr)
        nchnls = 2          ; number of channels of audio output
        0dbfs = 1           ;
        
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