/*
  DISTORTION
  Creates an effect instrument that applies distortion to a signal. This isn't great and was really
  just for trying out different distortion opcodes to see the differences.

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

#define DISTORTION(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.PreGain init 10
  gk$INSTRUMENT_NAME.PostGain init 1
  gk$INSTRUMENT_NAME.DutyCycleOffset init .01
  gk$INSTRUMENT_NAME.SlopeOffset init .01
  gi$INSTRUMENT_NAME.Mode init 5

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

    iBalanceSignal = 0

    /* ********
        clip
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 1 then
      iMethod = 0
      iLimit = .1
      iArg = 0

      aSignalOutL clip aSignalInL * gk$INSTRUMENT_NAME.PreGain, iMethod, iLimit, iArg
      aSignalOutR clip aSignalInR * gk$INSTRUMENT_NAME.PreGain, iMethod, iLimit, iArg
    endif

    /* ********
        distort
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 2 then
      kDistortionAmount = 1
      iLowPassFilterHalfPowerPoint = 10
      iWaveShape ftgen 0,0, 257, 9, .5,1,270

      aSignalOutL distort aSignalInL * gk$INSTRUMENT_NAME.PreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
      aSignalOutR distort aSignalInR * gk$INSTRUMENT_NAME.PreGain, kDistortionAmount, iWaveShape, iLowPassFilterHalfPowerPoint
    endif


    /* ********
        distort1
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 3 then
      kWaveShape1 = 0
      kWaveShape2 = 0

      aSignalOutL distort1 aSignalInL, gk$INSTRUMENT_NAME.PreGain, gk$INSTRUMENT_NAME.PostGain, kWaveShape1, kWaveShape2
      aSignalOutR distort1 aSignalInR, gk$INSTRUMENT_NAME.PreGain, gk$INSTRUMENT_NAME.PostGain, kWaveShape1, kWaveShape2

      iMethod = 0
      iLimit = .01
      iArg = 0

      ;aSignalOutL clip aSignalOutL, iMethod, iLimit, iArg
      ;aSignalOutR clip aSignalOutR, iMethod, iLimit, iArg
    endif

    /* ********
        pdhalf
      ********
    */
    if gi$INSTRUMENT_NAME.Mode == 4 then
      kShapeAmount = 1
      iBipolar = 0
      iFullScale = .0001

      aSignalOutL pdhalf aSignalOutL, kShapeAmount, iBipolar, iFullScale
      aSignalOutR pdhalf aSignalOutR, kShapeAmount, iBipolar, iFullScale
    endif

    /* ********
        custom hansDistortion
      ********
    */

    if gi$INSTRUMENT_NAME.Mode == 5 then
      iBalanceSignal = 0

      iTableHeavy ftgenonce 0, 0, 8192, 7, -.8, 934, -.79, 934, -.77, 934, -.64, 1034, -.48, 520, .47, 2300, .48, 1536, .48
      iTableLight ftgenonce 0, 0, 8192, 8, -.8, 336, -.78, 800, -.7, 5920, .7, 800, .78, 336, .8

      aS$INSTRUMENT_NAME.ignalOutL hansDistortion aSignalOutL, gk$INSTRUMENT_NAME.PreGain, gk$INSTRUMENT_NAME.PostGain, gk$INSTRUMENT_NAME.DutyCycleOffset, gk$INSTRUMENT_NAME.SlopeOffset, iTableLight
      aS$INSTRUMENT_NAME.ignalOutR hansDistortion aSignalOutR, gk$INSTRUMENT_NAME.PreGain, gk$INSTRUMENT_NAME.PostGain, gk$INSTRUMENT_NAME.DutyCycleOffset, gk$INSTRUMENT_NAME.SlopeOffset, iTableLight

      aSignalOutL butterlp aSignalOutL, 5000
      aSignalOutR butterlp aSignalOutR, 5000

    endif

    if iBalanceSignal == 1 then
      aSignalOutL balance aSignalOutL, aSignalInL
      aSignalOutR balance aSignalOutR, aSignalInR
    endif

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
