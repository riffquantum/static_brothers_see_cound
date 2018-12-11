/* TR808
    Sampler using samples from the Roland TR-808 drum machine. 

    p4 - Drum Name - String - valid values:
    p5 - coresponds to kpitch on diskin opcode
    p6 - amplitude modifier
    p7 - kill switch - Note will only output audio when this
        equals 0. Use it with a loop count and some arithmetic
        to turn notes on and off per measure.
*/

connect "TR808", "TR808OutL", "TR808MixerChannel", "TR808InL"
connect "TR808", "TR808OutR", "TR808MixerChannel", "TR808InR"

alwayson "TR808MixerChannel"

gkTR808EqBass init 1
gkTR808EqMid init 1
gkTR808EqHigh init 1
gkTR808Fader init 1
gkTR808Pan init 50

instr TR808
    SDrumName strget p4
    SFullPath strcat "instruments/TR808/RolandTR-808/", SDrumName
    SFullPath strcat SFullPath, ".aif"
    kKillswitch init p7

    if (kKillswitch == 0) then
        a8081  diskin SFullPath, p5
    endif

    kres1           rms (a8081 * p6)

    a8083          gain a8081, kres1

    outleta "TR808OutL", a8083
    outleta "TR808OutR", a8083
endin

instr TR808BassKnob
    gkTR808EqBass linseg p4, p3, p5
endin

instr TR808MidKnob
    gkTR808EqMid linseg p4, p3, p5
endin

instr TR808HighKnob
    gkTR808EqHigh linseg p4, p3, p5  
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
    kTR808EqBass = gkTR808EqBass
    kTR808EqMid = gkTR808EqMid
    kTR808EqHigh = gkTR808EqHigh

    aTR808L, aTR808R threeBandEqStereo aTR808L, aTR808R, kTR808EqBass, kTR808EqMid, kTR808EqHigh

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
