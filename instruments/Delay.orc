instrumentRoute "Delay", "Mixer"
alwayson "Delay"
alwayson "DelayMixerChannel"

giDelayBufferLength init 5
gaDelayTime init 0.25
gkDelayFeedbackAmmount init 0.8
gkDelayLevel init 1
gkDelayStereoOffset init 0.0

gkDelayEqBass init 1
gkDelayEqMid init 1
gkDelayEqHigh init 1
gkDelayFader init 1
gkDelayPan init 50

instr DelayTimeKnob
  gaDelayTime linseg p4, p3, p5
endin

instr DelayFeedbackAmmountKnob
  gkDelayFeedbackAmmount linseg p4, p3, p5
endin

instr DelayLevelKnob
  gkDelayLevel linseg p4, p3, p5
endin

instr DelayStereoOffsetKnob
  gkDelayStereoOffset linseg p4, p3, p5
endin


instr Delay
  aDelayInL inleta "InL"
  aDelayInR inleta "InR"

  aDelayTimeL = gaDelayTime + gkDelayStereoOffset
  aDelayTimeR = gaDelayTime - gkDelayStereoOffset

  aDelayAudioL delayBuffer aDelayInL, gkDelayFeedbackAmmount, giDelayBufferLength, aDelayTimeL, gkDelayLevel
  aDelayAudioR delayBuffer aDelayInR, gkDelayFeedbackAmmount, giDelayBufferLength, aDelayTimeR, gkDelayLevel

  aDelayOutL = aDelayInL + aDelayAudioL
  aDelayOutR = aDelayInR + aDelayAudioR

  outleta "OutL", aDelayOutL
  outleta "OutR", aDelayOutR
endin

instr DelayBassKnob
  gkDelayEqBass linseg p4, p3, p5
endin

instr DelayMidKnob
  gkDelayEqMid linseg p4, p3, p5
endin

instr DelayHighKnob
  gkDelayEqHigh linseg p4, p3, p5
endin

instr DelayFader
  gkDelayFader linseg p4, p3, p5
endin

instr DelayPan
  gkDelayPan linseg p4, p3, p5
endin

instr DelayMixerChannel
  aDelayL inleta "InL"
  aDelayR inleta "InR"

  aDelayL, aDelayR mixerChannel aDelayL, aDelayR, gkDelayFader, gkDelayPan, gkDelayEqBass, gkDelayEqMid, gkDelayEqHigh

  outleta "OutL", aDelayL
  outleta "OutR", aDelayR
endin
