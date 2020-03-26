opcode sharp, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? pchcps(iPitch) : iPitch)

    iSharp = iRoot+0.01

    xout iSharp
endop
