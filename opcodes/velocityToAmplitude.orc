/*
  This opcode accepts a MIDI velocity value (0 - 127) and returns
  an amplitude value scaled to 0dbs minus a head room value
  expressed in db. A value of 0db here translates to 1 amplitude
  in the opcode below. A value of -80db translates to 0 amplitude.
  20db translates to 10 amplitude. I think I might be
  misunderstanding db.

  The second argument affects
  the curve. Use 1 for a linear result. Use a number below 1 for
  a slow start and fast finish curve. Use a number above one for
  a fast start and slow finish curve.
*/

giHeadRoomInDb = 15

opcode velocityToAmplitude, i, ip
  iNoteVelocity, iCurveDegree xin

  iScaleValue = 0dbfs - ampdb(giHeadRoomInDb)

  iScaledVelocity = (iNoteVelocity/127)^(1/iCurveDegree)

  iScaleValue = iScaleValue < 0 ? 0 : iScaleValue
  iAmplitude = iScaledVelocity * iScaleValue

  xout iAmplitude
endop
