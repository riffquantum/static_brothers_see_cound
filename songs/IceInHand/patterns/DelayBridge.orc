instr DelayBridge
  giIcemanLoopDelayRelease = 6
  gkIcemanLoopDelayLevel = linseg(0, p3/4, 1)
  gaIcemanLoopDelayTime = linseg(.5, p3, 1.5) + oscil(.04, .2)
  gkIcemanLoopDelayFeedbackAmount = linseg(.8, p3/4, 1, p3/2, 1.2)
  _ "IcemanLoopDelay", 0, secondsToBeats(p3)

  _ "IcemanLoop", 6, secondsToBeats(p3) - 6, 120, 3/7, 4
  _ "Stab", 4, .5, 40, 2.08
  _ "Stab", 10.5, .5, 40, 1.08
endin
