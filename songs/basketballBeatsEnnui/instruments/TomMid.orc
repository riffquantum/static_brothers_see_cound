; TomMid
gSTomMidName = "TomMid"
gSTomMidRoute = "Mixer"
instrumentRoute gSTomMidName, gSTomMidRoute

alwayson "TomMidMixerChannel"

gkTomMidEqBass init 1
gkTomMidEqMid init 1
gkTomMidEqHigh init 1
gkTomMidFader init 1
gkTomMidPan init 50

gSTomMidSamplePath = "localSamples/Drums/R8-Drums_Tom_E7662.wav"

giTomMidSample ftgen 0, 0, 0, 1, gSTomMidSamplePath, 0, 0, 0


instr TomMid
  iAmplitude = p4
  kPitch = p5 == 0 ? 1 : p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTomMidOut loscil kAmplitudeEnvelope, kPitch, giTomMidSample, 1

  outleta "TomMidOutL", aTomMidOut
  outleta "TomMidOutR", aTomMidOut
endin

instr TomMidBassKnob
    gkTomMidEqBass linseg p4, p3, p5
endin

instr TomMidMidKnob
    gkTomMidEqMid linseg p4, p3, p5
endin

instr TomMidHighKnob
    gkTomMidEqHigh linseg p4, p3, p5
endin

instr TomMidFader
    gkTomMidFader linseg p4, p3, p5
endin

instr TomMidPan
    gkTomMidPan linseg p4, p3, p5
endin

instr TomMidMixerChannel
    aTomMidL inleta "TomMidInL"
    aTomMidR inleta "TomMidInR"

    kpanvalue linseg 0, 1, 100

    kTomMidFader = gkTomMidFader
    kTomMidPan = gkTomMidPan
    kTomMidEqBass = gkTomMidEqBass
    kTomMidEqMid = gkTomMidEqMid
    kTomMidEqHigh = gkTomMidEqHigh

    aTomMidL, aTomMidR threeBandEqStereo aTomMidL, aTomMidR, kTomMidEqBass, kTomMidEqMid, kTomMidEqHigh

    if kTomMidPan > 100 then
        kTomMidPan = 100
    elseif kTomMidPan < 0 then
        kTomMidPan = 0
    endif

    ;aTomMidL distort1 aTomMidL, 2, 1, .01, .01
    ;aTomMidR distort1 aTomMidR, 2, 1, .01, .01

    aTomMidL = (aTomMidL * ((100 - kTomMidPan) * 2 / 100)) * kTomMidFader
    aTomMidR = (aTomMidR * (kTomMidPan * 2 / 100)) * kTomMidFader

    outleta "TomMidOutL", aTomMidL
    outleta "TomMidOutR", aTomMidR

endin
