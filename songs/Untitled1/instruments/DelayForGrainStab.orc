alwayson "DelayForGrainStabInput"
alwayson "DelayForGrainStabMixerChannel"

giDelayForGrainStabBufferLength init 5
gaDelayForGrainStabTime init 0.25
gkDelayForGrainStabFeedbackAmount init 0.8
gkDelayForGrainStabLevel init 1
gkDelayForGrainStabStereoOffset init 0.0

gkDelayForGrainStabEqBass init 1
gkDelayForGrainStabEqMid init 1
gkDelayForGrainStabEqHigh init 1
gkDelayForGrainStabFader init 1
gkDelayForGrainStabPan init 50

gkDelayForGrainStabWetAmount init 1
gkDelayForGrainStabDryAmount init 1

bypassRoute "DelayForGrainStab", "ReverbForGrainStabInput", "ReverbForGrainStabInput"

instr DelayForGrainStabInput
  aDelayForGrainStabInL inleta "InL"
  aDelayForGrainStabInR inleta "InR"

  aDelayForGrainStabOutWetL, aDelayForGrainStabOutWetR, aDelayForGrainStabOutDryL, aDelayForGrainStabOutDryR bypassSwitch aDelayForGrainStabInL, aDelayForGrainStabInR, gkDelayForGrainStabDryAmount, gkDelayForGrainStabWetAmount, "DelayForGrainStab"

  outleta "OutWetL", aDelayForGrainStabOutWetL
  outleta "OutWetR", aDelayForGrainStabOutWetR

  outleta "OutDryL", aDelayForGrainStabOutDryL
  outleta "OutDryR", aDelayForGrainStabOutDryR
endin

instr DelayForGrainStabTimeKnob
  gaDelayForGrainStabTime linseg p4, p3, p5
endin

instr DelayForGrainStabFeedbackAmountKnob
  gkDelayForGrainStabFeedbackAmount linseg p4, p3, p5
endin

instr DelayForGrainStabLevelKnob
  gkDelayForGrainStabLevel linseg p4, p3, p5
endin

instr DelayForGrainStabStereoOffsetKnob
  gkDelayForGrainStabStereoOffset linseg p4, p3, p5
endin


instr DelayForGrainStab
  aDelayForGrainStabInL inleta "InL"
  aDelayForGrainStabInR inleta "InR"

  aDelayForGrainStabTimeL = gaDelayForGrainStabTime + gkDelayForGrainStabStereoOffset
  aDelayForGrainStabTimeR = gaDelayForGrainStabTime - gkDelayForGrainStabStereoOffset

  aDelayForGrainStabAudioL delayBuffer aDelayForGrainStabInL, gkDelayForGrainStabFeedbackAmount, giDelayForGrainStabBufferLength, aDelayForGrainStabTimeL, gkDelayForGrainStabLevel
  aDelayForGrainStabAudioR delayBuffer aDelayForGrainStabInR, gkDelayForGrainStabFeedbackAmount, giDelayForGrainStabBufferLength, aDelayForGrainStabTimeR, gkDelayForGrainStabLevel

  aDelayForGrainStabOutL = aDelayForGrainStabInL + aDelayForGrainStabAudioL
  aDelayForGrainStabOutR = aDelayForGrainStabInR + aDelayForGrainStabAudioR

  outleta "OutL", aDelayForGrainStabOutL
  outleta "OutR", aDelayForGrainStabOutR
endin

instr DelayForGrainStabBassKnob
  gkDelayForGrainStabEqBass linseg p4, p3, p5
endin

instr DelayForGrainStabMidKnob
  gkDelayForGrainStabEqMid linseg p4, p3, p5
endin

instr DelayForGrainStabHighKnob
  gkDelayForGrainStabEqHigh linseg p4, p3, p5
endin

instr DelayForGrainStabFader
  gkDelayForGrainStabFader linseg p4, p3, p5
endin

instr DelayForGrainStabPan
  gkDelayForGrainStabPan linseg p4, p3, p5
endin

instr DelayForGrainStabMixerChannel
  aDelayForGrainStabL inleta "InL"
  aDelayForGrainStabR inleta "InR"

  aDelayForGrainStabL, aDelayForGrainStabR mixerChannel aDelayForGrainStabL, aDelayForGrainStabR, gkDelayForGrainStabFader, gkDelayForGrainStabPan, gkDelayForGrainStabEqBass, gkDelayForGrainStabEqMid, gkDelayForGrainStabEqHigh

  outleta "OutL", aDelayForGrainStabL
  outleta "OutR", aDelayForGrainStabR
endin
