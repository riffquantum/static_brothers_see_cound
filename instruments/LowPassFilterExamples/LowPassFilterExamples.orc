alwayson "LowPassFilterExamples"
alwayson "LowPassFilterExamplesMixerChannel"

gSLowPassFilterExamplesName = "LowPassFilterExamples"
gSLowPassFilterExamplesRoute = "Mixer"
instrumentRoute gSLowPassFilterExamplesName, gSLowPassFilterExamplesRoute

gkLowPassFilterExamplesEqBass init 1
gkLowPassFilterExamplesEqMid init 1
gkLowPassFilterExamplesEqHigh init 1
gkLowPassFilterExamplesFader init 1
gkLowPassFilterExamplesPan init 50

gkLowPassFilterExamplesAmount init .1

giLowPassFilterExamplesMode init 5

instr LowPassFilterExamples
  aLowPassFilterExamplesInL inleta "LowPassFilterExamplesInL"
  aLowPassFilterExamplesInR inleta "LowPassFilterExamplesInR"
  iBalanceSignal = 1
  kHalfPowerPoint = 1000
  kHalfPowerPointOscilator oscil kHalfPowerPoint/2, .5
  kHalfPowerPointValue = kHalfPowerPoint/2 + kHalfPowerPointOscilator + 100
  kQ = 1

  /* ********
      tone
     ********
  */
  if giLowPassFilterExamplesMode == 1 then
    aLowPassFilterExamplesOutL tone aLowPassFilterExamplesInL, kHalfPowerPointValue
    aLowPassFilterExamplesOutR tone aLowPassFilterExamplesInR, kHalfPowerPointValue
  endif

  /* ********
      butterlp
     ********
  */
  if giLowPassFilterExamplesMode == 2 then
    aLowPassFilterExamplesOutL butterlp aLowPassFilterExamplesInL, kHalfPowerPointValue
    aLowPassFilterExamplesOutR butterlp aLowPassFilterExamplesInR, kHalfPowerPointValue
  endif

  /* ********
      bqrez
     ********
  */
  if giLowPassFilterExamplesMode == 3 then
    aLowPassFilterExamplesOutL bqrez aLowPassFilterExamplesInL, kHalfPowerPointValue, 1
    aLowPassFilterExamplesOutR bqrez aLowPassFilterExamplesInR, kHalfPowerPointValue, 1
  endif

  /* ********
      lowpass2
     ********
  */
  if giLowPassFilterExamplesMode == 4 then
    aLowPassFilterExamplesOutL lowpass2 aLowPassFilterExamplesInL, kHalfPowerPointValue, kQ
    aLowPassFilterExamplesOutR lowpass2 aLowPassFilterExamplesInR, kHalfPowerPointValue, kQ
  endif

  /* ********
      clfilt
     ********
  */
  if giLowPassFilterExamplesMode == 5 then
    kCornerFrequency = kHalfPowerPointValue
    iLowPassOrHighPass = 0 ; 0 or 1
    iNumberOfPoles = 4 ; The number of poles in the filter. It must be an even number from 2 to 80.
    iFilterType = 0 ; 0 for Butterworth, 1 for Chebyshev Type I, 2 for Chebyshev Type II, 3 for Elliptical. Defaults to 0 (Butterworth)
    iPassBandRipple = 1 ; The pass-band ripple in dB. Must be greater than 0. It is ignored by Butterworth and Chebyshev Type II. The default is 1 dB.
    iStopBandAttentuation = -60 ; The stop-band attenuation in dB. Must be less than 0. It is ignored by Butterworth and Chebyshev Type I. The default is -60 dB.
    iSkip = 0

    aLowPassFilterExamplesOutL clfilt aLowPassFilterExamplesInL, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
    aLowPassFilterExamplesOutR clfilt aLowPassFilterExamplesInR, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
  endif

  aLowPassFilterExamplesOutL = (aLowPassFilterExamplesOutL * gkLowPassFilterExamplesAmount) + (1 - gkLowPassFilterExamplesAmount) * aLowPassFilterExamplesInL

  if iBalanceSignal == 1 then
    aLowPassFilterExamplesOutL balance aLowPassFilterExamplesOutL, aLowPassFilterExamplesInL
    aLowPassFilterExamplesOutR balance aLowPassFilterExamplesOutR, aLowPassFilterExamplesInR
  endif

  outleta "LowPassFilterExamplesOutL", aLowPassFilterExamplesOutL
  outleta "LowPassFilterExamplesOutR", aLowPassFilterExamplesOutR
endin

instr LowPassFilterExamplesAmountKnob
    gkLowPassFilterExamplesAmount linseg p4, p3, p5
endin

instr LowPassFilterExamplesBassKnob
    gkLowPassFilterExamplesEqBass linseg p4, p3, p5
endin

instr LowPassFilterExamplesMidKnob
    gkLowPassFilterExamplesEqMid linseg p4, p3, p5
endin

instr LowPassFilterExamplesHighKnob
    gkLowPassFilterExamplesEqHigh linseg p4, p3, p5
endin

instr LowPassFilterExamplesFader
    gkLowPassFilterExamplesFader linseg p4, p3, p5
endin

instr LowPassFilterExamplesPan
    gkLowPassFilterExamplesPan linseg p4, p3, p5
endin

instr LowPassFilterExamplesMixerChannel
    aLowPassFilterExamplesL inleta "LowPassFilterExamplesInL"
    aLowPassFilterExamplesR inleta "LowPassFilterExamplesInR"

    kLowPassFilterExamplesFader = gkLowPassFilterExamplesFader
    kLowPassFilterExamplesPan = gkLowPassFilterExamplesPan
    kLowPassFilterExamplesEqBass = gkLowPassFilterExamplesEqBass
    kLowPassFilterExamplesEqMid = gkLowPassFilterExamplesEqMid
    kLowPassFilterExamplesEqHigh = gkLowPassFilterExamplesEqHigh

    aLowPassFilterExamplesL, aLowPassFilterExamplesR threeBandEqStereo aLowPassFilterExamplesL, aLowPassFilterExamplesR, kLowPassFilterExamplesEqBass, kLowPassFilterExamplesEqMid, kLowPassFilterExamplesEqHigh

    if kLowPassFilterExamplesPan > 100 then
        kLowPassFilterExamplesPan = 100
    elseif kLowPassFilterExamplesPan < 0 then
        kLowPassFilterExamplesPan = 0
    endif

    aLowPassFilterExamplesL = (aLowPassFilterExamplesL * ((100 - kLowPassFilterExamplesPan) * 2 / 100)) * kLowPassFilterExamplesFader
    aLowPassFilterExamplesR = (aLowPassFilterExamplesR * (kLowPassFilterExamplesPan * 2 / 100)) * kLowPassFilterExamplesFader

    outleta "LowPassFilterExamplesOutL", aLowPassFilterExamplesL
    outleta "LowPassFilterExamplesOutR", aLowPassFilterExamplesR
endin
