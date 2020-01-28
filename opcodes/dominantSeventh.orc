opcode dominantSeventh, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iDominantSeventh = iRoot+0.10

    xout iDominantSeventh
endop