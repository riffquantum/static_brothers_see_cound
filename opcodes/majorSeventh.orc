opcode majorSeventh, i, i
    iPitch xin

    iIntervalInSemitones = 11
    iInterval = iPitch > 15 ? iPitch * centsToRatio(iIntervalInSemitones*100) : iPitch+(iIntervalInSemitones/100)

    xout iInterval
endop
