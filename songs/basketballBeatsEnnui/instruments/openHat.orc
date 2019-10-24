; openHat

connect "openHat", "openHatOut", "openHatMixerChannel", "openHatIn"

connect "openHatMixerChannel", "openHatOutL", "Mixer", "MixerInL"
connect "openHatMixerChannel", "openHatOutR", "Mixer", "MixerInR"

alwayson "openHatMixerChannel"

gkopenHatEqBass init 1
gkopenHatEqMid init 1
gkopenHatEqHigh init 1
gkopenHatFader init 1
gkopenHatPan init 50

instr openHat
    kAmp = p4
    kpitch init 1
    iSkipTime init 0
    iwraparound init 0
    iformat init 0
    iskipinit init 0

    SsampleFilePath = "songs/basketballBeatsEnnui/samples/EA7804_R8_Oh.wav"


    aopenHat diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    kres   rms (aopenHat * kAmp)
    aopenHat gain aopenHat, kres

    outleta "openHatOut", aopenHat
endin

instr openHatBassKnob
    gkopenHatEqBass linseg p4, p3, p5
endin

instr openHatMidKnob
    gkopenHatEqMid linseg p4, p3, p5
endin

instr openHatHighKnob
    gkopenHatEqHigh linseg p4, p3, p5
endin

instr openHatFader
    gkopenHatFader linseg p4, p3, p5
endin

instr openHatPan
    gkopenHatPan linseg p4, p3, p5
endin

instr openHatMixerChannel
    aopenHatL inleta "openHatIn"
    aopenHatR inleta "openHatIn"

    kpanvalue linseg 0, 1, 100

    kopenHatFader = gkopenHatFader
    kopenHatPan = gkopenHatPan
    kopenHatEqBass = gkopenHatEqBass
    kopenHatEqMid = gkopenHatEqMid
    kopenHatEqHigh = gkopenHatEqHigh

    aopenHatL, aopenHatR threeBandEqStereo aopenHatL, aopenHatR, kopenHatEqBass, kopenHatEqMid, kopenHatEqHigh

    if kopenHatPan > 100 then
        kopenHatPan = 100
    elseif kopenHatPan < 0 then
        kopenHatPan = 0
    endif

    aopenHatL = (aopenHatL * ((100 - kopenHatPan) * 2 / 100)) * kopenHatFader
    aopenHatR = (aopenHatR * (kopenHatPan * 2 / 100)) * kopenHatFader

    outleta "openHatOutL", aopenHatL
    outleta "openHatOutR", aopenHatR

endin
