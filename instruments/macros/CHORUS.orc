/*
  CHORUS
  Creates an effect instrument that applies a chorus effect. Uses the m_chorus opcode
  which is based on an effect designed by Jeanette C.

  Global Variables:
    Amount - k - The intensity of the effect, both rate and depth, between 0 and 1
    DryWet - k - The dry wet control, between 0 and 1, where 0 is dry and 1 maximum
      wet, which still retains some of the original input
    StereoRecombinationMode - i - m_chorus takes a mono input and delivers a stereo
      output. This effect instrument takes a stereo input. This value determines
      whether or not to use that additional stereo information in the output.


  P Fields:
    p4 - ChorusAmount - A per instance modifier of the global value.
    p5 - DryWet - A per instance modifier of the global value.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define CHORUS(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'1'1)

  gk$INSTRUMENT_NAME.Amount init 1
  gk$INSTRUMENT_NAME.DryWet init 1
  gi$INSTRUMENT_NAME.StereoRecombinationMode init 0

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    kChorusAmount = gk$INSTRUMENT_NAME.Amount * (p4 == 0 ? 1 : p4)
    kDryWet = gk$INSTRUMENT_NAME.DryWet * (p5 == 0 ? 1 : p5)

    aSignalOutLL, aSignalOutLR m_chorus aSignalInL, kChorusAmount, kDryWet
    aSignalOutRL, aSignalOutRR m_chorus aSignalInR, kChorusAmount, kDryWet

    if gi$INSTRUMENT_NAME.StereoRecombinationMode == 0 then
      aSignalOutL = aSignalOutLL
      aSignalOutR = aSignalOutRR
    else
      aSignalOutL = aSignalOutLL + aSignalOutRL
      aSignalOutR = aSignalOutLR + aSignalOutRR
    endif

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
