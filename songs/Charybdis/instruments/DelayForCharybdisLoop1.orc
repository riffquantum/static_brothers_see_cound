alwayson "DelayForCharybdisLoop1Input"
alwayson "DelayForCharybdisLoop1MixerChannel"

giDelayForCharybdisLoop1BufferLength init 5
gaDelayForCharybdisLoop1Time init beatsToSeconds(1)
gkDelayForCharybdisLoop1FeedbackAmount init 0.8
gkDelayForCharybdisLoop1Level init 1
gkDefaultEffectCHainDelayStereoOffset init 0.0
giDelayForCharybdisLoop1ReleaseTime init 4

gkDelayForCharybdisLoop1EqBass init 1
gkDelayForCharybdisLoop1EqMid init 1
gkDelayForCharybdisLoop1EqHigh init 1
gkDelayForCharybdisLoop1Fader init 1
gkDelayForCharybdisLoop1Pan init 50

gkDelayForCharybdisLoop1WetAmount init 1
gkDelayForCharybdisLoop1DryAmount init 1

bypassRoute "DelayForCharybdisLoop1", "Mixer", "Mixer"

instr DelayForCharybdisLoop1Input
  aDelayForCharybdisLoop1InL inleta "InL"
  aDelayForCharybdisLoop1InR inleta "InR"

  aDelayForCharybdisLoop1OutWetL, aDelayForCharybdisLoop1OutWetR, aDelayForCharybdisLoop1OutDryL, aDelayForCharybdisLoop1OutDryR bypassSwitch aDelayForCharybdisLoop1InL, aDelayForCharybdisLoop1InR, gkDelayForCharybdisLoop1DryAmount, gkDelayForCharybdisLoop1WetAmount, "DelayForCharybdisLoop1"

  outleta "OutWetL", aDelayForCharybdisLoop1OutWetL
  outleta "OutWetR", aDelayForCharybdisLoop1OutWetR

  outleta "OutDryL", aDelayForCharybdisLoop1OutDryL
  outleta "OutDryR", aDelayForCharybdisLoop1OutDryR
endin

instr DelayForCharybdisLoop1TimeKnob
  gaDelayForCharybdisLoop1Time linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1FeedbackAmountKnob
  gkDelayForCharybdisLoop1FeedbackAmount linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1LevelKnob
  gkDelayForCharybdisLoop1Level linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1StereoOffsetKnob
  gkDefaultEffectCHainDelayStereoOffset linseg p4, p3, p5
endin


instr DelayForCharybdisLoop1
  aDelayForCharybdisLoop1InL inleta "InL"
  aDelayForCharybdisLoop1InR inleta "InR"

  aDelayForCharybdisLoop1TimeL = gaDelayForCharybdisLoop1Time + gkDefaultEffectCHainDelayStereoOffset
  aDelayForCharybdisLoop1TimeR = gaDelayForCharybdisLoop1Time - gkDefaultEffectCHainDelayStereoOffset

  aDelayForCharybdisLoop1AudioL delayBuffer aDelayForCharybdisLoop1InL, gkDelayForCharybdisLoop1FeedbackAmount, giDelayForCharybdisLoop1BufferLength, aDelayForCharybdisLoop1TimeL, gkDelayForCharybdisLoop1Level
  aDelayForCharybdisLoop1AudioR delayBuffer aDelayForCharybdisLoop1InR, gkDelayForCharybdisLoop1FeedbackAmount, giDelayForCharybdisLoop1BufferLength, aDelayForCharybdisLoop1TimeR, gkDelayForCharybdisLoop1Level

  aDelayForCharybdisLoop1OutL = aDelayForCharybdisLoop1AudioL * madsr(.01, .01, 1, giDelayForCharybdisLoop1ReleaseTime)
  aDelayForCharybdisLoop1OutR = aDelayForCharybdisLoop1AudioR * madsr(.01, .01, 1, giDelayForCharybdisLoop1ReleaseTime)

  outleta "OutL", aDelayForCharybdisLoop1OutR
  outleta "OutR", aDelayForCharybdisLoop1OutL
endin

instr DelayForCharybdisLoop1BassKnob
  gkDelayForCharybdisLoop1EqBass linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1MidKnob
  gkDelayForCharybdisLoop1EqMid linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1HighKnob
  gkDelayForCharybdisLoop1EqHigh linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1Fader
  gkDelayForCharybdisLoop1Fader linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1Pan
  gkDelayForCharybdisLoop1Pan linseg p4, p3, p5
endin

instr DelayForCharybdisLoop1MixerChannel
  aDelayForCharybdisLoop1L inleta "InL"
  aDelayForCharybdisLoop1R inleta "InR"

  aDelayForCharybdisLoop1L, aDelayForCharybdisLoop1R mixerChannel aDelayForCharybdisLoop1L, aDelayForCharybdisLoop1R, gkDelayForCharybdisLoop1Fader, gkDelayForCharybdisLoop1Pan, gkDelayForCharybdisLoop1EqBass, gkDelayForCharybdisLoop1EqMid, gkDelayForCharybdisLoop1EqHigh

  outleta "OutL", aDelayForCharybdisLoop1L
  outleta "OutR", aDelayForCharybdisLoop1R
endin
