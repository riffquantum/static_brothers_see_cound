<CSoundSynthesizer>
	<CsOptions>
		-Ma -m0
	</CsOptions>

	<CsInstruments>
		sr = 48000          ; audio sampling rate is 44.1 kHz
        kr = 4800           ; control rate is 4410 Hz
        ksmps = 10          ; number of samples in a control period (sr/kr)
        nchnls = 2          ; number of channels of audio output
        0dbfs = 1           ;

        massign	0,0

        instr 1
			kstatus, kchan, kdata1, kdata2  midiin            ;read in midi
			ktrigger  changed  kstatus, kchan, kdata1, kdata2 ;trigger if midi data changes
			 if ktrigger=1 && kstatus!=0 then          ;if status byte is non-zero...
			; -- print midi data to the terminal with formatting --
			 printks "status:%d%tchannel:%d%tdata1:%d%tdata2:%d%n"\
			                                    ,0,kstatus,kchan,kdata1,kdata2
			endif
		endin


	</CsInstruments>

	<CsScore>
		i 1 0 3600 ; instr 1 plays for 1 hour
	</CsScore>
</CSoundSynthesizer>