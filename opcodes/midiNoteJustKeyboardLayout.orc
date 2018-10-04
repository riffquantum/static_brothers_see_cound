;midiNoteQuarterToneKeyboardLayout
; Accept a Midi note and turn it into frequency value 
; for an equal temperment quarter tone keyboard.
; Accepts a midinote number and an optional starting octave
; number which defaults to 6.

opcode midiNoteJustKeyboardLayout, i, ij
	iMidiNote, iStartingOctave xin

	if iStartingOctave == -1 then
	    iStartingOctave = 6
	endif

    iDecimal = (iMidiNote * 0.005) ; turns the midi note into a 
    iOctave = floor(iDecimal / .12)
    iRemainder = iDecimal % .12
    iPitchNumber = iStartingOctave + iOctave + iRemainder
    
    iFrequency = cpspch(iPitchNumber)
    xout iFrequency
endop
