alwayson "DelayForDrumKit"
alwayson "DelayForDrumKitMixerChannel"

giDelayForDrumKitBufferLength init 5
gaDelayForDrumKitTime init .3
gkDelayForDrumKitFeedbackAmmount init 0.8
gkDelayForDrumKitWetLevel init .2
gkDelayForDrumKitDryLevel init 1
gkStereoOffset init 0.01

gkDelayForDrumKitEqBass init 1
gkDelayForDrumKitEqMid init 1
gkDelayForDrumKitEqHigh init 1
gkDelayForDrumKitFader init 1
gkDelayForDrumKitPan init 50
gSDelayForDrumKitName = "DelayForDrumKit"
gSDelayForDrumKitRoute = "Mixer"
instrumentRoute gSDelayForDrumKitName, gSDelayForDrumKitRoute
stereoRoute gSDelayForDrumKitName, "ReverbForDrumKit"


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
  gkStereoOffset linseg p4, p3, p5
endin


instr DelayForDrumKit
  aDelayForDrumKitInL inleta "DelayForDrumKitInL"
  aDelayForDrumKitInR inleta "DelayForDrumKitInR"

  aDelayForDrumKitTimeL = gaDelayForDrumKitTime + gkStereoOffset
  aDelayForDrumKitTimeR = gaDelayForDrumKitTime - gkStereoOffset

  aDelayForDrumKitWetL delayBuffer aDelayForDrumKitInL, gkDelayForDrumKitFeedbackAmmount, giDelayForDrumKitBufferLength, aDelayForDrumKitTimeL + oscil(0.025, .1) + oscil(0.025, .05), gkDelayForDrumKitWetLevel
  aDelayForDrumKitWetR delayBuffer aDelayForDrumKitInR, gkDelayForDrumKitFeedbackAmmount, giDelayForDrumKitBufferLength, aDelayForDrumKitTimeR + oscil(0.025, .1) + oscil(0.025, .05), gkDelayForDrumKitWetLevel

  aDelayForDrumKitOutL = (aDelayForDrumKitInL * gkDelayForDrumKitDryLevel) + aDelayForDrumKitWetL
  aDelayForDrumKitOutR = (aDelayForDrumKitInR * gkDelayForDrumKitDryLevel) + aDelayForDrumKitWetR

  outleta "DelayForDrumKitOutL", aDelayForDrumKitOutL
  outleta "DelayForDrumKitOutR", aDelayForDrumKitOutR
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
  aDelayForDrumKitL inleta "DelayForDrumKitInL"
  aDelayForDrumKitR inleta "DelayForDrumKitInR"

  kDelayForDrumKitFader = gkDelayForDrumKitFader
  kDelayForDrumKitPan = gkDelayForDrumKitPan
  kDelayForDrumKitEqBass = gkDelayForDrumKitEqBass
  kDelayForDrumKitEqMid = gkDelayForDrumKitEqMid
  kDelayForDrumKitEqHigh = gkDelayForDrumKitEqHigh

  aDelayForDrumKitL, aDelayForDrumKitR threeBandEqStereo aDelayForDrumKitL, aDelayForDrumKitR, kDelayForDrumKitEqBass, kDelayForDrumKitEqMid, kDelayForDrumKitEqHigh

  if kDelayForDrumKitPan > 100 then
      kDelayForDrumKitPan = 100
  elseif kDelayForDrumKitPan < 0 then
      kDelayForDrumKitPan = 0
  endif

  aDelayForDrumKitL = (aDelayForDrumKitL * ((100 - kDelayForDrumKitPan) * 2 / 100)) * kDelayForDrumKitFader
  aDelayForDrumKitR = (aDelayForDrumKitR * (kDelayForDrumKitPan * 2 / 100)) * kDelayForDrumKitFader

  outleta "DelayForDrumKitOutL", aDelayForDrumKitL
  outleta "DelayForDrumKitOutR", aDelayForDrumKitR
endin
