opcode octaveUp, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? pchcps(iPitch) : iPitch)

    iOctave = iRoot+0.12

    xout iOctave
endop
