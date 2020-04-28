alwayson "Delay"
alwayson "DelayMixerChannel"

giDelayBufferLength init 5
gaDelayTime init 0.25
gkDelayFeedbackAmmount init 0.8
gkDelayLevel init 1
gkStereoOffset init 0.0

gkDelayEqBass init 1
gkDelayEqMid init 1
gkDelayEqHigh init 1
gkDelayFader init 1
gkDelayPan init 50
gSDelayName = "Delay"
gSDelayRoute = "Mixer"
instrumentRoute gSDelayName, gSDelayRoute

instr DelayTimeKnob
  gaDelayTime linseg p4, p3, p5
endin

instr DelayFeedbackAmmountKnob
  gkDelayFeedbackAmmount linseg p4, p3, p5
endin

instr DelayLevelKnob
  gkDelayLevel linseg p4, p3, p5
endin

instr StereoOffsetKnob
  gkStereoOffset linseg p4, p3, p5
endin


instr Delay
  aDelayInL inleta "DelayInL"
  aDelayInR inleta "DelayInR"

  aDelayTimeL = gaDelayTime + gkStereoOffset
  aDelayTimeR = gaDelayTime - gkStereoOffset

  aDelayAudioL delayBuffer aDelayInL, gkDelayFeedbackAmmount, giDelayBufferLength, aDelayTimeL, gkDelayLevel
  aDelayAudioR delayBuffer aDelayInR, gkDelayFeedbackAmmount, giDelayBufferLength, aDelayTimeR, gkDelayLevel

  aDelayOutL = aDelayInL + aDelayAudioL
  aDelayOutR = aDelayInR + aDelayAudioR

  outleta "DelayOutL", aDelayOutL
  outleta "DelayOutR", aDelayOutR
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
  aDelayL inleta "DelayInL"
  aDelayR inleta "DelayInR"

  kDelayFader = gkDelayFader
  kDelayPan = gkDelayPan
  kDelayEqBass = gkDelayEqBass
  kDelayEqMid = gkDelayEqMid
  kDelayEqHigh = gkDelayEqHigh

  aDelayL, aDelayR threeBandEqStereo aDelayL, aDelayR, kDelayEqBass, kDelayEqMid, kDelayEqHigh

  if kDelayPan > 100 then
      kDelayPan = 100
  elseif kDelayPan < 0 then
      kDelayPan = 0
  endif

  aDelayL = (aDelayL * ((100 - kDelayPan) * 2 / 100)) * kDelayFader
  aDelayR = (aDelayR * (kDelayPan * 2 / 100)) * kDelayFader

  outleta "DelayOutL", aDelayL
  outleta "DelayOutR", aDelayR
endin
