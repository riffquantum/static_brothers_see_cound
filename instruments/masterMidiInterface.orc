; masterMidiInterface

/****************************
 MIDI Status Codes:
 128 (note off)
 144 (note on)
 160 (polyphonic aftertouch)
 176 (control change)
 192 (program change)
 208 (channel aftertouch)
 224 (pitch bend
 0 if no MIDI message are pending in the MIDI IN buffer
 ****************************/

massign 1, "MasterMidiInterface"
alwayson "MasterMidiInterface"

instr MasterMidiInterface
	kstatus, kchan, kdata1, kdata2  midiin 
	ktrigger  changed  kstatus, kchan, kdata1, kdata2

	if ktrigger ==1 && (kstatus == 0 || kstatus == 128) then
		kgoto end
	endif

	if ktrigger==1 then
	; -- print midi data to the terminal with formatting --
	 printks "status:%d%tchannel:%d%tdata1:%d%tdata2:%d%n"\
	                                    ,0,kstatus,kchan,kdata1,kdata2
	endif
	
	if  kdata2 != 0 && kstatus == 144 then
		kvelocity = (kdata2 / 127) ;TO DO: Get this into p6 of the scoreline statementes below

		/****************************
		 Drum Kit Notes
		 ****************************/
		; Ride
		if kdata1 == 49  then
			scoreline {{i "LinnDrum" 0 1 "Ride" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Ride Rim
		if kdata1 == 48  then
			scoreline {{i "LinnDrum" 0 1 "Ride" 1.3 .5 0}}, ktrigger
			kgoto end
		endif

		; Hat Open
		if kdata1 == 55  then
			scoreline {{i "LinnDrum" 0 1 "kick" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Hat Closed
		if kdata1 == 47  then
			scoreline {{i "LinnDrum" 0 1 "HatClosed5" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Hat Pedal
		if kdata1 == 56  then
			scoreline {{i "LinnDrum" 0 1 "HatClosed6" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Yellow Pad (Cymbal Left)
		if kdata1 == 51  then
			scoreline {{i "LinnDrum" 0 1 "Crash" 1 .5 0}}, ktrigger
			kgoto end
		endif

		;Orange Pad (Cymbal Right)
		if kdata1 == 53  then
			scoreline {{i "LinnDrum" 0 1 "Tambourine" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Red Pad
		if kdata1 == 54  then
			scoreline {{i "LinnDrum" 0 1 "Tom1" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Blue Pad
		if kdata1 ==  45  then
			scoreline {{i "LinnDrum" 0 1 "Tom2" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Green pad
		if kdata1 == 43  then
			scoreline {{i "LinnDrum" 0 1 "Tom3" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Kick
		if kdata1 == 82 then
			scoreline {{i "LinnDrum" 0 1 "kick" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Tom 1
		if kdata1 == 56 then
			scoreline {{i "LinnDrum" 0 1 "Tom4" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Snare
		if kdata1 == 36 then
			scoreline {{i "LinnDrum" 0 1 "Snare5" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Tom 2
		if kdata1 == 55  then
			scoreline {{i "LinnDrum" 0 1 "Tom5" 1 .5 0}}, ktrigger
			kgoto end
		endif

		; Tom 3
		if kdata1 == 47 then
			scoreline {{i "LinnDrum" 0 1 "Tom6" 1 .5 0}}, ktrigger
			kgoto end
		endif



		if kdata1 == 72 then
			event "i", "AmenBreak2", 0, 4, 1
			kgoto end
		endif

	elseif kstatus == 176 then
		if kdata1 == 15 then
			gkReverb1Delay = (kdata2 / 127 )
		endif
	endif


	end:
endin