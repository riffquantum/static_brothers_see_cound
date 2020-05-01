opcode mixerChannel, aa, aakkkkk
  aSingalL, aSingalR, kFader, kPan, kEqBass, kEqMid, kEqHigh xin

  aSingalL, aSingalR threeBandEqStereo aSingalL, aSingalR, kEqBass, kEqMid, kEqHigh

  kPan limit kPan, 0, 100

  aSingalL = (aSingalL * ((100 - kPan) * 2 / 100)) * kFader
  aSingalR = (aSingalR * (kPan * 2 / 100)) * kFader


  xout aSingalL, aSingalR
endop
