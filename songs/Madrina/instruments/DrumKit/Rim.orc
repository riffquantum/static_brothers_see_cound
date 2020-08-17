
instrumentRoute "Rim", "DrumKitBus"
alwayson "RimMixerChannel"

gkRimEqBass init 1
gkRimEqMid init 1
gkRimEqHigh init 1
gkRimFader init 1.5
gkRimPan init 50

gSRimSamplePath = "localSamples/Drums/Linn-Drum_Rim_10.wav"
; gSRimSamplePath = "localSamples/Drums/Linn-Drum_Rim_8.wav"


giRimSample ftgen 0, 0, 0, 1, gSRimSamplePath, 0, 0, 0

instr Rim
  aRimSampleL, aRimSampleR drumSample giRimSample, p4, p5

  outleta "OutL", aRimSampleL
  outleta "OutR", aRimSampleR
endin

instr RimBassKnob
  gkRimEqBass linseg p4, p3, p5
endin

instr RimMidKnob
  gkRimEqMid linseg p4, p3, p5
endin

instr RimHighKnob
  gkRimEqHigh linseg p4, p3, p5
endin

instr RimFader
  gkRimFader linseg p4, p3, p5
endin

instr RimPan
  gkRimPan linseg p4, p3, p5
endin

instr RimMixerChannel
  aRimL inleta "InL"
  aRimR inleta "InR"

  aRimL, aRimR mixerChannel aRimL, aRimR, gkRimFader, gkRimPan, gkRimEqBass, gkRimEqMid, gkRimEqHigh

  outleta "OutL", aRimL
  outleta "OutR", aRimR
endin
