alwayson "VocalEffectChainDelayInput"
alwayson "VocalEffectChainDelayMixerChannel"

giVocalEffectChainDelayBufferLength init 5
gaVocalEffectChainDelayTime init 1
gkVocalEffectChainDelayFeedbackAmount init 0.8
gkVocalEffectChainDelayLevel init 1
gkVocalEffectCHainDelayStereoOffset init 0.0
giVocalEffectChainDelayReleaseTime init 4

gkVocalEffectChainDelayEqBass init 1
gkVocalEffectChainDelayEqMid init 1
gkVocalEffectChainDelayEqHigh init 1
gkVocalEffectChainDelayFader init 1
gkVocalEffectChainDelayPan init 50

gkVocalEffectChainDelayWetAmount init 1
gkVocalEffectChainDelayDryAmount init 1

bypassRoute "VocalEffectChainDelay", "VocalEffectChainReverbInput", "VocalEffectChainReverbInput"

instr VocalEffectChainDelayInput
  aVocalEffectChainDelayInL inleta "InL"
  aVocalEffectChainDelayInR inleta "InR"

  aVocalEffectChainDelayOutWetL, aVocalEffectChainDelayOutWetR, aVocalEffectChainDelayOutDryL, aVocalEffectChainDelayOutDryR bypassSwitch aVocalEffectChainDelayInL, aVocalEffectChainDelayInR, gkVocalEffectChainDelayDryAmount, gkVocalEffectChainDelayWetAmount, "VocalEffectChainDelay"

  outleta "OutWetL", aVocalEffectChainDelayOutWetL
  outleta "OutWetR", aVocalEffectChainDelayOutWetR

  outleta "OutDryL", aVocalEffectChainDelayOutDryL
  outleta "OutDryR", aVocalEffectChainDelayOutDryR
endin

instr VocalEffectChainDelayTimeKnob
  gaVocalEffectChainDelayTime linseg p4, p3, p5
endin

instr VocalEffectChainDelayFeedbackAmountKnob
  gkVocalEffectChainDelayFeedbackAmount linseg p4, p3, p5
endin

instr VocalEffectChainDelayLevelKnob
  gkVocalEffectChainDelayLevel linseg p4, p3, p5
endin

instr VocalEffectChainDelayStereoOffsetKnob
  gkVocalEffectCHainDelayStereoOffset linseg p4, p3, p5
endin


instr VocalEffectChainDelay
  aVocalEffectChainDelayInL inleta "InL"
  aVocalEffectChainDelayInR inleta "InR"

  aVocalEffectChainDelayTimeL = gaVocalEffectChainDelayTime + gkVocalEffectCHainDelayStereoOffset
  aVocalEffectChainDelayTimeR = gaVocalEffectChainDelayTime - gkVocalEffectCHainDelayStereoOffset

  aVocalEffectChainDelayAudioL delayBuffer aVocalEffectChainDelayInL, gkVocalEffectChainDelayFeedbackAmount, giVocalEffectChainDelayBufferLength, aVocalEffectChainDelayTimeL, gkVocalEffectChainDelayLevel
  aVocalEffectChainDelayAudioR delayBuffer aVocalEffectChainDelayInR, gkVocalEffectChainDelayFeedbackAmount, giVocalEffectChainDelayBufferLength, aVocalEffectChainDelayTimeR, gkVocalEffectChainDelayLevel

  aVocalEffectChainDelayOutL = aVocalEffectChainDelayAudioL * madsr(.01, .01, 1, giVocalEffectChainDelayReleaseTime)
  aVocalEffectChainDelayOutR = aVocalEffectChainDelayAudioR * madsr(.01, .01, 1, giVocalEffectChainDelayReleaseTime)

  outleta "OutL", aVocalEffectChainDelayOutL
  outleta "OutR", aVocalEffectChainDelayOutR
endin

instr VocalEffectChainDelayBassKnob
  gkVocalEffectChainDelayEqBass linseg p4, p3, p5
endin

instr VocalEffectChainDelayMidKnob
  gkVocalEffectChainDelayEqMid linseg p4, p3, p5
endin

instr VocalEffectChainDelayHighKnob
  gkVocalEffectChainDelayEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainDelayFader
  gkVocalEffectChainDelayFader linseg p4, p3, p5
endin

instr VocalEffectChainDelayPan
  gkVocalEffectChainDelayPan linseg p4, p3, p5
endin

instr VocalEffectChainDelayMixerChannel
  aVocalEffectChainDelayL inleta "InL"
  aVocalEffectChainDelayR inleta "InR"

  aVocalEffectChainDelayL, aVocalEffectChainDelayR mixerChannel aVocalEffectChainDelayL, aVocalEffectChainDelayR, gkVocalEffectChainDelayFader, gkVocalEffectChainDelayPan, gkVocalEffectChainDelayEqBass, gkVocalEffectChainDelayEqMid, gkVocalEffectChainDelayEqHigh

  outleta "OutL", aVocalEffectChainDelayL
  outleta "OutR", aVocalEffectChainDelayR
endin
