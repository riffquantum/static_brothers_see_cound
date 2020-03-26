; Mixer

alwayson "Mixer"

instr Mixer
    aOutL inleta "MixerInL"
    aOutR inleta "MixerInR"

    iSafetyMaxAmplitude = 0dbfs * 3

    kHardLimitMinimum = iSafetyMaxAmplitude * -2
    kHardLimitMaximum = iSafetyMaxAmplitude * 2


    aOutL clip aOutL, 1, iSafetyMaxAmplitude
    aOutR clip aOutR, 1, iSafetyMaxAmplitude

    aOutR limit aOutR, kHardLimitMinimum, kHardLimitMaximum
    aOutL limit aOutL, kHardLimitMinimum, kHardLimitMaximum

    out aOutL, aOutR
endin
