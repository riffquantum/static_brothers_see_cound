alwayson "DrumKitLPFInput"
alwayson "DrumKitLPFMixerChannel"

bypassRoute "DrumKitLPF", "DrumKitReverbInput", "DrumKitReverbInput"

gkDrumKitLPFEqBass init 1
gkDrumKitLPFEqMid init 1
gkDrumKitLPFEqHigh init 1
gkDrumKitLPFFader init 1
gkDrumKitLPFPan init 50

gkDrumKitLPFDryAmount init 0
gkDrumKitLPFWetAmount init 1
gkDrumKitLPFAmount init 1
giDrumKitLPFMode init 3

gkDrumKitLPFHalfPowerPoint init 1000
gkDrumKitLPFQ init 1

instr DrumKitLPFInput
  aDrumKitLPFInL inleta "InL"
  aDrumKitLPFInR inleta "InR"

  aDrumKitLPFOutWetL, aDrumKitLPFOutWetR, aDrumKitLPFOutDryL, aDrumKitLPFOutDryR bypassSwitch aDrumKitLPFInL, aDrumKitLPFInR, gkDrumKitLPFDryAmount, gkDrumKitLPFWetAmount, "DrumKitLPF"

  outleta "OutWetL", aDrumKitLPFOutWetL
  outleta "OutWetR", aDrumKitLPFOutWetR

  outleta "OutDryL", aDrumKitLPFOutDryL
  outleta "OutDryR", aDrumKitLPFOutDryR
endin

instr DrumKitLPF
  aDrumKitLPFInL inleta "InL"
  aDrumKitLPFInR inleta "InR"
  iBalanceSignal = 1
  kHalfPowerPointValue = gkDrumKitLPFHalfPowerPoint
  ; kHalfPowerPointOscilator oscil kHalfPowerPoint/2, .5
  ; kHalfPowerPointValue = kHalfPowerPoint/2 + kHalfPowerPointOscilator + 100
  kQ = gkDrumKitLPFQ

  /* ********
      tone
     ********
  */
  if giDrumKitLPFMode == 1 then
    aDrumKitLPFOutL tone aDrumKitLPFInL, kHalfPowerPointValue
    aDrumKitLPFOutR tone aDrumKitLPFInR, kHalfPowerPointValue
  endif

  /* ********
      butterlp
     ********
  */
  if giDrumKitLPFMode == 2 then
    aDrumKitLPFOutL butterlp aDrumKitLPFInL, kHalfPowerPointValue
    aDrumKitLPFOutR butterlp aDrumKitLPFInR, kHalfPowerPointValue
  endif

  /* ********
      bqrez
     ********
  */
  if giDrumKitLPFMode == 3 then
    aDrumKitLPFOutL bqrez aDrumKitLPFInL, kHalfPowerPointValue, 1
    aDrumKitLPFOutR bqrez aDrumKitLPFInR, kHalfPowerPointValue, 1
  endif

  /* ********
      lowpass2
     ********
  */
  if giDrumKitLPFMode == 4 then
    aDrumKitLPFOutL lowpass2 aDrumKitLPFInL, kHalfPowerPointValue, kQ
    aDrumKitLPFOutR lowpass2 aDrumKitLPFInR, kHalfPowerPointValue, kQ
  endif

  /* ********
      clfilt
     ********
  */
  if giDrumKitLPFMode == 5 then
    kCornerFrequency = kHalfPowerPointValue
    iLowPassOrHighPass = 0 ; 0 or 1
    iNumberOfPoles = 4 ; The number of poles in the filter. It must be an even number from 2 to 80.
    iFilterType = 0 ; 0 for Butterworth, 1 for Chebyshev Type I, 2 for Chebyshev Type II, 3 for Elliptical. Defaults to 0 (Butterworth)
    iPassBandRipple = 1 ; The pass-band ripple in dB. Must be greater than 0. It is ignored by Butterworth and Chebyshev Type II. The default is 1 dB.
    iStopBandAttentuation = -60 ; The stop-band attenuation in dB. Must be less than 0. It is ignored by Butterworth and Chebyshev Type I. The default is -60 dB.
    iSkip = 0

    aDrumKitLPFOutL clfilt aDrumKitLPFInL, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
    aDrumKitLPFOutR clfilt aDrumKitLPFInR, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
  endif

  aDrumKitLPFOutL = (aDrumKitLPFOutL * gkDrumKitLPFAmount) + (1 - gkDrumKitLPFAmount) * aDrumKitLPFInL

  aDrumKitLPFOutR = (aDrumKitLPFOutR * gkDrumKitLPFAmount) + (1 - gkDrumKitLPFAmount) * aDrumKitLPFInR

  if iBalanceSignal == 1 then
    aDrumKitLPFOutL balance aDrumKitLPFOutL, aDrumKitLPFInL
    aDrumKitLPFOutR balance aDrumKitLPFOutR, aDrumKitLPFInR
  endif

  outleta "OutL", aDrumKitLPFOutL
  outleta "OutR", aDrumKitLPFOutR
endin

instr DrumKitLPFAmountKnob
  gkDrumKitLPFAmount linseg p4, p3, p5
endin

instr DrumKitLPFBassKnob
  gkDrumKitLPFEqBass linseg p4, p3, p5
endin

instr DrumKitLPFMidKnob
  gkDrumKitLPFEqMid linseg p4, p3, p5
endin

instr DrumKitLPFHighKnob
  gkDrumKitLPFEqHigh linseg p4, p3, p5
endin

instr DrumKitLPFFader
  gkDrumKitLPFFader linseg p4, p3, p5
endin

instr DrumKitLPFPan
  gkDrumKitLPFPan linseg p4, p3, p5
endin

instr DrumKitLPFMixerChannel
  aDrumKitLPFL inleta "InL"
  aDrumKitLPFR inleta "InR"

  aDrumKitLPFL, aDrumKitLPFR mixerChannel aDrumKitLPFL, aDrumKitLPFR, gkDrumKitLPFFader, gkDrumKitLPFPan, gkDrumKitLPFEqBass, gkDrumKitLPFEqMid, gkDrumKitLPFEqHigh

  outleta "OutL", aDrumKitLPFL
  outleta "OutR", aDrumKitLPFR
endin
