opcode pan, aa, aak
  aSignalL, aSignalR, kPanValue xin

  kPanValue limit kPanValue, 0, 100

  aSignalL = (aSignalL * ((100 - kPanValue) * 2 / 100))
  aSignalR = (aSignalR * (kPanValue * 2 / 100))

  xout aSignalL, aSignalR
endop
