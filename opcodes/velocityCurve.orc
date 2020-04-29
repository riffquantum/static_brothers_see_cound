/*
  velocityCurve
  Accepts a midi velocity (0-127) and returns an
  amplitude value between 0 and 1. The second argument affects
  the curve. Use 1 for a linear result. Use a number below 1 for
  a slow start and fast finish curve (drop). Use a number above one for
  a fast start and slow finish curve (hump).
*/

opcode velocityCurve, i, ip
  iVelocity, iDegree xin

  iAmplitude = (iVelocity/127)^(1/iDegree)

  xout iAmplitude
endop
