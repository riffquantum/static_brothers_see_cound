; Kick
gSKickName = "Kick"
gSKickRoute = "Mixer"
instrumentRoute gSKickName, gSKickRoute

alwayson "KickMixerChannel"

gkKickEqBass init 1.1
gkKickEqMid init 1
gkKickEqHigh init .9
gkKickFader init 1
gkKickPan init 50

gSKickSamplePath1 = "songs/basketballBeatsEnnui/samples/EA7636_R8_Bd.wav"
gSKickSamplePath2 = "songs/sbDrumKit/samples/EA7614_R8_Bd.wav"
giKickSample1 ftgen 0, 0, 0, 1, gSKickSamplePath1, 0, 0, 0
giKickSample2 ftgen 0, 0, 0, 1, gSKickSamplePath2, 0, 0, 0

instr Kick
  iAmplitude = p4
  kPitch = p5 == 0 ? 1 : p5
  kAmplitudeEnvelope linsegr iAmplitude, p3, iAmplitude, 0.1, 0

  aKickOut1 loscil kAmplitudeEnvelope, kPitch, giKickSample1, 1
  aKickOut2 loscil kAmplitudeEnvelope, kPitch, giKickSample2, 1

  aKickOut = aKickOut1 + aKickOut2

  outleta "KickOutL", aKickOut
  outleta "KickOutR", aKickOut
endin

instr KickBassKnob
    gkKickEqBass linseg p4, p3, p5
endin

instr KickMidKnob
    gkKickEqMid linseg p4, p3, p5
endin

instr KickHighKnob
    gkKickEqHigh linseg p4, p3, p5
endin

instr KickFader
    gkKickFader linseg p4, p3, p5
endin

instr KickPan
    gkKickPan linseg p4, p3, p5
endin

instr KickMixerChannel
    aKickL inleta "KickInL"
    aKickR inleta "KickInR"

    kpanvalue linseg 0, 1, 100

    kKickFader = gkKickFader
    kKickPan = gkKickPan
    kKickEqBass = gkKickEqBass
    kKickEqMid = gkKickEqMid
    kKickEqHigh = gkKickEqHigh

    aKickL, aKickR threeBandEqStereo aKickL, aKickR, kKickEqBass, kKickEqMid, kKickEqHigh

    if kKickPan > 100 then
        kKickPan = 100
    elseif kKickPan < 0 then
        kKickPan = 0
    endif

    ;aKickL distort1 aKickL, 2, 1, .01, .01
    ;aKickR distort1 aKickR, 2, 1, .01, .01

    aKickL = (aKickL * ((100 - kKickPan) * 2 / 100)) * kKickFader
    aKickR = (aKickR * (kKickPan * 2 / 100)) * kKickFader

    outleta "KickOutL", aKickL
    outleta "KickOutR", aKickR

endin
