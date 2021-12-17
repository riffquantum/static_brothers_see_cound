/*
  FREEZER
  Creates an effect instrument that loops a segment of input.

  P Fields:
    p4 - BeatsToLoopStart - Length of input in beats to be looped at init time.
    p5 - BeatsToLoopEnd - Length of loop in beats at release time. Applied as
      linear change to delay time.
    p6 - DWetRelease - Release time for the instance.
    p7 - PanAmount - Amount for alternating panning of each loop iteration.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define FREEZER(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iBeatsToLoopStart = p4
    iBeatsToLoopEnd = p5 != 0 ? p5 : p4
    iDWetRelease = p6
    iPanAmount = p7

    aTime = linseg(iBeatsToLoopStart, p3, iBeatsToLoopEnd) * 60/gkBPM

    kWetLevel madsr .001, .001, 1, iDWetRelease
    iFeedbackAmount = 1
    iBufferLength = 10
    kInputEnvelope = linseg(1, iBeatsToLoopStart, 1, .1, 0)

    kPanOscillator = poscil(iPanAmount * 50, 1/(aTime*2), squareWave()) + 50

    aSignalInL *= kInputEnvelope
    aSignalInR *= kInputEnvelope

    aSignalOutR delayBuffer aSignalInR, iFeedbackAmount, iBufferLength, aTime, kWetLevel
    aSignalOutL delayBuffer aSignalInL, iFeedbackAmount, iBufferLength, aTime, kWetLevel

    aSignalOutL, aSignalOutR pan aSignalOutL, aSignalOutR, kPanOscillator

    aSignalOutR += aSignalInR
    aSignalOutL += aSignalInL

    outleta "OutL", aSignalOutR
    outleta "OutR", aSignalOutL
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
