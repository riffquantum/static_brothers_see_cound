/*
  This opcode accepts a MIDI velocity value (0 - 127) and returns
  an amplitude value scaled to 0dbs minus a head room value
  expressed in db.

  The second argument affects the curve. Use 1 for a linear result.
  Use a number below 1 for a slow start and fast finish curve (droop).
  Use a number above one for a fast start and slow finish curve (hump).
*/

giHeadRoomInDb = 10

opcode velocityToAmplitude, i, ip
  iNoteVelocity, iCurveDegree xin

  iScaleValue = 0dbfs - ampdb(giHeadRoomInDb)

  iScaledVelocity velocityCurve iNoteVelocity, iCurveDegree

  iAmplitude = iScaledVelocity/127 * iScaleValue

  xout iAmplitude
endop
