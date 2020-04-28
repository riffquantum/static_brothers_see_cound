opcode delayBuffer, a, akiak
  aInput, kFeedbackLevel, iDelayBufferLength, aDelayTime, kDelayLevel xin

  aDelayTime limit aDelayTime, ksmps/sr, iDelayBufferLength

  aDelayBufferOut delayr iDelayBufferLength
  aDelayOut       deltapi aDelayTime
                  delayw aInput+(aDelayOut*kFeedbackLevel)

  xout (aDelayOut*kDelayLevel)
endop
