opcode thirteenth, i, i
    iPitch xin

    iIntervalInSemitones = 21
    iInterval = iPitch > 15 ? iPitch * centsToRatio(iIntervalInSemitones*100) : iPitch+(iIntervalInSemitones/100)

    xout iInterval
endop
