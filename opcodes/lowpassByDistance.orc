; Adapted from code by Michael Gogins

opcode lowpassByDistance, a, ak
  asignal, kdistance xin

  afiltered butterlp asignal, 22000 * sqrt(1.0 / kdistance) + .000001
  abalanced balance afiltered, asignal

  xout abalanced
endop
