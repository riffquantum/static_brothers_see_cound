instrumentRoute "OpenHat", "DrumKitBus"
alwayson "OpenHatMixerChannel"

gkOpenHatEqBass init 1
gkOpenHatEqMid init 1
gkOpenHatEqHigh init 1
gkOpenHatFader init 1
gkOpenHatPan init 50

gSOpenHatSamplePath ="localSamples/Drums/Funk-Kit_Open-Hat_EA8158.wav"

if filenchnls(gSOpenHatSamplePath) == 1 then
  giOpenHatSample ftgen 0, 0, 0, 1, gSOpenHatSamplePath, 0, 0, 0
else
  giOpenHatSampleL ftgen 0, 0, 0, 1, gSOpenHatSamplePath, 0, 0, 1
  giOpenHatSampleR ftgen 0, 0, 0, 1, gSOpenHatSamplePath, 0, 0, 2
endif

instr OpenHat
  aOpenHatSampleL, aOpenHatSampleR drumSample giOpenHatSample, p4, p5, 1

  outleta "OutL", aOpenHatSampleL
  outleta "OutR", aOpenHatSampleR
endin

instr OpenHatBassKnob
  gkOpenHatEqBass linseg p4, p3, p5
endin

instr OpenHatMidKnob

  gkOpenHatEqMid linseg p4, p3, p5
endin

instr OpenHatHighKnob
  gkOpenHatEqHigh linseg p4, p3, p5
endin

instr OpenHatFader
  gkOpenHatFader linseg p4, p3, p5
endin

instr OpenHatPan
  gkOpenHatPan linseg p4, p3, p5
endin

instr OpenHatMixerChannel
  aOpenHatL inleta "InL"
  aOpenHatR inleta "InR"

  aOpenHatL, aOpenHatR mixerChannel aOpenHatL, aOpenHatR, gkOpenHatFader, gkOpenHatPan, gkOpenHatEqBass, gkOpenHatEqMid, gkOpenHatEqHigh

  outleta "OutL", aOpenHatL
  outleta "OutR", aOpenHatR
endin
