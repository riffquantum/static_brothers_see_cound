
opcode delayBuffer, a, akik
  ain, kfeedbackLevel, idelayTime, kdelayLevel xin

  aBufferOut delayr idelayTime
             delayw ain+(aBufferOut*kfeedbackLevel)

  xout (aBufferOut*kdelayLevel)
endop
