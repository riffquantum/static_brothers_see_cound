opcode majorSeventh, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? pchcps(iPitch) : iPitch)

    iMajorSeventh = iRoot+0.11

    xout iMajorSeventh
endop
