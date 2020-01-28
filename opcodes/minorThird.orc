opcode minorThird, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iMinorThird = iRoot+0.03

    xout iMinorThird
endop