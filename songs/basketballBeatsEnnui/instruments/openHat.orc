; OpenHat
gSOpenHatName = "OpenHat"
gSOpenHatRoute = "Mixer"
instrumentRoute gSOpenHatName, gSOpenHatRoute

alwayson "OpenHatMixerChannel"

gkOpenHatEqBass init 1
gkOpenHatEqMid init 1
gkOpenHatEqHigh init 1
gkOpenHatFader init 1
gkOpenHatPan init 50

gkOpenHatEqBass init 1
gkOpenHatEqMid init 1
gkOpenHatEqHigh init 1
gkOpenHatFader init 1
gkOpenHatPan init 50
gkOpenHatSharpDelayPitchLine line 1, 4, 3

gSOpenHatSamplePath = "localSamples/Vinylistics vol.1/TcTools_additional_sounds/DbTools_Drum_and_Bass_library/05_R8_Drums/R8_hh/EA7804_R8_Oh.wav"

giOpenHatSample ftgen 0, 0, 0, 1, gSOpenHatSamplePath, 0, 0, 0

instr OpenHat
  iAmplitude = p4
  kPitch = p5 == 0 ? 1 : p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aOpenHatOut loscil kAmplitudeEnvelope, kPitch, giOpenHatSample, 1

  outleta "OpenHatOutL", aOpenHatOut
  outleta "OpenHatOutR", aOpenHatOut
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
    aOpenHatL inleta "OpenHatInL"
    aOpenHatR inleta "OpenHatInR"

    kpanvalue linseg 0, 1, 100

    kOpenHatFader = gkOpenHatFader
    kOpenHatPan = gkOpenHatPan
    kOpenHatEqBass = gkOpenHatEqBass
    kOpenHatEqMid = gkOpenHatEqMid
    kOpenHatEqHigh = gkOpenHatEqHigh

    aOpenHatL, aOpenHatR threeBandEqStereo aOpenHatL, aOpenHatR, kOpenHatEqBass, kOpenHatEqMid, kOpenHatEqHigh

    aOpenHatDelayL delayBuffer aOpenHatL, .7, .1, 1
    aOpenHatDelayL pitchShifter aOpenHatDelayL, gkOpenHatSharpDelayPitchLine, 0, 1
    aOpenHatDelayR delayBuffer aOpenHatR, .7, .1, 1
    aOpenHatDelayR pitchShifter aOpenHatDelayR, gkOpenHatSharpDelayPitchLine, 0, 1

    aOpenHatL = aOpenHatL + aOpenHatDelayL
    aOpenHatR = aOpenHatR + aOpenHatDelayR

    if kOpenHatPan > 100 then
        kOpenHatPan = 100
    elseif kOpenHatPan < 0 then
        kOpenHatPan = 0
    endif

    aOpenHatL = (aOpenHatL * ((100 - kOpenHatPan) * 2 / 100)) * kOpenHatFader
    aOpenHatR = (aOpenHatR * (kOpenHatPan * 2 / 100)) * kOpenHatFader

    outleta "OpenHatOutL", aOpenHatL
    outleta "OpenHatOutR", aOpenHatR
endin
