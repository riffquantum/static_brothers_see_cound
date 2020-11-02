alwayson "DelayForDustyBassGrainInput"
alwayson "DelayForDustyBassGrainMixerChannel"

giDelayForDustyBassGrainBufferLength init 5
gaDelayForDustyBassGrainTime init 3
gkDelayForDustyBassGrainFeedbackAmount init 0.8
gkDelayForDustyBassGrainLevel init 1
gkDefaultEffectCHainDelayStereoOffset init 0.0
giDelayForDustyBassGrainReleaseTime init .1

gkDelayForDustyBassGrainEqBass init 1
gkDelayForDustyBassGrainEqMid init 1
gkDelayForDustyBassGrainEqHigh init 1
gkDelayForDustyBassGrainFader init 1
gkDelayForDustyBassGrainPan init 50

gkDelayForDustyBassGrainWetAmount init 1
gkDelayForDustyBassGrainDryAmount init 1

bypassRoute "DelayForDustyBassGrain", "DefaultEffectChainReverbInput", "DefaultEffectChainReverbInput"

instr DelayForDustyBassGrainInput
  aDelayForDustyBassGrainInL inleta "InL"
  aDelayForDustyBassGrainInR inleta "InR"

  aDelayForDustyBassGrainOutWetL, aDelayForDustyBassGrainOutWetR, aDelayForDustyBassGrainOutDryL, aDelayForDustyBassGrainOutDryR bypassSwitch aDelayForDustyBassGrainInL, aDelayForDustyBassGrainInR, gkDelayForDustyBassGrainDryAmount, gkDelayForDustyBassGrainWetAmount, "DelayForDustyBassGrain"

  outleta "OutWetL", aDelayForDustyBassGrainOutWetL
  outleta "OutWetR", aDelayForDustyBassGrainOutWetR

  outleta "OutDryL", aDelayForDustyBassGrainOutDryL
  outleta "OutDryR", aDelayForDustyBassGrainOutDryR
endin

instr DelayForDustyBassGrainTimeKnob
  gaDelayForDustyBassGrainTime linseg p4, p3, p5
endin

instr DelayForDustyBassGrainFeedbackAmountKnob
  gkDelayForDustyBassGrainFeedbackAmount linseg p4, p3, p5
endin

instr DelayForDustyBassGrainLevelKnob
  gkDelayForDustyBassGrainLevel linseg p4, p3, p5
endin

instr DelayForDustyBassGrainStereoOffsetKnob
  gkDefaultEffectCHainDelayStereoOffset linseg p4, p3, p5
endin


instr DelayForDustyBassGrain
  aDelayForDustyBassGrainInL inleta "InL"
  aDelayForDustyBassGrainInR inleta "InR"

  aDelayForDustyBassGrainTimeL = gaDelayForDustyBassGrainTime + gkDefaultEffectCHainDelayStereoOffset
  aDelayForDustyBassGrainTimeR = gaDelayForDustyBassGrainTime - gkDefaultEffectCHainDelayStereoOffset

  aDelayForDustyBassGrainAudioL delayBuffer aDelayForDustyBassGrainInL, gkDelayForDustyBassGrainFeedbackAmount, giDelayForDustyBassGrainBufferLength, aDelayForDustyBassGrainTimeL, gkDelayForDustyBassGrainLevel
  aDelayForDustyBassGrainAudioR delayBuffer aDelayForDustyBassGrainInR, gkDelayForDustyBassGrainFeedbackAmount, giDelayForDustyBassGrainBufferLength, aDelayForDustyBassGrainTimeR, gkDelayForDustyBassGrainLevel

  aDelayForDustyBassGrainOutL = aDelayForDustyBassGrainAudioL * madsr(.01, .01, 1, giDelayForDustyBassGrainReleaseTime)
  aDelayForDustyBassGrainOutR = aDelayForDustyBassGrainAudioR * madsr(.01, .01, 1, giDelayForDustyBassGrainReleaseTime)

  outleta "OutL", aDelayForDustyBassGrainOutR
  outleta "OutR", aDelayForDustyBassGrainOutL
endin

instr DelayForDustyBassGrainBassKnob
  gkDelayForDustyBassGrainEqBass linseg p4, p3, p5
endin

instr DelayForDustyBassGrainMidKnob
  gkDelayForDustyBassGrainEqMid linseg p4, p3, p5
endin

instr DelayForDustyBassGrainHighKnob
  gkDelayForDustyBassGrainEqHigh linseg p4, p3, p5
endin

instr DelayForDustyBassGrainFader
  gkDelayForDustyBassGrainFader linseg p4, p3, p5
endin

instr DelayForDustyBassGrainPan
  gkDelayForDustyBassGrainPan linseg p4, p3, p5
endin

instr DelayForDustyBassGrainMixerChannel
  aDelayForDustyBassGrainL inleta "InL"
  aDelayForDustyBassGrainR inleta "InR"

  aDelayForDustyBassGrainL, aDelayForDustyBassGrainR mixerChannel aDelayForDustyBassGrainL, aDelayForDustyBassGrainR, gkDelayForDustyBassGrainFader, gkDelayForDustyBassGrainPan, gkDelayForDustyBassGrainEqBass, gkDelayForDustyBassGrainEqMid, gkDelayForDustyBassGrainEqHigh

  outleta "OutL", aDelayForDustyBassGrainL
  outleta "OutR", aDelayForDustyBassGrainR
endin
