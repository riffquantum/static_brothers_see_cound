/* LinnDrum LM2
    Sampler using samples from the LinnDrum LM2 drum machine. 

    p4 - Drum Name - String - valid values:
    p5 - coresponds to kpitch on diskin opcode
    p6 - amplitude modifier
    p7 - kill switch - Note will only output audio when this
        equals 0. Use it with a loop count and some arithmetic
        to turn notes on and off per measure.


    Thughts on hi hat interuption for midi kit: We can probably interrupt in real time if we break the hat signal out into its own variable. We may need to go as far as to break it out into its own instrument
*/

connect "LinnDrum", "LinnDrumOutL", "LinnDrumMixerChannel", "LinnDrumInL"
connect "LinnDrum", "LinnDrumOutR", "LinnDrumMixerChannel", "LinnDrumInR"
; connect "LinnDrumMixerChannel", "LinnDrumOutL", "Mixer", "MixerInL"
; connect "LinnDrumMixerChannel", "LinnDrumOutR", "sMixer", "MixerInR"
connect "LinnDrumMixerChannel", "LinnDrumOutL", "Reverb1", "Reverb1InL"
connect "LinnDrumMixerChannel", "LinnDrumOutR", "Reverb1", "Reverb1InR"
alwayson "LinnDrumMixerChannel"

gkLinnDrumFader init 1
gkLinnDrumPan init 50

instr LinnDrum
    SModifier strget p4

    SFullPath strcat "instruments/linnDrum/LinnDrumLM-2/Normalized/", SModifier
    SFullPath strcat SFullPath, ".aif"
    kKillswitch init p7

    if (kKillswitch != 0) then
        kgoto end
    endif
    

    if (strcmp(SModifier, "HatOpen") == 0) then
        gaInterrupt1L, gaInterrupt1R  diskin SFullPath, p5
        
        kres1           rms (gaInterrupt1L * p6)
        kres2           rms (gaInterrupt1R * p6)
        
        gaInterrupt1L          gain gaInterrupt1L, kres1
        gaInterrupt1R          gain gaInterrupt1R, kres2
    else
        alinn1, alinn2  diskin SFullPath, p5
        
        kres1           rms (alinn1 * p6)
        kres2           rms (alinn2 * p6)

        alinn3          gain alinn1, kres1
        alinn4          gain alinn2, kres2
        outleta "LinnDrumOutL", alinn3
        outleta "LinnDrumOutR", alinn4
    endif


    end:
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

    aLinnDrumL = aLinnDrumL + gaInterrupt1L
    aLinnDrumR = aLinnDrumR + gaInterrupt1R

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
    
instr LinnDrumSequencer
    ; sequence = [
    ;    "kick",
    ;    [0, 0.5, 3, 4]
    ;]

endin