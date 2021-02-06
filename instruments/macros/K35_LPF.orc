#define K35_LPF(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.DryAmount init 0
  gk$INSTRUMENT_NAME.WetAmount init 1
  gk$INSTRUMENT_NAME.CutoffFrequency init 5000
  gk$INSTRUMENT_NAME.Saturation init .3 ; saturation amount to use for non-linear processing. Values > 1 increase the steepness of the NLP curve.
  gi$INSTRUMENT_NAME.NonLinearProcessingMethod init 0 ; Non-linear processing method. 0 = no processing, 1 = non-linear processing. Method 1 uses tanh(ksaturation * input). Enabling NLP may increase the overall output of filter above unity and should be compensated for outside of the filter.
  gk$INSTRUMENT_NAME.Q init 4

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    kCutoffFrequency = gk$INSTRUMENT_NAME.CutoffFrequency * (p4 == 0 ? 1 : p4)
    kQ = gk$INSTRUMENT_NAME.Q * (p5 == 0 ? 1 : p5)
    iStore = 1 ;initial disposition of internal data space. Since filtering incorporates a feedback loop of previous output, the initial status of the storage space used is significant. A zero value will clear the space; a non-zero value will allow previous information to remain. The default value is 0.

    ; kCutoffFrequency = oscil(5000, 2) + 5300
    kQ = oscil(1, 1) + 2
    kSaturation = oscil(.5, .5) + 1

    aSignalOutL K35_lpf aSignalInL, kCutoffFrequency, kQ, gi$INSTRUMENT_NAME.NonLinearProcessingMethod, gk$INSTRUMENT_NAME.Saturation, iStore
    aSignalOutR K35_lpf aSignalInR, kCutoffFrequency, kQ, gi$INSTRUMENT_NAME.NonLinearProcessingMethod, gk$INSTRUMENT_NAME.Saturation, iStore

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
