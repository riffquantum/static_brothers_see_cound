opcode ninth, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iNinth = iRoot+0.14

    xout iNinth
endop