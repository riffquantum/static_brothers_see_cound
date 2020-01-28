opcode third, i, i
    iPitch xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    iThird = iRoot+0.04

    xout iThird    
endop