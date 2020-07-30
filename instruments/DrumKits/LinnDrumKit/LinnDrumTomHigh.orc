instrumentRoute "LinnDrumTomHigh", "LinnDrumKitBus"

alwayson "LinnDrumTomHighMixerChannel"

gkLinnDrumTomHighEqBass init 1
gkLinnDrumTomHighEqMid init 1
gkLinnDrumTomHighEqHigh init 1
gkLinnDrumTomHighFader init 1
gkLinnDrumTomHighPan init 55

gSLinnDrumTomHighSamplePath = "songs/basketballBeatsEnnui/samples/VA2105_hh.wav"

giLinnDrumTomHighSample ftgen 0, 0, 0, 1, gSLinnDrumTomHighSamplePath, 0, 0, 0


instr LinnDrumTomHigh
  aOutL, aOutR drumSample giLinnDrumTomHighSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr LinnDrumTomHighBassKnob
    gkLinnDrumTomHighEqBass linseg p4, p3, p5
endin

instr LinnDrumTomHighMidKnob
    gkLinnDrumTomHighEqMid linseg p4, p3, p5
endin

instr LinnDrumTomHighHighKnob
    gkLinnDrumTomHighEqHigh linseg p4, p3, p5
endin

instr LinnDrumTomHighFader
    gkLinnDrumTomHighFader linseg p4, p3, p5
endin

instr LinnDrumTomHighPan
    gkLinnDrumTomHighPan linseg p4, p3, p5
endin

instr LinnDrumTomHighMixerChannel
  aLinnDrumTomHighL inleta "InL"
  aLinnDrumTomHighR inleta "InR"

  aLinnDrumTomHighL, aLinnDrumTomHighR mixerChannel aLinnDrumTomHighL, aLinnDrumTomHighR, gkLinnDrumTomHighFader, gkLinnDrumTomHighPan, gkLinnDrumTomHighEqBass, gkLinnDrumTomHighEqMid, gkLinnDrumTomHighEqHigh

  outleta "OutL", aLinnDrumTomHighL
  outleta "OutR", aLinnDrumTomHighR
endin
