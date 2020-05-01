/*
  velocityCurves
  Accepts a midi velocity (0-127) and returns a new midi velocity
  that has been scaled according to the curve. The second argument
  affects the curve. Use 1 for a linear result. Use a number below
  1 for a slow start and fast finish curve (droop). Use a number
  above one for a fast start and slow finish curve (hump).
*/

opcode velocityCurve, i, ip
  iVelocity, iDegree xin

  iScaledVelocity = limit((iVelocity/127)^(1/iDegree) * 127, 0, 127)

  xout iScaledVelocity
endop
