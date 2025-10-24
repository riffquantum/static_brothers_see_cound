; Tenner Bass

; nilliriya 1
; nilliriya 2

; ExpectedBreak1
; ExpectedBreak2
; ExpectedBreakFill1
; time - 5% att - 16% hold - 100% grain spacing 47% wave spacing 93%
#define EXPECTED_1_SETTINGS #
#

$FRUITY_GRANULIZER(ItsExpected1'Mixer'localSamples/itsExpectedBreak.wav'$EXPECTED_1_SETTINGS'0'0)

#define EB1 #
  kGrainFrequencyAdjustment = 1.2
  kGrainSizeAdjustment = poscil:a(.5, 1)
#
$SYNCLOOP_SAMPLER(ExpectedBreak1'Mixer'localSamples/itsExpectedBreak.wav'$EB1'0'0)
; #define EXPECTED_3_SETTINGS #
;   kTimeStretch = 10
;   kGrainSizeAdjustment = 1
;   kGrainFrequencyAdjustment = 1
;   kPitchAdjustment = 1
;   kGrainOverlapPercentageAdjustment = 1
; #

; $SYNCLOOP_SAMPLER(ItsExpected1'Mixer'localSamples/itsExpectedBreak.wav'$EXPECTED_3_SETTINGS'16'0)

; #define EXPECTED_2_SETTINGS #
;   kTimeStretch = 10
;   kGrainSizeAdjustment = 10
;   kGrainFrequencyAdjustment = 10
;   kPitchAdjustment = .8
;   kGrainOverlapPercentageAdjustment = 10
; #

; $SYNCLOOP_SAMPLER(ItsExpected2'Mixer'localSamples/itsExpectedBreak.wav'$EXPECTED_1_SETTINGS'16'0)


; ; ExpectedBreakFill2

; ; CathedralsKick

; $SAMPLE(ExpectedBreak1'Mixer'localSamples/itsExpectedBreak.wav'0)
; $SYNCLOOP_SAMPLER
