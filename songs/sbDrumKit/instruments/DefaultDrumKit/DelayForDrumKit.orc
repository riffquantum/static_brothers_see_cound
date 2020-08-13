instrumentRoute "DelayForDrumKit", "Mixer"
stereoRoute "DelayForDrumKitMixerChannel", "ReverbForDrumKit"
alwayson "DelayForDrumKitMixerChannel"

giDelayForDrumKitBufferLength init 5
gaDelayForDrumKitTime init .3
gkDelayForDrumKitFeedbackAmmount init 0.8
gkDelayForDrumKitWetLevel init .2
gkDelayForDrumKitDryLevel init 0
gkDelayForDrumKitStereoOffset init 0.1

gkDelayForDrumKitEqBass init 1
gkDelayForDrumKitEqMid init 1
gkDelayForDrumKitEqHigh init 1
gkDelayForDrumKitFader init 1
gkDelayForDrumKitPan init 50

instr DelayForDrumKitTimeKnob
  gaDelayForDrumKitTime linseg p4, p3, p5
endin

instr DelayForDrumKitFeedbackAmmountKnob
  gkDelayForDrumKitFeedbackAmmount linseg p4, p3, p5
endin

instr DelayForDrumKitLevelKnob
  gkDelayForDrumKitWetLevel linseg p4, p3, p5
endin

instr StereoOffsetKnob
  gkDelayForDrumKitStereoOffset linseg p4, p3, p5
endin


instr DelayForDrumKit
  aDelayForDrumKitInL inleta "InL"
  aDelayForDrumKitInR inleta "InR"

  aDelayForDrumKitTimeL = gaDelayForDrumKitTime + gkDelayForDrumKitStereoOffset
  aDelayForDrumKitTimeR = gaDelayForDrumKitTime - gkDelayForDrumKitStereoOffset

  kWetLevel = madsr(.01, .01, 1, .01) * gkDelayForDrumKitWetLevel

  aDelayForDrumKitWetL delayBuffer aDelayForDrumKitInL, gkDelayForDrumKitFeedbackAmmount, giDelayForDrumKitBufferLength, aDelayForDrumKitTimeL + oscil(0.025, .1) + oscil(0.025, .05), gkDelayForDrumKitWetLevel
  aDelayForDrumKitWetR delayBuffer aDelayForDrumKitInR, gkDelayForDrumKitFeedbackAmmount, giDelayForDrumKitBufferLength, aDelayForDrumKitTimeR + oscil(0.025, .1) + oscil(0.025, .05), gkDelayForDrumKitWetLevel

  aDelayForDrumKitOutL = (aDelayForDrumKitInL * gkDelayForDrumKitDryLevel) + aDelayForDrumKitWetL
  aDelayForDrumKitOutR = (aDelayForDrumKitInR * gkDelayForDrumKitDryLevel) + aDelayForDrumKitWetR

  outleta "OutL", aDelayForDrumKitOutL
  outleta "OutR", aDelayForDrumKitOutR
endin

instr DelayForDrumKitBassKnob
  gkDelayForDrumKitEqBass linseg p4, p3, p5
endin

instr DelayForDrumKitMidKnob
  gkDelayForDrumKitEqMid linseg p4, p3, p5
endin

instr DelayForDrumKitHighKnob
  gkDelayForDrumKitEqHigh linseg p4, p3, p5
endin

instr DelayForDrumKitFader
  gkDelayForDrumKitFader linseg p4, p3, p5
endin

instr DelayForDrumKitPan
  gkDelayForDrumKitPan linseg p4, p3, p5
endin

instr DelayForDrumKitMixerChannel
  aDelayForDrumKitL inleta "InL"
  aDelayForDrumKitR inleta "InR"

  aDelayForDrumKitL, aDelayForDrumKitR mixerChannel aDelayForDrumKitL, aDelayForDrumKitR, gkDelayForDrumKitFader, gkDelayForDrumKitPan, gkDelayForDrumKitEqBass, gkDelayForDrumKitEqMid, gkDelayForDrumKitEqHigh

  outleta "OutL", aDelayForDrumKitL
  outleta "OutR", aDelayForDrumKitR
endin
