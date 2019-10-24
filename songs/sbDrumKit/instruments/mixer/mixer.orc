; Mixer

alwayson "Mixer"

instr Mixer
    aOutL inleta "MixerInL"
    aOutR inleta "MixerInR"

    kmin init (0dbfs * 2 * -1)
    kmax init 0dbfs * 2

    aOutR limit aOutR, kmin, kmax
    aOutL limit aOutL, kmin, kmax

    out aOutL, aOutR
endin
