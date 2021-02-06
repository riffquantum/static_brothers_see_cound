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
