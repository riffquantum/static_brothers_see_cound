opcode eleventh, i, i
    iPitch xin

    iIntervalInSemitones = 15
    iInterval = iPitch > 15 ? iPitch * centsToRatio(iIntervalInSemitones*100) : iPitch+(iIntervalInSemitones/100)

    xout iInterval
endop
