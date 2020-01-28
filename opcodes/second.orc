opcode second, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iSecond = iRoot+0.02

    xout iSecond
endop