; Tenner Bass

; nilliriya 1
; nilliriya 2

; ExpectedBreak1
; ExpectedBreak2
; ExpectedBreakFill1
; time - 5% att - 16% hold - 100% grain spacing 47% wave spacing 93%
; #define EXPECTED_1_SETTINGS #
;   kTimeStretch = .5
;   kGrainSizeAdjustment = 10
;   kGrainFrequencyAdjustment = 1
;   kPitchAdjustment = 1.2
;   kGrainOverlapPercentageAdjustment = .5
; #

; $SYNCLOOP_SAMPLER(ItsExpected1'Mixer'instruments/breakBeatInstruments/itsExpectedBreak.wav'$EXPECTED_1_SETTINGS'16)

; #define EXPECTED_3_SETTINGS #
;   kTimeStretch = 10
;   kGrainSizeAdjustment = 1
;   kGrainFrequencyAdjustment = 1
;   kPitchAdjustment = 1
;   kGrainOverlapPercentageAdjustment = 1
; #

; $SYNCLOOP_SAMPLER(ItsExpected1'Mixer'instruments/breakBeatInstruments/itsExpectedBreak.wav'$EXPECTED_3_SETTINGS'16)

; #define EXPECTED_2_SETTINGS #
;   kTimeStretch = 10
;   kGrainSizeAdjustment = 10
;   kGrainFrequencyAdjustment = 10
;   kPitchAdjustment = .8
;   kGrainOverlapPercentageAdjustment = 10
; #

; $SYNCLOOP_SAMPLER(ItsExpected2'Mixer'instruments/breakBeatInstruments/itsExpectedBreak.wav'$EXPECTED_1_SETTINGS'16)


; ; ExpectedBreakFill2

; ; CathedralsKick

#include "songs/Cathedrals/instruments/ExpectedBreak1.orc"
