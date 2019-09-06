/* TR606
    Sampler using samples from the Roland TR-606 drum machine.

    p4 - Drum Name - String - valid values:
        kick
        snare
        closedHat
        openHat
        highTom
        lowTom
        cymbal
    p5 - coresponds to kpitch on diskin opcode
    p6 - amplitude modifier
    p7 - kill switch - Note will only output audio when this
        equals 0. Use it with a loop count and some arithmetic
        to turn notes on and off per measure.
    p8 - if 1 then it will play the "saturated" version of the sample.
        That's a version of the sample where the volume was maxed out
        on the original machine.
    p9 - if 1 then it will play the "accent" version of the sample
*/

connect "TR606", "TR606OutL", "TR606MixerChannel", "TR606InL"
connect "TR606", "TR606OutR", "TR606MixerChannel", "TR606InR"

connect "TR606MixerChannel", "TR606OutL", "Mixer", "MixerInL"
connect "TR606MixerChannel", "TR606OutR", "Mixer", "MixerInR"

alwayson "TR606MixerChannel"

gkTR606EqBass init 1
gkTR606EqMid init 1
gkTR606EqHigh init 1
gkTR606Fader init 1
gkTR606Pan init 50

instr TR606
    SDrumName strget p4
    kPitch = p5
    kVelocity = p6
    kKillSwitch = p7
    iSaturated = p8
    iAccent = p9


    SFullPath = "instruments/TR606/Roland TR-606/"
    if (iSaturated == 1) then
        SFullPath strcat SFullPath, "Saturated/"
    else
        SFullPath strcat SFullPath, "Normal/"
    endif

    if (iAccent == 1) then
        SFullPath strcat SFullPath, "accent"
    endif

    SFullPath strcat SFullPath, SDrumName
    SFullPath strcat SFullPath, ".wav"

    if (kKillSwitch == 0) then
        a8081  diskin SFullPath, kPitch
    endif

    kres1           rms (a8081 * kVelocity)

    a8083          gain a8081, kres1

    outleta "TR606OutL", a8083
    outleta "TR606OutR", a8083
endin

instr TR606BassKnob
    gkTR606EqBass linseg p4, p3, p5
endin

instr TR606MidKnob
    gkTR606EqMid linseg p4, p3, p5
endin

instr TR606HighKnob
    gkTR606EqHigh linseg p4, p3, p5
endin

instr TR606Fader
    gkTR606Fader linseg p4, p3, p5
endin

instr TR606Pan
    gkTR606Pan linseg p4, p3, p5
endin

instr TR606MixerChannel
    aTR606L inleta "TR606InL"
    aTR606R inleta "TR606InR"

    kTR606Fader = gkTR606Fader
    kTR606Pan = gkTR606Pan
    kTR606EqBass = gkTR606EqBass
    kTR606EqMid = gkTR606EqMid
    kTR606EqHigh = gkTR606EqHigh

    aTR606L, aTR606R threeBandEqStereo aTR606L, aTR606R, kTR606EqBass, kTR606EqMid, kTR606EqHigh

    if kTR606Pan > 100 then
        kTR606Pan = 100
    elseif kTR606Pan < 0 then
        kTR606Pan = 0
    endif

    aTR606L = (aTR606L * ((100 - kTR606Pan) * 2 / 100)) * kTR606Fader
    aTR606R = (aTR606R * (kTR606Pan * 2 / 100)) * kTR606Fader

    outleta "TR606OutL", aTR606L
    outleta "TR606OutR", aTR606R
endin
