; Mixer

alwayson "Mixer"

instr Mixer
    aOutL inleta "InL"
    aOutR inleta "InR"

    iSafetyMaxAmplitude = 0dbfs * 3

    kHardLimitMinimum = iSafetyMaxAmplitude * -1.5
    kHardLimitMaximum = iSafetyMaxAmplitude * 1.5

    aOutL clip aOutL, 1, iSafetyMaxAmplitude
    aOutR clip aOutR, 1, iSafetyMaxAmplitude

    aOutR limit aOutR, kHardLimitMinimum, kHardLimitMaximum
    aOutL limit aOutL, kHardLimitMinimum, kHardLimitMaximum

    out aOutL, aOutR
endin