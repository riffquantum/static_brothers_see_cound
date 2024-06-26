/*
  LOW_PASS_FILTER
  Creates an effect instrument that applies a low pass filter to a signal. This isn't great and was really
  just for trying out different LPF opcodes to see the differences.

  Global Variables:
    PreGain - k - Gain applied before clipping.
    PostGain - k - Gain applied after clipping.
    DutyCycleOffset - k - Used in some clipping opcodes.
    SlopeOffset - k - Used in some clipping opcodes.
    Mode - i - 1-5, Selects from 5 different clipping opcodes: clip,
      distort, distort1, pdhalf, and hasnDistortion.

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define LOW_PASS_FILTER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.Amount init .5
  gi$INSTRUMENT_NAME.Mode init 5
  gk$INSTRUMENT_NAME.HalfPowerPoint init 1000
  gk$INSTRUMENT_NAME.Q init 1
  gk$INSTRUMENT_NAME.Resonance init 1

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iBalanceSignal = 1

    /* ********
        tone
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 1 then
      aSignalOutL tone aSignalInL, gk$INSTRUMENT_NAME.HalfPowerPoint
      aSignalOutR tone aSignalInR, gk$INSTRUMENT_NAME.HalfPowerPoint
    endif

    /* ********
        butterlp
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 2 then
      aSignalOutL butterlp aSignalInL, gk$INSTRUMENT_NAME.HalfPowerPoint
      aSignalOutR butterlp aSignalInR, gk$INSTRUMENT_NAME.HalfPowerPoint
    endif

    /* ********
        bqrez
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 3 then
      aSignalOutL bqrez aSignalInL, gk$INSTRUMENT_NAME.HalfPowerPoint, gk$INSTRUMENT_NAME.Resonance
      aSignalOutR bqrez aSignalInR, gk$INSTRUMENT_NAME.HalfPowerPoint, gk$INSTRUMENT_NAME.Resonance
    endif

    /* ********
        lowpass2
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 4 then
      aSignalOutL lowpass2 aSignalInL, gk$INSTRUMENT_NAME.HalfPowerPoint, gk$INSTRUMENT_NAME.Q
      aSignalOutR lowpass2 aSignalInR, gk$INSTRUMENT_NAME.HalfPowerPoint, gk$INSTRUMENT_NAME.Q
    endif

    /* ********
        clfilt
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 5 then
      kCornerFrequency =  gk$INSTRUMENT_NAME.HalfPowerPoint
      iLowPassOrHighPass = 0 ; 0 or 1
      iNumberOfPoles = 4 ; The number of poles in the filter. It must be an even number from 2 to 80.
      iFilterType = 0 ; 0 for Butterworth, 1 for Chebyshev Type I, 2 for Chebyshev Type II, 3 for Elliptical. Defaults to 0 (Butterworth)
      iPassBandRipple = 1 ; The pass-band ripple in dB. Must be greater than 0. It is ignored by Butterworth and Chebyshev Type II. The default is 1 dB.
      iStopBandAttentuation = -60 ; The stop-band attenuation in dB. Must be less than 0. It is ignored by Butterworth and Chebyshev Type I. The default is -60 dB.
      iSkip = 0

      aSignalOutL clfilt aSignalInL, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
      aSignalOutR clfilt aSignalInR, kCornerFrequency, iLowPassOrHighPass, iNumberOfPoles, iFilterType, iPassBandRipple, iStopBandAttentuation, iSkip
    endif

    aSignalOutL = (aSignalOutL * gk$INSTRUMENT_NAME.Amount) + (1 - gk$INSTRUMENT_NAME.Amount) * aSignalInL
    aSignalOutR = (aSignalOutR * gk$INSTRUMENT_NAME.Amount) + (1 - gk$INSTRUMENT_NAME.Amount) * aSignalInR

    if iBalanceSignal == 1 then
      aSignalOutL balance aSignalOutL, aSignalInL
      aSignalOutR balance aSignalOutR, aSignalInR
    endif

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
