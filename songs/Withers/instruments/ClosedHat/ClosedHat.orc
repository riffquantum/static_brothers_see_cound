instrumentRoute "ClosedHat", "DrumKitBus"
alwayson "ClosedHatMixerChannel"

gkClosedHatEqBass init 1
gkClosedHatEqMid init 1
gkClosedHatEqHigh init 1
gkClosedHatFader init 1
gkClosedHatPan init 50

gSClosedHatSamplePath ="localSamples/Drums/House-Drums_Closed-Hat_EA8820.wav"

if filenchnls(gSClosedHatSamplePath) == 1 then
  giClosedHatSample ftgen 0, 0, 0, 1, gSClosedHatSamplePath, 0, 0, 0
else
  giClosedHatSampleL ftgen 0, 0, 0, 1, gSClosedHatSamplePath, 0, 0, 1
  giClosedHatSampleR ftgen 0, 0, 0, 1, gSClosedHatSamplePath, 0, 0, 2
endif

instr ClosedHat
  aClosedHatSampleL, aClosedHatSampleR drumSample giClosedHatSample, p4, p5

  outleta "OutL", aClosedHatSampleL
  outleta "OutR", aClosedHatSampleR
endin

instr ClosedHatBassKnob
  gkClosedHatEqBass linseg p4, p3, p5
endin

instr ClosedHatMidKnob

  gkClosedHatEqMid linseg p4, p3, p5
endin

instr ClosedHatHighKnob
  gkClosedHatEqHigh linseg p4, p3, p5
endin

instr ClosedHatFader
  gkClosedHatFader linseg p4, p3, p5
endin

instr ClosedHatPan
  gkClosedHatPan linseg p4, p3, p5
endin

instr ClosedHatMixerChannel
  aClosedHatL inleta "InL"
  aClosedHatR inleta "InR"

  aClosedHatL, aClosedHatR mixerChannel aClosedHatL, aClosedHatR, gkClosedHatFader, gkClosedHatPan, gkClosedHatEqBass, gkClosedHatEqMid, gkClosedHatEqHigh

  outleta "OutL", aClosedHatL
  outleta "OutR", aClosedHatR
endin
