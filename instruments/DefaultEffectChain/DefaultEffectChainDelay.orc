alwayson "DefaultEffectChainDelayInput"
alwayson "DefaultEffectChainDelayMixerChannel"

giDefaultEffectChainDelayBufferLength init 5
gaDefaultEffectChainDelayTime init 0.25
gkDefaultEffectChainDelayFeedbackAmmount init 0.8
gkDefaultEffectChainDelayLevel init 1
gkDefaultEffectCHainDelayStereoOffset init 0.0

gkDefaultEffectChainDelayEqBass init 1
gkDefaultEffectChainDelayEqMid init 1
gkDefaultEffectChainDelayEqHigh init 1
gkDefaultEffectChainDelayFader init 1
gkDefaultEffectChainDelayPan init 50

gkDefaultEffectChainDelayWetAmmount init 1
gkDefaultEffectChainDelayDryAmmount init 1

bypassRoute "DefaultEffectChainDelay", "DefaultEffectChainReverbInput", "DefaultEffectChainReverbInput"

instr DefaultEffectChainDelayInput
  aDefaultEffectChainDelayInL inleta "InL"
  aDefaultEffectChainDelayInR inleta "InR"

  aDefaultEffectChainDelayOutWetL, aDefaultEffectChainDelayOutWetR, aDefaultEffectChainDelayOutDryL, aDefaultEffectChainDelayOutDryR bypassSwitch aDefaultEffectChainDelayInL, aDefaultEffectChainDelayInR, gkDefaultEffectChainDelayDryAmmount, gkDefaultEffectChainDelayWetAmmount, "DefaultEffectChainDelay"

  outleta "OutWetL", aDefaultEffectChainDelayOutWetL
  outleta "OutWetR", aDefaultEffectChainDelayOutWetR

  outleta "OutDryL", aDefaultEffectChainDelayOutDryL
  outleta "OutDryR", aDefaultEffectChainDelayOutDryR
endin

instr DefaultEffectChainDelayTimeKnob
  gaDefaultEffectChainDelayTime linseg p4, p3, p5
endin

instr DefaultEffectChainDelayFeedbackAmmountKnob
  gkDefaultEffectChainDelayFeedbackAmmount linseg p4, p3, p5
endin

instr DefaultEffectChainDelayLevelKnob
  gkDefaultEffectChainDelayLevel linseg p4, p3, p5
endin

instr DefaultEffectChainDelayStereoOffsetKnob
  gkDefaultEffectCHainDelayStereoOffset linseg p4, p3, p5
endin


instr DefaultEffectChainDelay
  aDefaultEffectChainDelayInL inleta "InL"
  aDefaultEffectChainDelayInR inleta "InR"

  aDefaultEffectChainDelayTimeL = gaDefaultEffectChainDelayTime + gkDefaultEffectCHainDelayStereoOffset
  aDefaultEffectChainDelayTimeR = gaDefaultEffectChainDelayTime - gkDefaultEffectCHainDelayStereoOffset

  aDefaultEffectChainDelayAudioL delayBuffer aDefaultEffectChainDelayInL, gkDefaultEffectChainDelayFeedbackAmmount, giDefaultEffectChainDelayBufferLength, aDefaultEffectChainDelayTimeL, gkDefaultEffectChainDelayLevel
  aDefaultEffectChainDelayAudioR delayBuffer aDefaultEffectChainDelayInR, gkDefaultEffectChainDelayFeedbackAmmount, giDefaultEffectChainDelayBufferLength, aDefaultEffectChainDelayTimeR, gkDefaultEffectChainDelayLevel

  aDefaultEffectChainDelayOutL = aDefaultEffectChainDelayInL + aDefaultEffectChainDelayAudioL
  aDefaultEffectChainDelayOutR = aDefaultEffectChainDelayInR + aDefaultEffectChainDelayAudioR

  outleta "OutL", aDefaultEffectChainDelayOutL
  outleta "OutR", aDefaultEffectChainDelayOutR
endin

instr DefaultEffectChainDelayBassKnob
  gkDefaultEffectChainDelayEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainDelayMidKnob
  gkDefaultEffectChainDelayEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainDelayHighKnob
  gkDefaultEffectChainDelayEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainDelayFader
  gkDefaultEffectChainDelayFader linseg p4, p3, p5
endin

instr DefaultEffectChainDelayPan
  gkDefaultEffectChainDelayPan linseg p4, p3, p5
endin

instr DefaultEffectChainDelayMixerChannel
  aDefaultEffectChainDelayL inleta "InL"
  aDefaultEffectChainDelayR inleta "InR"

  aDefaultEffectChainDelayL, aDefaultEffectChainDelayR mixerChannel aDefaultEffectChainDelayL, aDefaultEffectChainDelayR, gkDefaultEffectChainDelayFader, gkDefaultEffectChainDelayPan, gkDefaultEffectChainDelayEqBass, gkDefaultEffectChainDelayEqMid, gkDefaultEffectChainDelayEqHigh

  outleta "OutL", aDefaultEffectChainDelayL
  outleta "OutR", aDefaultEffectChainDelayR
endin
