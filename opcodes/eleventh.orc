opcode eleventh, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iEleventh = iRoot+0.14

    xout iEleventh
endop