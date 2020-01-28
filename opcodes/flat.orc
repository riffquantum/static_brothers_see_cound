opcode flat, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iFlat = iRoot-0.01

    xout iFlat
endop