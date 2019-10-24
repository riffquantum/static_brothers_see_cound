; snare

connect "snare", "snareOut", "snareMixerChannel", "snareIn"

connect "snareMixerChannel", "snareOutL", "Mixer", "MixerInL"
connect "snareMixerChannel", "snareOutR", "Mixer", "MixerInR"

alwayson "snareMixerChannel"

gksnareEqBass init 1
gksnareEqMid init 1
gksnareEqHigh init 1
gksnareFader init 1
gksnarePan init 50

instr snare
    kAmp = p4
    kpitch init 1
    iSkipTime init 0
    iwraparound init 0
    iformat init 0
    iskipinit init 0

    SsampleFilePath = "songs/basketballBeatsEnnui/samples/VA1108_sd.wav"


    asnare diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    kres   rms (asnare * kAmp)
    asnare gain asnare, kres

    outleta "snareOut", asnare
endin

instr snareBassKnob
    gksnareEqBass linseg p4, p3, p5
endin

instr snareMidKnob
    gksnareEqMid linseg p4, p3, p5
endin

instr snareHighKnob
    gksnareEqHigh linseg p4, p3, p5
endin

instr snareFader
    gksnareFader linseg p4, p3, p5
endin

instr snarePan
    gksnarePan linseg p4, p3, p5
endin

instr snareMixerChannel
    asnareL inleta "snareIn"
    asnareR inleta "snareIn"

    kpanvalue linseg 0, 1, 100

    ksnareFader = gksnareFader
    ksnarePan = gksnarePan
    ksnareEqBass = gksnareEqBass
    ksnareEqMid = gksnareEqMid
    ksnareEqHigh = gksnareEqHigh

    asnareL, asnareR threeBandEqStereo asnareL, asnareR, ksnareEqBass, ksnareEqMid, ksnareEqHigh

    if ksnarePan > 100 then
        ksnarePan = 100
    elseif ksnarePan < 0 then
        ksnarePan = 0
    endif

    asnareL = (asnareL * ((100 - ksnarePan) * 2 / 100)) * ksnareFader
    asnareR = (asnareR * (ksnarePan * 2 / 100)) * ksnareFader

    outleta "snareOutL", asnareL
    outleta "snareOutR", asnareR

endin
