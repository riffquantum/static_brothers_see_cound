/*
  VOCODER
  Creates a set of effect instruments. Modulates one signal with another
  like a vocoder. The instruments are the Vocoder itself and the Carrier
  which is simply used for routing. Vocoder uses Jeanette C.'s m_vc110 opcode.

  Additional Routes:
    InL, InR for {instrument name}Carrier - The modulating signal
    needs to be routed here.

  Global Variables:
    Q - k - The Q of the bandpass filters, should be >1, good values are between
      4 and 12, the filter bandwidth is filter frequency / Q
    Shift - k - Formant shift in Hz, good values are -500 to +500, the formant
      shift works by linearly changing the centre frequencies of the modulator
      filterbank.
    IntNoise - k - Whether or not to use the internal noise for the highest band
      or the filtered band from the original modulator input.
      0 = original modulator band
      1 = internal noise band
    Mode - k - Mode of operations, the default is 0
      0 = classic vocoder
      1 = filtered output of the carrier
      2 = filtered output of the modulator

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define VOCODER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.Q init 4
  gk$INSTRUMENT_NAME.Shift init 750
  gk$INSTRUMENT_NAME.IntNoise init 1
  gk$INSTRUMENT_NAME.Mode init 0

  connect "$INSTRUMENT_NAME.Carrier", "OutL", "$INSTRUMENT_NAME", "CarrierInL"
  connect "$INSTRUMENT_NAME.Carrier", "OutR", "$INSTRUMENT_NAME", "CarrierInR"
  alwayson "$INSTRUMENT_NAME.Carrier"

  instr $INSTRUMENT_NAME.Carrier
    aSignalL inleta "InL"
    aSignalR inleta "InR"

    outleta "OutL", aSignalL
    outleta "OutR", aSignalR
  endin

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aCarrierL inleta "CarrierInL"
    aCarrierR inleta "CarrierInR"

    kQ = gk$INSTRUMENT_NAME.Q
    kShift = gk$INSTRUMENT_NAME.Shift
    kIntNoise = gk$INSTRUMENT_NAME.IntNoise
    kMode = gk$INSTRUMENT_NAME.Mode

    aSignalOutL m_vc110 aCarrierL, aSignalInL, kQ, kShift, kIntNoise, kMode
    aSignalOutR m_vc110 aCarrierR, aSignalInR, kQ, kShift, kIntNoise, kMode

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
