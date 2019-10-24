; sharpOpenHat

connect "sharpOpenHat", "sharpOpenHatOut", "sharpOpenHatMixerChannel", "sharpOpenHatIn"

connect "sharpOpenHatMixerChannel", "sharpOpenHatOutL", "Mixer", "MixerInL"
connect "sharpOpenHatMixerChannel", "sharpOpenHatOutR", "Mixer", "MixerInR"

alwayson "sharpOpenHatMixerChannel"

gksharpOpenHatEqBass init 1
gksharpOpenHatEqMid init 1
gksharpOpenHatEqHigh init 1
gksharpOpenHatFader init 1
gksharpOpenHatPan init 50
gkOpenHatSharpDelayPitchLine line 1, 4, 3

instr sharpOpenHat
    kAmp = p4
    kpitch init 1
    iSkipTime init 0
    iwraparound init 0
    iformat init 0
    iskipinit init 0

    gkOpenHatSharpDelayPitchLine line 1, 4, 3

    SsampleFilePath = "songs/basketballBeatsEnnui/samples/VA5308_oh.wav"


    asharpOpenHat diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    kres   rms (asharpOpenHat * kAmp)
    asharpOpenHat gain asharpOpenHat, kres

    outleta "sharpOpenHatOut", asharpOpenHat
endin

instr sharpOpenHatBassKnob
    gksharpOpenHatEqBass linseg p4, p3, p5
endin

instr sharpOpenHatMidKnob
    gksharpOpenHatEqMid linseg p4, p3, p5
endin

instr sharpOpenHatHighKnob
    gksharpOpenHatEqHigh linseg p4, p3, p5
endin

instr sharpOpenHatFader
    gksharpOpenHatFader linseg p4, p3, p5
endin

instr sharpOpenHatPan
    gksharpOpenHatPan linseg p4, p3, p5
endin

instr sharpOpenHatMixerChannel
    asharpOpenHatL inleta "sharpOpenHatIn"
    asharpOpenHatR inleta "sharpOpenHatIn"

    kpanvalue linseg 0, 1, 100

    ksharpOpenHatFader = gksharpOpenHatFader
    ksharpOpenHatPan = gksharpOpenHatPan
    ksharpOpenHatEqBass = gksharpOpenHatEqBass
    ksharpOpenHatEqMid = gksharpOpenHatEqMid
    ksharpOpenHatEqHigh = gksharpOpenHatEqHigh

    asharpOpenHatL, asharpOpenHatR threeBandEqStereo asharpOpenHatL, asharpOpenHatR, ksharpOpenHatEqBass, ksharpOpenHatEqMid, ksharpOpenHatEqHigh

    asharpOpenHatDelayL delayBuffer asharpOpenHatL, .7, .1, 1
    asharpOpenHatDelayL pitchShifter asharpOpenHatDelayL, gkOpenHatSharpDelayPitchLine, 0, 1
    asharpOpenHatDelayR delayBuffer asharpOpenHatR, .7, .1, 1
    asharpOpenHatDelayR pitchShifter asharpOpenHatDelayR, gkOpenHatSharpDelayPitchLine, 0, 1

    asharpOpenHatL = asharpOpenHatL + asharpOpenHatDelayL
    asharpOpenHatR = asharpOpenHatR + asharpOpenHatDelayR

    if ksharpOpenHatPan > 100 then
        ksharpOpenHatPan = 100
    elseif ksharpOpenHatPan < 0 then
        ksharpOpenHatPan = 0
    endif

    asharpOpenHatL = (asharpOpenHatL * ((100 - ksharpOpenHatPan) * 2 / 100)) * ksharpOpenHatFader
    asharpOpenHatR = (asharpOpenHatR * (ksharpOpenHatPan * 2 / 100)) * ksharpOpenHatFader

    outleta "sharpOpenHatOutL", asharpOpenHatL
    outleta "sharpOpenHatOutR", asharpOpenHatR

endin
