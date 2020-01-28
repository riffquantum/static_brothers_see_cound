opcode sixth, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iSixth = iRoot+0.09

    xout iSixth
endop