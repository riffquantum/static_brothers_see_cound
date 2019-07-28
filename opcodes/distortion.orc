;;Based on an example written by Hans Mikelson -- http://www.csounds.com/mikelson/#multifx
opcode distortion, a, akkkk
  aDistortionIn, kPreGain, kPostGain, kDutyCycleOffset, kSlopeOffset xin
  aDistortedSignal    init    0


  aOld = aDistortedSignal

  aDistortedSignal = kPreGain*aDistortionIn/20000     ; Normalize the signal

  aClip  =  (8*aDistortedSignal-4)/(1+exp(30*aDistortedSignal-15))/(1+exp(1-aDistortedSignal))+.8

  aClip = kPostGain * aClip * 30000    ; Re-amplify the signal

  atemp delayr  .1                    ; Amplitude and slope based

  aDistortionOut deltapi (2 - kDutyCycleOffset * aDistortedSignal)/1500 + kSlopeOffset * (aDistortedSignal-aOld)/300

  delayw aClip

  xout aDistortionOut
endop
