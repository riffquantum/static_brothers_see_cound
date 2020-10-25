alwayson "VocalEffectChainLowPassFilterInput"
alwayson "VocalEffectChainLowPassFilterMixerChannel"

bypassRoute "VocalEffectChainLowPassFilter", "VocalEffectChainDistortionInput", "VocalEffectChainDistortionInput"

gkVocalEffectChainLowPassFilterEqBass init 1
gkVocalEffectChainLowPassFilterEqMid init 1
gkVocalEffectChainLowPassFilterEqHigh init 1
gkVocalEffectChainLowPassFilterFader init 1
gkVocalEffectChainLowPassFilterPan init 50

gkVocalEffectChainLowPassFilterDryAmount init 0
gkVocalEffectChainLowPassFilterWetAmount init 1
gkVocalEffectChainLowPassFilterAmount init .1
giVocalEffectChainLowPassFilterMode init 5

instr VocalEffectChainLowPassFilterInput
  aVocalEffectChainLowPassFilterInL inleta "InL"
  aVocalEffectChainLowPassFilterInR inleta "InR"

  aVocalEffectChainLowPassFilterOutWetL, aVocalEffectChainLowPassFilterOutWetR, aVocalEffectChainLowPassFilterOutDryL, aVocalEffectChainLowPassFilterOutDryR bypassSwitch aVocalEffectChainLowPassFilterInL, aVocalEffectChainLowPassFilterInR, gkVocalEffectChainLowPassFilterDryAmount, gkVocalEffectChainLowPassFilterWetAmount, "VocalEffectChainLowPassFilter"

  outleta "OutWetL", aVocalEffectChainLowPassFilterOutWetL
  outleta "OutWetR", aVocalEffectChainLowPassFilterOutWetR

  outleta "OutDryL", aVocalEffectChainLowPassFilterOutDryL
  outleta "OutDryR", aVocalEffectChainLowPassFilterOutDryR
endin

instr VocalEffectChainLowPassFilter
  aVocalEffectChainLowPassFilterInL inleta "InL"
  aVocalEffectChainLowPassFilterInR inleta "InR"
  iBalanceSignal = 1
  kHalfPowerPoint = 1000
  kHalfPowerPointOscilator oscil kHalfPowerPoint/2, .5
  kHalfPowerPointValue = kHalfPowerPoint/2 + kHalfPowerPointOscilator + 100
  kQ = 1

  /* ********
      tone
     ********
  */
  if giVocalEffectChainLowPassFilterMode == 1 then
    aVocalEffectChainLowPassFilterOutL tone aVocalEffectChainLowPassFilterInL, kHalfPowerPointValue
    aVocalEffectChainLowPassFilterOutR tone aVocalEffectChainLowPassFilterInR, kHalfPowerPointValue
  endif

  /* ********
      butterlp
     ********
  */
  if giVocalEffectChainLowPassFilterMode == 2 then
    aVocalEffectChainLowPassFilterOutL butterlp aVocalEffectChainLowPassFilterInL, kHalfPowerPointValue
    aVocalEffectChainLowPassFilterOutR butterlp aVocalEffectChainLowPassFilterInR, kHalfPowerPointValue
  endif

  /* ********
      bqrez
     ********
  */
  if giVocalEffectChainLowPassFilterMode == 3 then
    aVocalEffectChainLowPassFilterOutL bqrez aVocalEffectChainLowPassFilterInL, kHalfPowerPointValue, 1
    aVocalEffectChainLowPassFilterOutR bqrez aVocalEffectChainLowPassFilterInR, kHalfPowerPointValue, 1
  endif

  /* ********
      lowpass2
     ********
  */
  if giVocalEffectChainLowPassFilterMode == 4 then
    aVocalEffectChainLowPassFilterOutL lowpass2 aVocalEffectChainLowPassFilterInL, kHalfPowerPointValue, kQ
    aVocalEffectChainLowPassFilterOutR lowpass2 aVocalEffectChainLowPassFilterInR, kHalfPowerPointValue, kQ
  endif

  /* ********
      clfilt
     ********
  */
  if giVocalEffectChainLowPassFilterMode == 5 then
    kCornerFrequency = kHalfPowerPointValue
    iLowPassOrHighPass = 0 ; 0 or 1
    iNumberOfPoles = 4 ; The number of poles in the filter. It must be an even number from 2 to 80.
    iFilterType = 0 ; 0 for Butterworth, 1 for Chebyshev Type I, 2 for Chebyshev Type II, 3 for Elliptical. Vocals to 0 (Butterworth)
    iPassBandRipple = 1 ; The pass-band ripple in dB. Must be greater than 0. It is ignored by Butterworth and Chebyshev Type II. The Vocal is 1 dB.
    iStopBandAttentuation = -60 ; The stop-band attenuation in dB. Must be less than 0. It is ignored by Butterworth and Chebyshev Type I. The Vocal is -60 dB.
    iSkip = 0

    aVocalEffectChainLowPassFilterOutL clfilt aVocalEffectChainLowPassFilterInL, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
    aVocalEffectChainLowPassFilterOutR clfilt aVocalEffectChainLowPassFilterInR, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
  endif

  aVocalEffectChainLowPassFilterOutL = (aVocalEffectChainLowPassFilterOutL * gkVocalEffectChainLowPassFilterAmount) + (1 - gkVocalEffectChainLowPassFilterAmount) * aVocalEffectChainLowPassFilterInL

  if iBalanceSignal == 1 then
    aVocalEffectChainLowPassFilterOutL balance aVocalEffectChainLowPassFilterOutL, aVocalEffectChainLowPassFilterInL
    aVocalEffectChainLowPassFilterOutR balance aVocalEffectChainLowPassFilterOutR, aVocalEffectChainLowPassFilterInR
  endif

  outleta "OutL", aVocalEffectChainLowPassFilterOutL
  outleta "OutR", aVocalEffectChainLowPassFilterOutR
endin

instr VocalEffectChainLowPassFilterAmountKnob
  gkVocalEffectChainLowPassFilterAmount linseg p4, p3, p5
endin

instr VocalEffectChainLowPassFilterBassKnob
  gkVocalEffectChainLowPassFilterEqBass linseg p4, p3, p5
endin

instr VocalEffectChainLowPassFilterMidKnob
  gkVocalEffectChainLowPassFilterEqMid linseg p4, p3, p5
endin

instr VocalEffectChainLowPassFilterHighKnob
  gkVocalEffectChainLowPassFilterEqHigh linseg p4, p3, p5
endin

instr VocalEffectChainLowPassFilterFader
  gkVocalEffectChainLowPassFilterFader linseg p4, p3, p5
endin

instr VocalEffectChainLowPassFilterPan
  gkVocalEffectChainLowPassFilterPan linseg p4, p3, p5
endin

instr VocalEffectChainLowPassFilterMixerChannel
  aVocalEffectChainLowPassFilterL inleta "InL"
  aVocalEffectChainLowPassFilterR inleta "InR"

  aVocalEffectChainLowPassFilterL, aVocalEffectChainLowPassFilterR mixerChannel aVocalEffectChainLowPassFilterL, aVocalEffectChainLowPassFilterR, gkVocalEffectChainLowPassFilterFader, gkVocalEffectChainLowPassFilterPan, gkVocalEffectChainLowPassFilterEqBass, gkVocalEffectChainLowPassFilterEqMid, gkVocalEffectChainLowPassFilterEqHigh

  outleta "OutL", aVocalEffectChainLowPassFilterL
  outleta "OutR", aVocalEffectChainLowPassFilterR
endin
