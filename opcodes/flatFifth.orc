opcode flatFifth, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iFlatFifth = iRoot+0.06

    xout iFlatFifth
endop