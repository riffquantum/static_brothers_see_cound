alwayson "DelayForAwfulCrashInput"
alwayson "DelayForAwfulCrash"
alwayson "DelayForAwfulCrashMixerChannel"

giDelayForAwfulCrashBufferLength init 5
gaDelayForAwfulCrashTime init 0.00095
gkDelayForAwfulCrashFeedbackAmount init 0.95
gkDelayForAwfulCrashLevel init 1
gkDelayForAwfulCrashStereoOffset init 0.0
giDelayForAwfulCrashReleaseTime init .1

gkDelayForAwfulCrashEqBass init 1
gkDelayForAwfulCrashEqMid init 1
gkDelayForAwfulCrashEqHigh init 1
gkDelayForAwfulCrashFader init 1
gkDelayForAwfulCrashPan init 50

gkDelayForAwfulCrashWetAmount init .25
gkDelayForAwfulCrashDryAmount init 1

bypassRoute "DelayForAwfulCrash", "GlobalReverbInput", "GlobalReverbInput"

instr DelayForAwfulCrashInput
  aDelayForAwfulCrashInL inleta "InL"
  aDelayForAwfulCrashInR inleta "InR"

  aDelayForAwfulCrashOutWetL, aDelayForAwfulCrashOutWetR, aDelayForAwfulCrashOutDryL, aDelayForAwfulCrashOutDryR bypassSwitch aDelayForAwfulCrashInL, aDelayForAwfulCrashInR, gkDelayForAwfulCrashDryAmount, gkDelayForAwfulCrashWetAmount, "DelayForAwfulCrash"

  outleta "OutWetL", aDelayForAwfulCrashOutWetL
  outleta "OutWetR", aDelayForAwfulCrashOutWetR

  outleta "OutDryL", aDelayForAwfulCrashOutDryL
  outleta "OutDryR", aDelayForAwfulCrashOutDryR
endin

instr DelayForAwfulCrashTimeKnob
  gaDelayForAwfulCrashTime linseg p4, p3, p5
endin

instr DelayForAwfulCrashFeedbackAmountKnob
  gkDelayForAwfulCrashFeedbackAmount linseg p4, p3, p5
endin

instr DelayForAwfulCrashLevelKnob
  gkDelayForAwfulCrashLevel linseg p4, p3, p5
endin

instr DelayForAwfulCrashStereoOffsetKnob
  gkDelayForAwfulCrashStereoOffset linseg p4, p3, p5
endin


instr DelayForAwfulCrash
  aDelayForAwfulCrashInL inleta "InL"
  aDelayForAwfulCrashInR inleta "InR"

  aDelayForAwfulCrashTimeL = gaDelayForAwfulCrashTime + gkDelayForAwfulCrashStereoOffset
  aDelayForAwfulCrashTimeR = gaDelayForAwfulCrashTime - gkDelayForAwfulCrashStereoOffset

  aDelayForAwfulCrashAudioL delayBuffer aDelayForAwfulCrashInL, gkDelayForAwfulCrashFeedbackAmount, giDelayForAwfulCrashBufferLength, aDelayForAwfulCrashTimeL, gkDelayForAwfulCrashLevel
  aDelayForAwfulCrashAudioR delayBuffer aDelayForAwfulCrashInR, gkDelayForAwfulCrashFeedbackAmount, giDelayForAwfulCrashBufferLength, aDelayForAwfulCrashTimeR, gkDelayForAwfulCrashLevel

  aDelayForAwfulCrashOutL = aDelayForAwfulCrashAudioL * madsr(.01, .01, 1, giDelayForAwfulCrashReleaseTime)
  aDelayForAwfulCrashOutR = aDelayForAwfulCrashAudioR * madsr(.01, .01, 1, giDelayForAwfulCrashReleaseTime)

  outleta "OutL", aDelayForAwfulCrashOutL
  outleta "OutR", aDelayForAwfulCrashOutR
endin

instr DelayForAwfulCrashBassKnob
  gkDelayForAwfulCrashEqBass linseg p4, p3, p5
endin

instr DelayForAwfulCrashMidKnob
  gkDelayForAwfulCrashEqMid linseg p4, p3, p5
endin

instr DelayForAwfulCrashHighKnob
  gkDelayForAwfulCrashEqHigh linseg p4, p3, p5
endin

instr DelayForAwfulCrashFader
  gkDelayForAwfulCrashFader linseg p4, p3, p5
endin

instr DelayForAwfulCrashPan
  gkDelayForAwfulCrashPan linseg p4, p3, p5
endin

instr DelayForAwfulCrashMixerChannel
  aDelayForAwfulCrashL inleta "InL"
  aDelayForAwfulCrashR inleta "InR"

  aDelayForAwfulCrashL, aDelayForAwfulCrashR mixerChannel aDelayForAwfulCrashL, aDelayForAwfulCrashR, gkDelayForAwfulCrashFader, gkDelayForAwfulCrashPan, gkDelayForAwfulCrashEqBass, gkDelayForAwfulCrashEqMid, gkDelayForAwfulCrashEqHigh

  outleta "OutL", aDelayForAwfulCrashL
  outleta "OutR", aDelayForAwfulCrashR
endin
