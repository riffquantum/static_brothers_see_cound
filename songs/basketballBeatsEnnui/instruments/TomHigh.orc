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
  iAmplitude = p4
  kPitch = p5 == 0 ? 1 : p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTomHighOut loscil kAmplitudeEnvelope, kPitch, giTomHighSample, 1

  outleta "OutL", aTomHighOut
  outleta "OutR", aTomHighOut
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

    kpanvalue linseg 0, 1, 100

    kTomHighFader = gkTomHighFader
    kTomHighPan = gkTomHighPan
    kTomHighEqBass = gkTomHighEqBass
    kTomHighEqMid = gkTomHighEqMid
    kTomHighEqHigh = gkTomHighEqHigh

    aTomHighL, aTomHighR threeBandEqStereo aTomHighL, aTomHighR, kTomHighEqBass, kTomHighEqMid, kTomHighEqHigh

    if kTomHighPan > 100 then
        kTomHighPan = 100
    elseif kTomHighPan < 0 then
        kTomHighPan = 0
    endif

    ;aTomHighL distort1 aTomHighL, 2, 1, .01, .01
    ;aTomHighR distort1 aTomHighR, 2, 1, .01, .01

    aTomHighL = (aTomHighL * ((100 - kTomHighPan) * 2 / 100)) * kTomHighFader
    aTomHighR = (aTomHighR * (kTomHighPan * 2 / 100)) * kTomHighFader

    outleta "OutL", aTomHighL
    outleta "OutR", aTomHighR

endin
