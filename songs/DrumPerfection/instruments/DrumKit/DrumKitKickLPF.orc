alwayson "DrumKitKickLPFInput"
alwayson "DrumKitKickLPFMixerChannel"

bypassRoute "DrumKitKickLPF", "DrumKitBus", "DrumKitBus"

gkDrumKitKickLPFEqBass init 1
gkDrumKitKickLPFEqMid init 1
gkDrumKitKickLPFEqHigh init 1
gkDrumKitKickLPFFader init 1
gkDrumKitKickLPFPan init 50

gkDrumKitKickLPFDryAmount init 0
gkDrumKitKickLPFWetAmount init 1
gkDrumKitKickLPFAmount init 1
giDrumKitKickLPFMode init 3

gkDrumKitKickLPFHalfPowerPoint init 1000
gkDrumKitKickLPFQ init 1

instr DrumKitKickLPFInput
  aDrumKitKickLPFInL inleta "InL"
  aDrumKitKickLPFInR inleta "InR"

  aDrumKitKickLPFOutWetL, aDrumKitKickLPFOutWetR, aDrumKitKickLPFOutDryL, aDrumKitKickLPFOutDryR bypassSwitch aDrumKitKickLPFInL, aDrumKitKickLPFInR, gkDrumKitKickLPFDryAmount, gkDrumKitKickLPFWetAmount, "DrumKitKickLPF"

  outleta "OutWetL", aDrumKitKickLPFOutWetL
  outleta "OutWetR", aDrumKitKickLPFOutWetR

  outleta "OutDryL", aDrumKitKickLPFOutDryL
  outleta "OutDryR", aDrumKitKickLPFOutDryR
endin

instr DrumKitKickLPF
  aDrumKitKickLPFInL inleta "InL"
  aDrumKitKickLPFInR inleta "InR"
  iBalanceSignal = 1
  kHalfPowerPointValue = gkDrumKitKickLPFHalfPowerPoint
  ; kHalfPowerPointOscilator oscil kHalfPowerPoint/2, .5
  ; kHalfPowerPointValue = kHalfPowerPoint/2 + kHalfPowerPointOscilator + 100
  kQ = gkDrumKitKickLPFQ

  /* ********
      tone
     ********
  */
  if giDrumKitKickLPFMode == 1 then
    aDrumKitKickLPFOutL tone aDrumKitKickLPFInL, kHalfPowerPointValue
    aDrumKitKickLPFOutR tone aDrumKitKickLPFInR, kHalfPowerPointValue
  endif

  /* ********
      butterlp
     ********
  */
  if giDrumKitKickLPFMode == 2 then
    aDrumKitKickLPFOutL butterlp aDrumKitKickLPFInL, kHalfPowerPointValue
    aDrumKitKickLPFOutR butterlp aDrumKitKickLPFInR, kHalfPowerPointValue
  endif

  /* ********
      bqrez
     ********
  */
  if giDrumKitKickLPFMode == 3 then
    aDrumKitKickLPFOutL bqrez aDrumKitKickLPFInL, kHalfPowerPointValue, 1
    aDrumKitKickLPFOutR bqrez aDrumKitKickLPFInR, kHalfPowerPointValue, 1
  endif

  /* ********
      lowpass2
     ********
  */
  if giDrumKitKickLPFMode == 4 then
    aDrumKitKickLPFOutL lowpass2 aDrumKitKickLPFInL, kHalfPowerPointValue, kQ
    aDrumKitKickLPFOutR lowpass2 aDrumKitKickLPFInR, kHalfPowerPointValue, kQ
  endif

  /* ********
      clfilt
     ********
  */
  if giDrumKitKickLPFMode == 5 then
    kCornerFrequency = kHalfPowerPointValue
    iLowPassOrHighPass = 0 ; 0 or 1
    iNumberOfPoles = 4 ; The number of poles in the filter. It must be an even number from 2 to 80.
    iFilterType = 0 ; 0 for Butterworth, 1 for Chebyshev Type I, 2 for Chebyshev Type II, 3 for Elliptical. Defaults to 0 (Butterworth)
    iPassBandRipple = 1 ; The pass-band ripple in dB. Must be greater than 0. It is ignored by Butterworth and Chebyshev Type II. The default is 1 dB.
    iStopBandAttentuation = -60 ; The stop-band attenuation in dB. Must be less than 0. It is ignored by Butterworth and Chebyshev Type I. The default is -60 dB.
    iSkip = 0

    aDrumKitKickLPFOutL clfilt aDrumKitKickLPFInL, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
    aDrumKitKickLPFOutR clfilt aDrumKitKickLPFInR, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
  endif

  aDrumKitKickLPFOutL = (aDrumKitKickLPFOutL * gkDrumKitKickLPFAmount) + (1 - gkDrumKitKickLPFAmount) * aDrumKitKickLPFInL

  aDrumKitKickLPFOutR = (aDrumKitKickLPFOutR * gkDrumKitKickLPFAmount) + (1 - gkDrumKitKickLPFAmount) * aDrumKitKickLPFInR

  if iBalanceSignal == 1 then
    aDrumKitKickLPFOutL balance aDrumKitKickLPFOutL, aDrumKitKickLPFInL
    aDrumKitKickLPFOutR balance aDrumKitKickLPFOutR, aDrumKitKickLPFInR
  endif

  outleta "OutL", aDrumKitKickLPFOutL
  outleta "OutR", aDrumKitKickLPFOutR
endin

instr DrumKitKickLPFAmountKnob
  gkDrumKitKickLPFAmount linseg p4, p3, p5
endin

instr DrumKitKickLPFBassKnob
  gkDrumKitKickLPFEqBass linseg p4, p3, p5
endin

instr DrumKitKickLPFMidKnob
  gkDrumKitKickLPFEqMid linseg p4, p3, p5
endin

instr DrumKitKickLPFHighKnob
  gkDrumKitKickLPFEqHigh linseg p4, p3, p5
endin

instr DrumKitKickLPFFader
  gkDrumKitKickLPFFader linseg p4, p3, p5
endin

instr DrumKitKickLPFPan
  gkDrumKitKickLPFPan linseg p4, p3, p5
endin

instr DrumKitKickLPFMixerChannel
  aDrumKitKickLPFL inleta "InL"
  aDrumKitKickLPFR inleta "InR"

  aDrumKitKickLPFL, aDrumKitKickLPFR mixerChannel aDrumKitKickLPFL, aDrumKitKickLPFR, gkDrumKitKickLPFFader, gkDrumKitKickLPFPan, gkDrumKitKickLPFEqBass, gkDrumKitKickLPFEqMid, gkDrumKitKickLPFEqHigh

  outleta "OutL", aDrumKitKickLPFL
  outleta "OutR", aDrumKitKickLPFR
endin
