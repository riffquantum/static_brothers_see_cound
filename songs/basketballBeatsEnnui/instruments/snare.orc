; Snare
gSSnareName = "Snare"
gSSnareRoute = "Mixer"
instrumentRoute gSSnareName, gSSnareRoute

alwayson "SnareMixerChannel"

gkSnareEqBass init 1
gkSnareEqMid init 1
gkSnareEqHigh init 1
gkSnareFader init 1
gkSnarePan init 50

gSSnareSamplePath = "songs/basketballBeatsEnnui/samples/VA1108_sd.wav"

giSnareSample ftgen 0, 0, 0, 1, gSSnareSamplePath, 0, 0, 0


instr Snare
  aOutL, aOutR drumSample giSnareSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
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

    kpanvalue linseg 0, 1, 100

    kSnareFader = gkSnareFader
    kSnarePan = gkSnarePan
    kSnareEqBass = gkSnareEqBass
    kSnareEqMid = gkSnareEqMid
    kSnareEqHigh = gkSnareEqHigh

    aSnareL, aSnareR threeBandEqStereo aSnareL, aSnareR, kSnareEqBass, kSnareEqMid, kSnareEqHigh

    if kSnarePan > 100 then
        kSnarePan = 100
    elseif kSnarePan < 0 then
        kSnarePan = 0
    endif

    ;aSnareL distort1 aSnareL, 2, 1, .01, .01
    ;aSnareR distort1 aSnareR, 2, 1, .01, .01

    aSnareL = (aSnareL * ((100 - kSnarePan) * 2 / 100)) * kSnareFader
    aSnareR = (aSnareR * (kSnarePan * 2 / 100)) * kSnareFader

    outleta "OutL", aSnareL
    outleta "OutR", aSnareR

endin
