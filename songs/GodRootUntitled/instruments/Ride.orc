; Ride
gSRideName = "Ride"
gSRideRoute = "Mixer"
instrumentRoute gSRideName, gSRideRoute

alwayson "RideMixerChannel"

gkRideEqBass init 1
gkRideEqMid init 1
gkRideEqHigh init 1
gkRideFader init 1
gkRidePan init 50

gSRideSamplePath = "localSamples/Drums/R8-Drums_Ride_E742.wav"
gSRideMidSamplePath = "localSamples/Drums/R8-Drums_Ride_E710.wav"

giRideSample ftgen 0, 0, 0, 1, gSRideSamplePath, 0, 0, 0


instr Ride
  aOutL, aOutR drumSample giRideSample, p4, p5

  outleta "OutL", aOutL
  outleta "OutR", aOutR
endin

instr RideBassKnob
    gkRideEqBass linseg p4, p3, p5
endin

instr RideMidKnob
    gkRideEqMid linseg p4, p3, p5
endin

instr RideHighKnob
    gkRideEqHigh linseg p4, p3, p5
endin

instr RideFader
    gkRideFader linseg p4, p3, p5
endin

instr RidePan
    gkRidePan linseg p4, p3, p5
endin

instr RideMixerChannel
    aRideL inleta "InL"
    aRideR inleta "InR"

    kpanvalue linseg 0, 1, 100

    kRideFader = gkRideFader
    kRidePan = gkRidePan
    kRideEqBass = gkRideEqBass
    kRideEqMid = gkRideEqMid
    kRideEqHigh = gkRideEqHigh

    aRideL, aRideR threeBandEqStereo aRideL, aRideR, kRideEqBass, kRideEqMid, kRideEqHigh

    if kRidePan > 100 then
        kRidePan = 100
    elseif kRidePan < 0 then
        kRidePan = 0
    endif

    ;aRideL distort1 aRideL, 2, 1, .01, .01
    ;aRideR distort1 aRideR, 2, 1, .01, .01

    aRideL = (aRideL * ((100 - kRidePan) * 2 / 100)) * kRideFader
    aRideR = (aRideR * (kRidePan * 2 / 100)) * kRideFader

    outleta "OutL", aRideL
    outleta "OutR", aRideR

endin
