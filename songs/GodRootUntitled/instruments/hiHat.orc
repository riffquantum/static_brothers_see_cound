; HiHat
gSHiHatName = "HiHat"
gSHiHatRoute = "Mixer"
instrumentRoute gSHiHatName, gSHiHatRoute

alwayson "HiHatMixerChannel"

gkHiHatEqBass init 1
gkHiHatEqMid init 1
gkHiHatEqHigh init 1
gkHiHatFader init 1
gkHiHatPan init 50

gSHiHatSamplePath = "songs/basketballBeatsEnnui/samples/VA2105_hh.wav"

giHiHatSample ftgen 0, 0, 0, 1, gSHiHatSamplePath, 0, 0, 0


instr HiHat
  aOutL, aOutR drumSample giHiHatSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr HiHatBassKnob
    gkHiHatEqBass linseg p4, p3, p5
endin

instr HiHatMidKnob
    gkHiHatEqMid linseg p4, p3, p5
endin

instr HiHatHighKnob
    gkHiHatEqHigh linseg p4, p3, p5
endin

instr HiHatFader
    gkHiHatFader linseg p4, p3, p5
endin

instr HiHatPan
    gkHiHatPan linseg p4, p3, p5
endin

instr HiHatMixerChannel
    aHiHatL inleta "InL"
    aHiHatR inleta "InR"

    kpanvalue linseg 0, 1, 100

    kHiHatFader = gkHiHatFader
    kHiHatPan = gkHiHatPan
    kHiHatEqBass = gkHiHatEqBass
    kHiHatEqMid = gkHiHatEqMid
    kHiHatEqHigh = gkHiHatEqHigh

    aHiHatL, aHiHatR threeBandEqStereo aHiHatL, aHiHatR, kHiHatEqBass, kHiHatEqMid, kHiHatEqHigh

    if kHiHatPan > 100 then
        kHiHatPan = 100
    elseif kHiHatPan < 0 then
        kHiHatPan = 0
    endif

    ;aHiHatL distort1 aHiHatL, 2, 1, .01, .01
    ;aHiHatR distort1 aHiHatR, 2, 1, .01, .01

    aHiHatL = (aHiHatL * ((100 - kHiHatPan) * 2 / 100)) * kHiHatFader
    aHiHatR = (aHiHatR * (kHiHatPan * 2 / 100)) * kHiHatFader

    outleta "OutL", aHiHatL
    outleta "OutR", aHiHatR

endin
