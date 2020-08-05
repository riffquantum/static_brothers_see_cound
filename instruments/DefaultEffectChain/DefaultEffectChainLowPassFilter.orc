alwayson "DefaultEffectChainLowPassFilterInput"
alwayson "DefaultEffectChainLowPassFilterMixerChannel"

bypassRoute "DefaultEffectChainLowPassFilter", "DefaultEffectChainDistortionInput", "DefaultEffectChainDistortionInput"

gkDefaultEffectChainLowPassFilterEqBass init 1
gkDefaultEffectChainLowPassFilterEqMid init 1
gkDefaultEffectChainLowPassFilterEqHigh init 1
gkDefaultEffectChainLowPassFilterFader init 1
gkDefaultEffectChainLowPassFilterPan init 50

gkDefaultEffectChainLowPassFilterDryAmmount init 0
gkDefaultEffectChainLowPassFilterWetAmmount init 1
gkDefaultEffectChainLowPassFilterAmount init .1
giDefaultEffectChainLowPassFilterMode init 5

instr DefaultEffectChainLowPassFilterInput
  aDefaultEffectChainLowPassFilterInL inleta "InL"
  aDefaultEffectChainLowPassFilterInR inleta "InR"

  aDefaultEffectChainLowPassFilterOutWetL, aDefaultEffectChainLowPassFilterOutWetR, aDefaultEffectChainLowPassFilterOutDryL, aDefaultEffectChainLowPassFilterOutDryR bypassSwitch aDefaultEffectChainLowPassFilterInL, aDefaultEffectChainLowPassFilterInR, gkDefaultEffectChainLowPassFilterDryAmmount, gkDefaultEffectChainLowPassFilterWetAmmount, "DefaultEffectChainLowPassFilter"

  outleta "OutWetL", aDefaultEffectChainLowPassFilterOutWetL
  outleta "OutWetR", aDefaultEffectChainLowPassFilterOutWetR

  outleta "OutDryL", aDefaultEffectChainLowPassFilterOutDryL
  outleta "OutDryR", aDefaultEffectChainLowPassFilterOutDryR
endin

instr DefaultEffectChainLowPassFilter
  aDefaultEffectChainLowPassFilterInL inleta "InL"
  aDefaultEffectChainLowPassFilterInR inleta "InR"
  iBalanceSignal = 1
  kHalfPowerPoint = 1000
  kHalfPowerPointOscilator oscil kHalfPowerPoint/2, .5
  kHalfPowerPointValue = kHalfPowerPoint/2 + kHalfPowerPointOscilator + 100
  kQ = 1

  /* ********
      tone
     ********
  */
  if giDefaultEffectChainLowPassFilterMode == 1 then
    aDefaultEffectChainLowPassFilterOutL tone aDefaultEffectChainLowPassFilterInL, kHalfPowerPointValue
    aDefaultEffectChainLowPassFilterOutR tone aDefaultEffectChainLowPassFilterInR, kHalfPowerPointValue
  endif

  /* ********
      butterlp
     ********
  */
  if giDefaultEffectChainLowPassFilterMode == 2 then
    aDefaultEffectChainLowPassFilterOutL butterlp aDefaultEffectChainLowPassFilterInL, kHalfPowerPointValue
    aDefaultEffectChainLowPassFilterOutR butterlp aDefaultEffectChainLowPassFilterInR, kHalfPowerPointValue
  endif

  /* ********
      bqrez
     ********
  */
  if giDefaultEffectChainLowPassFilterMode == 3 then
    aDefaultEffectChainLowPassFilterOutL bqrez aDefaultEffectChainLowPassFilterInL, kHalfPowerPointValue, 1
    aDefaultEffectChainLowPassFilterOutR bqrez aDefaultEffectChainLowPassFilterInR, kHalfPowerPointValue, 1
  endif

  /* ********
      lowpass2
     ********
  */
  if giDefaultEffectChainLowPassFilterMode == 4 then
    aDefaultEffectChainLowPassFilterOutL lowpass2 aDefaultEffectChainLowPassFilterInL, kHalfPowerPointValue, kQ
    aDefaultEffectChainLowPassFilterOutR lowpass2 aDefaultEffectChainLowPassFilterInR, kHalfPowerPointValue, kQ
  endif

  /* ********
      clfilt
     ********
  */
  if giDefaultEffectChainLowPassFilterMode == 5 then
    kCornerFrequency = kHalfPowerPointValue
    iLowPassOrHighPass = 0 ; 0 or 1
    iNumberOfPoles = 4 ; The number of poles in the filter. It must be an even number from 2 to 80.
    iFilterType = 0 ; 0 for Butterworth, 1 for Chebyshev Type I, 2 for Chebyshev Type II, 3 for Elliptical. Defaults to 0 (Butterworth)
    iPassBandRipple = 1 ; The pass-band ripple in dB. Must be greater than 0. It is ignored by Butterworth and Chebyshev Type II. The default is 1 dB.
    iStopBandAttentuation = -60 ; The stop-band attenuation in dB. Must be less than 0. It is ignored by Butterworth and Chebyshev Type I. The default is -60 dB.
    iSkip = 0

    aDefaultEffectChainLowPassFilterOutL clfilt aDefaultEffectChainLowPassFilterInL, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
    aDefaultEffectChainLowPassFilterOutR clfilt aDefaultEffectChainLowPassFilterInR, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
  endif

  aDefaultEffectChainLowPassFilterOutL = (aDefaultEffectChainLowPassFilterOutL * gkDefaultEffectChainLowPassFilterAmount) + (1 - gkDefaultEffectChainLowPassFilterAmount) * aDefaultEffectChainLowPassFilterInL

  if iBalanceSignal == 1 then
    aDefaultEffectChainLowPassFilterOutL balance aDefaultEffectChainLowPassFilterOutL, aDefaultEffectChainLowPassFilterInL
    aDefaultEffectChainLowPassFilterOutR balance aDefaultEffectChainLowPassFilterOutR, aDefaultEffectChainLowPassFilterInR
  endif

  outleta "OutL", aDefaultEffectChainLowPassFilterOutL
  outleta "OutR", aDefaultEffectChainLowPassFilterOutR
endin

instr DefaultEffectChainLowPassFilterAmountKnob
  gkDefaultEffectChainLowPassFilterAmount linseg p4, p3, p5
endin

instr DefaultEffectChainLowPassFilterBassKnob
  gkDefaultEffectChainLowPassFilterEqBass linseg p4, p3, p5
endin

instr DefaultEffectChainLowPassFilterMidKnob
  gkDefaultEffectChainLowPassFilterEqMid linseg p4, p3, p5
endin

instr DefaultEffectChainLowPassFilterHighKnob
  gkDefaultEffectChainLowPassFilterEqHigh linseg p4, p3, p5
endin

instr DefaultEffectChainLowPassFilterFader
  gkDefaultEffectChainLowPassFilterFader linseg p4, p3, p5
endin

instr DefaultEffectChainLowPassFilterPan
  gkDefaultEffectChainLowPassFilterPan linseg p4, p3, p5
endin

instr DefaultEffectChainLowPassFilterMixerChannel
  aDefaultEffectChainLowPassFilterL inleta "InL"
  aDefaultEffectChainLowPassFilterR inleta "InR"

  aDefaultEffectChainLowPassFilterL, aDefaultEffectChainLowPassFilterR mixerChannel aDefaultEffectChainLowPassFilterL, aDefaultEffectChainLowPassFilterR, gkDefaultEffectChainLowPassFilterFader, gkDefaultEffectChainLowPassFilterPan, gkDefaultEffectChainLowPassFilterEqBass, gkDefaultEffectChainLowPassFilterEqMid, gkDefaultEffectChainLowPassFilterEqHigh

  outleta "OutL", aDefaultEffectChainLowPassFilterL
  outleta "OutR", aDefaultEffectChainLowPassFilterR
endin
