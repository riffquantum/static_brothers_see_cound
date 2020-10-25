alwayson "ReverbForDrumKit"
alwayson "ReverbForDrumKitMixerChannel"

giReverbForDrumKitBufferLength init 5
gaReverbForDrumKitTime init .3
gkReverbForDrumKitFeedbackAmount init 0.8
gkReverbForDrumKitLevel init .2

gkReverbForDrumKitEqBass init 1
gkReverbForDrumKitEqMid init 1
gkReverbForDrumKitEqHigh init 1
gkReverbForDrumKitFader init 1
gkReverbForDrumKitPan init 50
gSReverbForDrumKitName = "ReverbForDrumKit"
gSReverbForDrumKitRoute = "Mixer"
instrumentRoute gSReverbForDrumKitName, gSReverbForDrumKitRoute

gkReverbForDrumKitWet init .01
gkReverbForDrumKitDry init 0

instr ReverbForDrumKit
  aReverbForDrumKitInL inleta "InL"
  aReverbForDrumKitInR inleta "InR"

  SImpulsePath = "./localSamples/IMreverbs/Narrow Bumpy Space.wav"

  iImpulseTable ftgen 0, 0, 0, 1, SImpulsePath, 0, 0, 0
  iPartitionSize = 64
  iSkipSamples = 0
  iImpulseResponseLength = 0
  iSkipInit = 0

  aReverbForDrumKitWetL ftconv aReverbForDrumKitInL, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit
  aReverbForDrumKitWetR ftconv aReverbForDrumKitInR, iImpulseTable, iPartitionSize, iSkipSamples, iImpulseResponseLength, iSkipInit

  aReverbForDrumKitOutL = (aReverbForDrumKitWetL * gkReverbForDrumKitWet) + (aReverbForDrumKitInL * gkReverbForDrumKitDry)
  aReverbForDrumKitOutR = (aReverbForDrumKitWetR * gkReverbForDrumKitWet) + (aReverbForDrumKitInR * gkReverbForDrumKitDry)

  outleta "OutL", aReverbForDrumKitOutL
  outleta "OutR", aReverbForDrumKitOutR
endin

instr ReverbForDrumKitBassKnob
  gkReverbForDrumKitEqBass linseg p4, p3, p5
endin

instr ReverbForDrumKitMidKnob
  gkReverbForDrumKitEqMid linseg p4, p3, p5
endin

instr ReverbForDrumKitHighKnob
  gkReverbForDrumKitEqHigh linseg p4, p3, p5
endin

instr ReverbForDrumKitFader
  gkReverbForDrumKitFader linseg p4, p3, p5
endin

instr ReverbForDrumKitPan
  gkReverbForDrumKitPan linseg p4, p3, p5
endin

instr ReverbForDrumKitMixerChannel
  aReverbForDrumKitL inleta "InL"
  aReverbForDrumKitR inleta "InR"

  kReverbForDrumKitFader = gkReverbForDrumKitFader
  kReverbForDrumKitPan = gkReverbForDrumKitPan
  kReverbForDrumKitEqBass = gkReverbForDrumKitEqBass
  kReverbForDrumKitEqMid = gkReverbForDrumKitEqMid
  kReverbForDrumKitEqHigh = gkReverbForDrumKitEqHigh

  aReverbForDrumKitL, aReverbForDrumKitR threeBandEqStereo aReverbForDrumKitL, aReverbForDrumKitR, kReverbForDrumKitEqBass, kReverbForDrumKitEqMid, kReverbForDrumKitEqHigh

  if kReverbForDrumKitPan > 100 then
      kReverbForDrumKitPan = 100
  elseif kReverbForDrumKitPan < 0 then
      kReverbForDrumKitPan = 0
  endif

  aReverbForDrumKitL = (aReverbForDrumKitL * ((100 - kReverbForDrumKitPan) * 2 / 100)) * kReverbForDrumKitFader
  aReverbForDrumKitR = (aReverbForDrumKitR * (kReverbForDrumKitPan * 2 / 100)) * kReverbForDrumKitFader

  outleta "OutL", aReverbForDrumKitL
  outleta "OutR", aReverbForDrumKitR
endin
