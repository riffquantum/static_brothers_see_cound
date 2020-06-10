; TomLow
gSTomLowName = "TomLow"
gSTomLowRoute = "Mixer"
instrumentRoute gSTomLowName, gSTomLowRoute

alwayson "TomLowMixerChannel"

gkTomLowEqBass init 1
gkTomLowEqMid init 1
gkTomLowEqHigh init 1
gkTomLowFader init 1
gkTomLowPan init 50

gSTomLowSamplePath = "localSamples/Drums/R8-Drums_Tom_E7661.wav"

giTomLowSample ftgen 0, 0, 0, 1, gSTomLowSamplePath, 0, 0, 0


instr TomLow
  iAmplitude = p4
  kPitch = p5 == 0 ? 1 : p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aTomLowOut loscil kAmplitudeEnvelope, kPitch, giTomLowSample, 1

  outleta "OutL", aTomLowOut
  outleta "OutR", aTomLowOut
endin

instr TomLowBassKnob
    gkTomLowEqBass linseg p4, p3, p5
endin

instr TomLowMidKnob
    gkTomLowEqMid linseg p4, p3, p5
endin

instr TomLowHighKnob
    gkTomLowEqHigh linseg p4, p3, p5
endin

instr TomLowFader
    gkTomLowFader linseg p4, p3, p5
endin

instr TomLowPan
    gkTomLowPan linseg p4, p3, p5
endin

instr TomLowMixerChannel
    aTomLowL inleta "InL"
    aTomLowR inleta "InR"

    kpanvalue linseg 0, 1, 100

    kTomLowFader = gkTomLowFader
    kTomLowPan = gkTomLowPan
    kTomLowEqBass = gkTomLowEqBass
    kTomLowEqMid = gkTomLowEqMid
    kTomLowEqHigh = gkTomLowEqHigh

    aTomLowL, aTomLowR threeBandEqStereo aTomLowL, aTomLowR, kTomLowEqBass, kTomLowEqMid, kTomLowEqHigh

    if kTomLowPan > 100 then
        kTomLowPan = 100
    elseif kTomLowPan < 0 then
        kTomLowPan = 0
    endif

    ;aTomLowL distort1 aTomLowL, 2, 1, .01, .01
    ;aTomLowR distort1 aTomLowR, 2, 1, .01, .01

    aTomLowL = (aTomLowL * ((100 - kTomLowPan) * 2 / 100)) * kTomLowFader
    aTomLowR = (aTomLowR * (kTomLowPan * 2 / 100)) * kTomLowFader

    outleta "OutL", aTomLowL
    outleta "OutR", aTomLowR

endin
