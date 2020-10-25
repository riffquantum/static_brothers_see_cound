instrumentRoute "HeftySnare", "DrumKitBus"
alwayson "HeftySnareMixerChannel"

gkHeftySnareEqBass init 1
gkHeftySnareEqMid init 1
gkHeftySnareEqHigh init 1
gkHeftySnareFader init 1.5
gkHeftySnarePan init 50

gSHeftySnareSamplePath = "localSamples/Drums/Linn-Drum_Snare_6.wav"
gSHeftySnareSamplePath = "localSamples/Drums/Qdrums_Snare_EA9008.wav"
gSHeftySnareSamplePath = "localSamples/Drums/R8-Drums_Snare_E7727.wav"
gSHeftySnareSamplePath = "localSamples/Drums/Qdrums_Snare_EA9010.wav"
gSHeftySnareSamplePath = "localSamples/Drums/Funk-Kit_Snare_EA8141.wav"

giHeftySnareSample ftgen 0, 0, 0, 1, gSHeftySnareSamplePath, 0, 0, 0

instr HeftySnare
  aHeftySnareSampleL, aHeftySnareSampleR drumSample giHeftySnareSample, p4, p5

  outleta "OutL", aHeftySnareSampleL
  outleta "OutR", aHeftySnareSampleR
endin

instr HeftySnareBassKnob
  gkHeftySnareEqBass linseg p4, p3, p5
endin

instr HeftySnareMidKnob
  gkHeftySnareEqMid linseg p4, p3, p5
endin

instr HeftySnareHighKnob
  gkHeftySnareEqHigh linseg p4, p3, p5
endin

instr HeftySnareFader
  gkHeftySnareFader linseg p4, p3, p5
endin

instr HeftySnarePan
  gkHeftySnarePan linseg p4, p3, p5
endin

instr HeftySnareMixerChannel
  aHeftySnareL inleta "InL"
  aHeftySnareR inleta "InR"

  aHeftySnareL, aHeftySnareR mixerChannel aHeftySnareL, aHeftySnareR, gkHeftySnareFader, gkHeftySnarePan, gkHeftySnareEqBass, gkHeftySnareEqMid, gkHeftySnareEqHigh

  outleta "OutL", aHeftySnareL
  outleta "OutR", aHeftySnareR
endin
