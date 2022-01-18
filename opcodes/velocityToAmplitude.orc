opcode velocityToAmplitude, i, ip
  iNoteVelocity, iCurveDegree xin

  iScaledVelocity velocityCurve iNoteVelocity, iCurveDegree
  iVelocityRatio = iScaledVelocity/127
  iHeadRoom = 0dbfs * 3/4

  iAmplitude = (0dbfs - iHeadRoom) * iVelocityRatio

  xout iAmplitude
endop
