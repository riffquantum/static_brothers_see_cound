instrumentRoute "DefaultTomHigh", "DefaultDrumKitBus"

alwayson "DefaultTomHighMixerChannel"

gkDefaultTomHighEqBass init 1
gkDefaultTomHighEqMid init 1
gkDefaultTomHighEqHigh init 1
gkDefaultTomHighFader init 1
gkDefaultTomHighPan init 55

gSDefaultTomHighSamplePath = "songs/basketballBeatsEnnui/samples/VA2105_hh.wav"

giDefaultTomHighSample ftgen 0, 0, 0, 1, gSDefaultTomHighSamplePath, 0, 0, 0


instr DefaultTomHigh
  aOutL, aOutR drumSample giDefaultTomHighSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr DefaultTomHighBassKnob
    gkDefaultTomHighEqBass linseg p4, p3, p5
endin

instr DefaultTomHighMidKnob
    gkDefaultTomHighEqMid linseg p4, p3, p5
endin

instr DefaultTomHighHighKnob
    gkDefaultTomHighEqHigh linseg p4, p3, p5
endin

instr DefaultTomHighFader
    gkDefaultTomHighFader linseg p4, p3, p5
endin

instr DefaultTomHighPan
    gkDefaultTomHighPan linseg p4, p3, p5
endin

instr DefaultTomHighMixerChannel
  aDefaultTomHighL inleta "InL"
  aDefaultTomHighR inleta "InR"

  aDefaultTomHighL, aDefaultTomHighR mixerChannel aDefaultTomHighL, aDefaultTomHighR, gkDefaultTomHighFader, gkDefaultTomHighPan, gkDefaultTomHighEqBass, gkDefaultTomHighEqMid, gkDefaultTomHighEqHigh

  outleta "OutL", aDefaultTomHighL
  outleta "OutR", aDefaultTomHighR
endin
