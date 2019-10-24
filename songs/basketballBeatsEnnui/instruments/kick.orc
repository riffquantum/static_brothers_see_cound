; kick

connect "kick", "kickOut", "kickMixerChannel", "kickIn"

connect "kickMixerChannel", "kickOutL", "Mixer", "MixerInL"
connect "kickMixerChannel", "kickOutR", "Mixer", "MixerInR"

alwayson "kickMixerChannel"

gkkickEqBass init 1
gkkickEqMid init 1
gkkickEqHigh init 1
gkkickFader init 1
gkkickPan init 50

instr kick
    kAmp = p4
    kpitch init 1
    iSkipTime init 0
    iwraparound init 0
    iformat init 0
    iskipinit init 0

    SsampleFilePath = "songs/basketballBeatsEnnui/samples/EA7636_R8_Bd.wav"
    SsampleFilePath2 = "songs/basketballBeatsEnnui/samples/EA7606_R8_Bd.wav"


    akick diskin SsampleFilePath, kpitch, iSkipTime, iwraparound, iformat, iskipinit
    akick2 diskin SsampleFilePath2, kpitch, iSkipTime, iwraparound, iformat, iskipinit

    akick = akick + akick2

    kres   rms (akick * kAmp)
    akick gain akick, kres

    outleta "kickOut", akick
endin

instr kickBassKnob
    gkkickEqBass linseg p4, p3, p5
endin

instr kickMidKnob
    gkkickEqMid linseg p4, p3, p5
endin

instr kickHighKnob
    gkkickEqHigh linseg p4, p3, p5
endin

instr kickFader
    gkkickFader linseg p4, p3, p5
endin

instr kickPan
    gkkickPan linseg p4, p3, p5
endin

instr kickMixerChannel
    akickL inleta "kickIn"
    akickR inleta "kickIn"

    kpanvalue linseg 0, 1, 100

    kkickFader = gkkickFader
    kkickPan = gkkickPan
    kkickEqBass = gkkickEqBass
    kkickEqMid = gkkickEqMid
    kkickEqHigh = gkkickEqHigh

    akickL, akickR threeBandEqStereo akickL, akickR, kkickEqBass, kkickEqMid, kkickEqHigh

    if kkickPan > 100 then
        kkickPan = 100
    elseif kkickPan < 0 then
        kkickPan = 0
    endif

    ;akickL distort1 akickL, 2, 1, .01, .01
    ;akickR distort1 akickR, 2, 1, .01, .01

    akickL = (akickL * ((100 - kkickPan) * 2 / 100)) * kkickFader
    akickR = (akickR * (kkickPan * 2 / 100)) * kkickFader

    outleta "kickOutL", akickL
    outleta "kickOutR", akickR

endin
