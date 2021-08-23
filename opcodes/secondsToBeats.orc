opcode secondsToBeats, i, io
  iSeconds, iBPM xin
  iBPM = iBPM != 0 ? iBPM : i(gkBPM)

  iBeats = iSeconds * iBPM/60

  xout iBeats
endop
