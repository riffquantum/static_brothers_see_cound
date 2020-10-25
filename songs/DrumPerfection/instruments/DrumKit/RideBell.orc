instrumentRoute "RideBell", "DrumKitBus"
alwayson "RideBellMixerChannel"

gkRideBellEqBass init 1
gkRideBellEqMid init 1
gkRideBellEqHigh init 1
gkRideBellFader init 1.5
gkRideBellPan init 50

gSRideBellSamplePath = "localSamples/Drums/R8-Drums_Ride_E741.wav"
giRideBellSample ftgen 0, 0, 0, 1, gSRideBellSamplePath, 0, 0, 0

instr RideBell
  aRideBellSampleL, aRideBellSampleR drumSample giRideBellSample, p4, p5

  outleta "OutL", aRideBellSampleL
  outleta "OutR", aRideBellSampleR
endin

instr RideBellBassKnob
  gkRideBellEqBass linseg p4, p3, p5
endin

instr RideBellMidKnob
  gkRideBellEqMid linseg p4, p3, p5
endin

instr RideBellHighKnob
  gkRideBellEqHigh linseg p4, p3, p5
endin

instr RideBellFader
  gkRideBellFader linseg p4, p3, p5
endin

instr RideBellPan
  gkRideBellPan linseg p4, p3, p5
endin

instr RideBellMixerChannel
  aRideBellL inleta "InL"
  aRideBellR inleta "InR"

  aRideBellL, aRideBellR mixerChannel aRideBellL, aRideBellR, gkRideBellFader, gkRideBellPan, gkRideBellEqBass, gkRideBellEqMid, gkRideBellEqHigh

  outleta "OutL", aRideBellL
  outleta "OutR", aRideBellR
endin
