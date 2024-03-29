/*
m_vc110 - An 11-band vocoder UDO for Csound
The VC-110 is an 11-band vocoder based on classic analogue hardware
implementation with 11 bandpass filters. It has variable Q or bandwidth and
a formant shift, which works by shifting selected bands of the modulator,
usually a voice, but can be anything.
The highest band in vocoding mode is usually taken from the original modulator
input, but can be switched to use an internal white noise source.
Through the mode switch the VC-110 can also be used as a fixed filterbank
(in carrier mode) or a filterbank with linear frequency shift (in modulator
mode)

For syntax and documentation take a look at m_vc110.udo .

Changes:
1.2: vocoder bands are now summed using sumarray, which should hopefully
	improve efficiency

CREDITS
Author: Jeanette C.
*/

opcode m_vc110, a, aakkkO
	aCarrier, aModulator, kQ, kShift, kIntNoise, kMode xin

	; Set up arrays for the vocoder bands and frequencies
	aCarBands[] init 11 ; the carrier bands
	aModBands[] init 11 ; The modulator bands
	aVocBands[] init 11 ; The vocoded bands
	aOut init 0 ; the output signal
	iFreqs[] = fillarray(100, 225, 330, 470, 700, 1030, 1500, 2280, 3300, 4700, 9000)

	; Create an internal noise source for the highest band
	aNoise = noise(.1, 0)

	; Analyse the carrier
	aCarBands[0] = butterbp(butterbp(aCarrier, iFreqs[0], iFreqs[0]/kQ), iFreqs[0], iFreqs[0]/kQ)
	aCarBands[1] = butterbp(butterbp(aCarrier, iFreqs[1], iFreqs[1]/kQ), iFreqs[1], iFreqs[1]/kQ)
	aCarBands[2] = butterbp(butterbp(aCarrier, iFreqs[2], iFreqs[2]/kQ), iFreqs[2], iFreqs[2]/kQ)
	aCarBands[3] = butterbp(butterbp(aCarrier, iFreqs[3], iFreqs[3]/kQ), iFreqs[3], iFreqs[3]/kQ)
	aCarBands[4] = butterbp(butterbp(aCarrier, iFreqs[4], iFreqs[4]/kQ), iFreqs[4], iFreqs[4]/kQ)
	aCarBands[5] = butterbp(butterbp(aCarrier, iFreqs[5], iFreqs[5]/kQ), iFreqs[5], iFreqs[5]/kQ)
	aCarBands[6] = butterbp(butterbp(aCarrier, iFreqs[6], iFreqs[6]/kQ), iFreqs[6], iFreqs[6]/kQ)
	aCarBands[7] = butterbp(butterbp(aCarrier, iFreqs[7], iFreqs[7]/kQ), iFreqs[7], iFreqs[7]/kQ)
	aCarBands[8] = butterbp(butterbp(aCarrier, iFreqs[8], iFreqs[8]/kQ), iFreqs[8], iFreqs[8]/kQ)
	aCarBands[9] = butterbp(butterbp(aCarrier, iFreqs[9], iFreqs[9]/kQ), iFreqs[9], iFreqs[9]/kQ)

	; Analyse the modulator
	aModBands[0] = butterbp(butterbp(aModulator, iFreqs[0], iFreqs[0]/kQ), iFreqs[0], iFreqs[0]/kQ)
	aModBands[1] = butterbp(butterbp(aModulator, iFreqs[1], iFreqs[1]/kQ), iFreqs[1], iFreqs[1]/kQ)
	aModBands[2] = butterbp(butterbp(aModulator, iFreqs[2], iFreqs[2]/kQ), iFreqs[2], iFreqs[2]/kQ)
	aModBands[3] = butterbp(butterbp(aModulator, (iFreqs[3] + kShift), iFreqs[3]/kQ), (iFreqs[3] + kShift), iFreqs[3]/kQ)
	aModBands[4] = butterbp(butterbp(aModulator, (iFreqs[4] + kShift), iFreqs[4]/kQ), (iFreqs[4] + kShift), iFreqs[4]/kQ)
	aModBands[5] = butterbp(butterbp(aModulator, (iFreqs[5] + kShift), iFreqs[5]/kQ), (iFreqs[5] + kShift), iFreqs[5]/kQ)
	aModBands[6] = butterbp(butterbp(aModulator, (iFreqs[6] + kShift), iFreqs[6]/kQ), (iFreqs[6] + kShift), iFreqs[6]/kQ)
	aModBands[7] = butterbp(butterbp(aModulator, (iFreqs[7] + kShift), iFreqs[7]/kQ), (iFreqs[7] + kShift), iFreqs[7]/kQ)
	aModBands[8] = butterbp(butterbp(aModulator, (iFreqs[8] + kShift), iFreqs[8]/kQ), (iFreqs[8] + kShift), iFreqs[8]/kQ)
	aModBands[9] = butterbp(butterbp(aModulator, iFreqs[9], iFreqs[9]/kQ), iFreqs[9], iFreqs[9]/kQ)
	aModBands[10] = butterbp(butterbp((aModulator * 1.2), iFreqs[10], iFreqs[10]/kQ), iFreqs[10], iFreqs[10]/kQ)

	; Generate the output signal according the the mode
	if (kMode == 0) then ; Vocoder
		aVocBands[0] = balance(aCarBands[0], aModBands[0], 20)
		aVocBands[1] = balance(aCarBands[1], aModBands[1], 20)
		aVocBands[2] = balance(aCarBands[2], aModBands[2], 20)
		aVocBands[3] = balance(aCarBands[3], aModBands[3], 20)
		aVocBands[4] = balance(aCarBands[4], aModBands[4], 20)
		aVocBands[5] = balance(aCarBands[5], aModBands[5], 20)
		aVocBands[6] = balance(aCarBands[6], aModBands[6], 20)
		aVocBands[7] = balance(aCarBands[7], aModBands[7], 20)
		aVocBands[8] = balance(aCarBands[8], aModBands[8], 20)
		aVocBands[9] = balance(aCarBands[9], aModBands[9], 20)

		if (kIntNoise == 0) then
			aVocBands[10] = aModBands[10]
		else
			aCarBands[10] = butterbp(butterbp(aNoise, iFreqs[10], iFreqs[10]/kQ), iFreqs[10], iFreqs[10]/kQ)
			aVocBands[10] = balance(aCarBands[10], aModBands[10], 20)
		endif

		; aOut = sum(aVocBands[0], aVocBands[1], aVocBands[2], aVocBands[3], aVocBands[4], aVocBands[5], aVocBands[6], aVocBands[7], aVocBands[8], aVocBands[9], aVocBands[10])
		aOut = sumarray(aVocBands)
	elseif (kMode == 1) then ; filter the carrier
		aCarBands[10] = butterbp(butterbp(aCarrier, iFreqs[10], iFreqs[10]/kQ), iFreqs[10], iFreqs[10]/kQ)
		; aOut = sum(aCarBands[0], aCarBands[1], aCarBands[2], aCarBands[3], aCarBands[4], aCarBands[5], aCarBands[6], aCarBands[7], aCarBands[8], aCarBands[9], aCarBands[10])
		aOut = sumarray(aCarBands)
	else ; filter the modulator
		; aOut = sum(aModBands[0], aModBands[1], aModBands[2], aModBands[3], aModBands[4], aModBands[5], aModBands[6], aModBands[7], aModBands[8], aModBands[9], aModBands[10])
		aOut = sumarray(aModBands)
	endif

	; Fade in the volume to avoid a very high peak
	kVol = linseg(0, .02, 0, .01, 1, p3-.03, 1)
	aOut *= kVol

	xout(aOut)
endop
