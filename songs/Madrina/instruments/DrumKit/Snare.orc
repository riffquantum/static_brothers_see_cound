instrumentRoute "Snare", "DrumKitBus"
alwayson "SnareMixerChannel"

gkSnareEqBass init 1
gkSnareEqMid init 1
gkSnareEqHigh init 1
gkSnareFader init 1.5
gkSnarePan init 50

; gSSnareSamplePath = "localSamples/Drums/Mixed-Drums_Snare_EA8529.wav"
gSSnareSamplePath = "localSamples/Drums/Mixed-Drums_Snare_EA8519.wav"
; gSSnareSamplePath = "localSamples/Drums/R8-Drums_Snare_E7702.wav"
; gSSnareSamplePath = "localSamples/Drums/Strictly-Hip-Hop_Snare_SD20.wav"
; gSSnareSamplePath = "localSamples/Drums/VA-Drums_Snare_VA1108.wav"
; gSSnareSamplePath = "localSamples/Drums/VA-Drums_Snare_VA2506.wav"


; gSSnareSamplePath = "localSamples/Drums/House-Drums_Snare_EA8740.wav"

;Deeper Snares
; gSSnareSamplePath = "localSamples/Drums/Funk-Kit_Snare_EA8141.wav"
; gSSnareSamplePath = "localSamples/Drums/Mixed-Drums_Snare_EA8507.wav"


giSnareSample ftgen 0, 0, 0, 1, gSSnareSamplePath, 0, 0, 0

instr Snare
  aSnareSampleL, aSnareSampleR drumSample giSnareSample, p4, p5

  outleta "OutL", aSnareSampleL
  outleta "OutR", aSnareSampleR
endin

instr SnareBassKnob
  gkSnareEqBass linseg p4, p3, p5
endin

instr SnareMidKnob
  gkSnareEqMid linseg p4, p3, p5
endin

instr SnareHighKnob
  gkSnareEqHigh linseg p4, p3, p5
endin

instr SnareFader
  gkSnareFader linseg p4, p3, p5
endin

instr SnarePan
  gkSnarePan linseg p4, p3, p5
endin

instr SnareMixerChannel
  aSnareL inleta "InL"
  aSnareR inleta "InR"

  aSnareL, aSnareR mixerChannel aSnareL, aSnareR, gkSnareFader, gkSnarePan, gkSnareEqBass, gkSnareEqMid, gkSnareEqHigh

  outleta "OutL", aSnareL
  outleta "OutR", aSnareR
endin
