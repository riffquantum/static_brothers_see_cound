opcode beatsToSeconds, i, io
  iBeats, iBPM xin
  iBPM = iBPM != 0 ? iBPM : i(gkBPM)

  iSeconds = iBeats * 60/iBPM

  xout iSeconds
endop

opcode bts, i, io
  iBeats, iBPM xin
  xout beatsToSeconds(iBeats, iBPM)
endop
