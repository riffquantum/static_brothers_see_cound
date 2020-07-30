opcode third, i, i
    iPitch xin

    iIntervalInSemitones = 4
    iInterval = iPitch > 15 ? iPitch * centsToRatio(iIntervalInSemitones*100) : iPitch+(iIntervalInSemitones/100)

    xout iInterval
endop
