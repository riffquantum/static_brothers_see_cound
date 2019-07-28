; Mixer

alwayson "Mixer"

instr Mixer
    aOutL inleta "MixerInL"
    aOutR inleta "MixerInR"

    kmin init (0dbfs * -1)
    kmax init 0dbfs

    ;aOutR limit aOutR, kmin, kmax
    ;aOutL limit aOutL, kmin, kmax
    ; aOutR wrap aOutR, kmin, kmax
    ; aOutL wrap aOutL, kmin, kmax
    ; aOutR mirror aOutR, kmin, kmax
    ; aOutL mirror aOutL, kmin, kmax

    out aOutL, aOutR
endin
