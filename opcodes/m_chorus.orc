/*
m_chorus - A mono to stereo chorus inspired by the Dimension C Chorus

DESCRIPTION
This is a simple chorus inspired by the Dimension C chorus, which is known for
its lack of abrasive pitch alteration.

SYNTAX
aLeft, aRight m_chorus aInput, kAmount, kDryWet

INITIALIZATION

PERFORMANCE
aLeft, aRight - The stereo audio outputs
aInput - The mono audio input
kAmount - The intensity of the effect, both rate and depth, between 0 and 1
kDryWet - The dry wet control, between 0 and 1, where 0 is dry and 1 maximum
	wet, which still retains some of the original input

CREDITS
Author: Jeanette C.
*/

opcode m_chorus, aa, akk
	aSource, kAmount, kFx xin

	; Set up the dry and wet signal levels
	kWet = linlin(kFx, 0, .75)
	kDry = linlin(kFx, 1, .25)

	; The triangular table for the LFO shape
	iTri = ftgenonce(0, 0, 32768, 7, 0, 16384, 1, 16384, 0)

	; Calculate depth and rate of the LFOs from amount
	kDepth = linlin(kAmount, .001, .012)
	kRate = linlin(kAmount, 2.1, .3)

	; Create the LFOs (at a-rate, because flanger varies delay at a-rate)
	aLFO1 = oscil(kDepth, kRate, iTri)
	aLFO2 = kDepth - aLFO1

	; Create the two chorused versions
	aChorus1 = flanger(aSource, aLFO1+.01, 0, .6)
	aChorus2 = flanger(aSource, aLFO2+.01, 0, .6)

	; Create the left and right outputs and output them
	aLeft = (aSource)*kDry + butterhp((aChorus1 - aChorus2)*kWet, 300)
	aRight = (aSource)*kDry + butterhp((aChorus2 - aChorus1)*kWet, 300)
	xout(aLeft, aRight)
endop
