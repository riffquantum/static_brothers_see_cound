instr FilterSweep
; CutoffFrequency - k - filter cutoff frequency (i-, k-, or a-rate).
; Saturation - k - saturation amount to use for non-linear processing. Values > 1 increase the steepness of the NLP curve.
; NonLinearProcessingMethod - i - 0 = no processing, 1 = non-linear processing. Method 1 uses tanh(ksaturation * input). Enabling NLP may increase the overall output of filter above unity and should be compensated for outside of the filter.
; Q - k - filter Q value (i-, k-, or a-rate). Range 1.0-10.0 (clamped by opcode). Self-oscillation occurs at 10.0.

  giGlobalFxLowPassFilterMode = 5
  gkGlobalFxLowPassFilterHalfPowerPoint = oscil(200, .2) + 1000
  gkGlobalFxLowPassFilterAmount = linseg(0, p3/2, .5, p3/2, 0)
  ; _ "GlobalFxK35Lpf", 0, secondsToBeats(p3), 20, 1
  _ "GlobalFxLowPassFilter", 0, secondsToBeats(p3)
endin
