; Kick

gSKickName = "Kick"
gSKickRoute = "Mixer"
instrumentRoute gSKickName, gSKickRoute

alwayson "KickMixerChannel"

gkKickEqBass init 1
gkKickEqMid init 1
gkKickEqHigh init 1
gkKickFader init 1
gkKickPan init 50

instr Kick
    kAmp = p4
    kpitch init 1
    iSkipTime init 0
    iwraparound init 0
    iformat init 0
    iskipinit init 0

    SsampleFilePath = "songs/basketballBeatsEnnui/samples/EA7636_R8_Bd.wav"
    SsampleFilePath2 = "songs/basketballBeatsEnnui/samples/EA7606_R8_Bd.wav"


    aKick diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
    aKick2 diskin SsampleFilePath2, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    aKick = aKick + aKick2

    kres   rms (aKick * kAmp)
    aKick gain aKick, kres

    outleta "KickOut", aKick
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
    aKickL inleta "KickIn"
    aKickR inleta "KickIn"

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
