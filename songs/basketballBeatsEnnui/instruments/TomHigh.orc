; TomHigh
gSTomHighName = "TomHigh"
gSTomHighRoute = "Mixer"
instrumentRoute gSTomHighName, gSTomHighRoute

alwayson "TomHighMixerChannel"

gkTomHighEqBass init 1
gkTomHighEqMid init 1
gkTomHighEqHigh init 1
gkTomHighFader init 1
gkTomHighPan init 50

gSTomHighSamplePath = "songs/basketballBeatsEnnui/samples/VA2105_hh.wav"

giTomHighSample ftgen 0, 0, 0, 1, gSTomHighSamplePath, 0, 0, 0


instr TomHigh
  aOutL, aOutR drumSample giTomHighSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr TomHighBassKnob
    gkTomHighEqBass linseg p4, p3, p5
endin

instr TomHighMidKnob
    gkTomHighEqMid linseg p4, p3, p5
endin

instr TomHighHighKnob
    gkTomHighEqHigh linseg p4, p3, p5
endin

instr TomHighFader
    gkTomHighFader linseg p4, p3, p5
endin

instr TomHighPan
    gkTomHighPan linseg p4, p3, p5
endin

instr TomHighMixerChannel
  aTomHighL inleta "InL"
  aTomHighR inleta "InR"

  aTomHighL, aTomHighR mixerChannel aTomHighL, aTomHighR, gkTomHighFader, gkTomHighPan, gkTomHighEqBass, gkTomHighEqMid, gkTomHighEqHigh

  outleta "OutL", aTomHighL
  outleta "OutR", aTomHighR
endin
