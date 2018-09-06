; Linn Drum

connect "TR808", "TR808OutL", "TR808MixerChannel", "TR808InL"
connect "TR808", "TR808OutR", "TR808MixerChannel", "TR808InR"
connect "TR808MixerChannel", "TR808OutL", "Mixer", "MixerInL"
connect "TR808MixerChannel", "TR808OutR", "Mixer", "MixerInR"
; connect "TR808MixerChannel", "TR808OutL", "Reverb1", "Reverb1InL"
; connect "TR808MixerChannel", "TR808OutR", "Reverb1", "Reverb1InR"
alwayson "TR808MixerChannel"

gkTR808Fader init 1
gkTR808Pan init 50

instr TR808
    SDrumName strget p4
    SFullPath strcat "instruments/Roland TR-808/", SDrumName
    SFullPath strcat SFullPath, ".aif"

    a8081  diskin SFullPath, p5
    kKillswitch init p7

    kres1           rms (a8081 * p6)

    a8083          gain a8081, kres1

    ; if (kKillswitch == 0) then
        outleta "TR808OutL", a8083
        outleta "TR808OutR", a8083
    ; endif

    ; out a8083, a8083
endin


instr TR808Fader
    gkTR808Fader linseg p4, p3, p5
endin

instr TR808Pan
    gkTR808Pan linseg p4, p3, p5
endin

instr TR808MixerChannel
    aTR808L inleta "TR808InL"
    aTR808R inleta "TR808InR"

    kTR808Fader = gkTR808Fader
    kTR808Pan = gkTR808Pan

    if kTR808Pan > 100 then
        kTR808Pan = 100
    elseif kTR808Pan < 0 then
        kTR808Pan = 0
    endif

    aTR808L = (aTR808L * ((100 - kTR808Pan) * 2 / 100)) * kTR808Fader
    aTR808R = (aTR808R * (kTR808Pan * 2 / 100)) * kTR808Fader

    outleta "TR808OutL", aTR808L
    outleta "TR808OutR", aTR808R

    out aTR808L, aTR808R
endin
