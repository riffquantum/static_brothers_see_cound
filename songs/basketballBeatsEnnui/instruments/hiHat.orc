; hiHat

gShiHatSynthName = "hiHatSynth"
gShiHatSynthRoute = "Mixer"
instrumentRoute gShiHatSynthName, gShiHatSynthRoute

alwayson "hiHatMixerChannel"

gkhiHatEqBass init 1
gkhiHatEqMid init 1
gkhiHatEqHigh init 1
gkhiHatFader init 1
gkhiHatPan init 50

instr hiHat
    kAmp = p4
    kpitch init 1
    iSkipTime init 0
    iwraparound init 0
    iformat init 0
    iskipinit init 0

    SsampleFilePath = "songs/basketballBeatsEnnui/samples/VA2105_hh.wav"

    ahiHat diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    kres   rms (ahiHat * kAmp)
    ahiHat gain ahiHat, kres

    outleta "hiHatOutL", ahiHat
    outleta "hiHatOutR", ahiHat
endin

instr hiHatBassKnob
    gkhiHatEqBass linseg p4, p3, p5
endin

instr hiHatMidKnob
    gkhiHatEqMid linseg p4, p3, p5
endin

instr hiHatHighKnob
    gkhiHatEqHigh linseg p4, p3, p5
endin

instr hiHatFader
    gkhiHatFader linseg p4, p3, p5
endin

instr hiHatPan
    gkhiHatPan linseg p4, p3, p5
endin

instr hiHatMixerChannel
    ahiHatL inleta "hiHatInL"
    ahiHatR inleta "hiHatInR"

    kpanvalue linseg 0, 1, 100

    khiHatFader = gkhiHatFader
    khiHatPan = gkhiHatPan
    khiHatEqBass = gkhiHatEqBass
    khiHatEqMid = gkhiHatEqMid
    khiHatEqHigh = gkhiHatEqHigh

    ahiHatL, ahiHatR threeBandEqStereo ahiHatL, ahiHatR, khiHatEqBass, khiHatEqMid, khiHatEqHigh

    if khiHatPan > 100 then
        khiHatPan = 100
    elseif khiHatPan < 0 then
        khiHatPan = 0
    endif

    ahiHatL = (ahiHatL * ((100 - khiHatPan) * 2 / 100)) * khiHatFader
    ahiHatR = (ahiHatR * (khiHatPan * 2 / 100)) * khiHatFader

    outleta "hiHatOutL", ahiHatL
    outleta "hiHatOutR", ahiHatR

endin
