/*
  PITCH_SHIFTER
  Creates an effect instrument that applies pitch shifting to a signal.

  Global Variables:
    None

  P Fields:
    p4 - StartingPitch - Pitch factor shift the signal by.
    p5 - EndingPitch - If 0, pitch will remain stable for the duration
      of the effect. Any other value will linearly change the pitch value
      over the duration of the effect.
    p6 - WetRelease - Release time for the effect's signal

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define PITCH_SHIFTER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iStartingPitch = p4
    iEndingPitch = p5 != 0 ? p5 : p4
    iWetRelease = p6
    kPitchShift = linseg(iStartingPitch, p3, iEndingPitch)
    kWetLevel madsr .001, .001, 1, iWetRelease

    aSignalOutL pitchShifter aSignalInL, kPitchShift, 1, 1
    aSignalOutR pitchShifter aSignalInR, kPitchShift, 1, 1

    outleta "OutL", aSignalOutR
    outleta "OutR", aSignalOutL
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
