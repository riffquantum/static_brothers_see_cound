opcode fifth, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iFifth = iRoot+0.07

    xout iFifth
endop