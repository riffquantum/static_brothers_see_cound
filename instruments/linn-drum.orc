; Linn Drum
; Older version of my LinnDrum that uses the diskin opcode

connect "LinnDrum", "LinnDrumOutL", "LinnDrumMixerChannel", "LinnDrumInL"
connect "LinnDrum", "LinnDrumOutR", "LinnDrumMixerChannel", "LinnDrumInR"
; connect "LinnDrumMixerChannel", "LinnDrumOutL", "Mixer", "MixerInL"
; connect "LinnDrumMixerChannel", "LinnDrumOutR", "Mixer", "MixerInR"
connect "LinnDrumMixerChannel", "LinnDrumOutL", "Reverb1", "Reverb1InL"
connect "LinnDrumMixerChannel", "LinnDrumOutR", "Reverb1", "Reverb1InR"
alwayson "LinnDrumMixerChannel"

gkLinnDrumFader init 1
gkLinnDrumPan init 50

instr LinnDrum

    SModifier strget p4
    SFullPath strcat "instruments/LinnDrumLM-2/Normalized/", SModifier
    SFullPath strcat SFullPath, ".aif"
    kKillswitch init p7

    alinn1, alinn2  diskin SFullPath, p5

    kres1           rms (alinn1 * p6)
    kres2           rms (alinn2 * p6)

    alinn3          gain alinn1, kres1
    alinn4          gain alinn2, kres2

    ; if (kKillswitch == 0) then
        outleta "LinnDrumOutL", alinn3
        outleta "LinnDrumOutR", alinn4
    ; endif

    ; out alinn3, alinn4
endin

instr LinnDrumFader
    gkLinnDrumFader linseg p4, p3, p5
endin

instr LinnDrumPan
    gkLinnDrumPan linseg p4, p3, p5
endin

instr LinnDrumMixerChannel
    aLinnDrumL inleta "LinnDrumInL"
    aLinnDrumR inleta "LinnDrumInR"

    kLinnDrumFader = gkLinnDrumFader
    kLinnDrumPan = gkLinnDrumPan

    if kLinnDrumPan > 100 then
        kLinnDrumPan = 100
    elseif kLinnDrumPan < 0 then
        kLinnDrumPan = 0
    endif

    aLinnDrumL = (aLinnDrumL * ((100 - kLinnDrumPan) * 2 / 100)) * kLinnDrumFader
    aLinnDrumR = (aLinnDrumR * (kLinnDrumPan * 2 / 100)) * kLinnDrumFader

    outleta "LinnDrumOutL", aLinnDrumL
    outleta "LinnDrumOutR", aLinnDrumR
endin
    