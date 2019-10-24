;;Based on an example written by Hans Mikelson -- http://www.csounds.com/mikelson/#multifx
opcode distortion, a, akkkk
  aDistortionIn, kPreGain, kPostGain, kDutyCycleOffset, kSlopeOffset xin
  aDistortedSignal init 0
  iDefault0dbfs = 32767

  iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48

  iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

  aOld = aDistortedSignal

  aDistortedSignal = kPreGain*aDistortionIn/((60000/iDefault0dbfs)*0dbfs)     ; Normalize the signal

  aClip tablei aDistortedSignal, iTableLight, 1, .5 ; Read the waveshaping table

  aClip = kPostGain * aClip * ((15000/iDefault0dbfs)*0dbfs)    ; Re-amplify the signal

  atemp delayr  .1                    ; Amplitude and slope based

  aDistortionOut deltapi (2 - kDutyCycleOffset * aDistortedSignal)/(iDefault0dbfs/1500) + kSlopeOffset * (aDistortedSignal-aOld)/300

  delayw aClip

  xout aDistortionOut
endop
