/*
  LIVE_GRAIN
  Creates an effect instrument that modifies a signal via granular synthesis.

  Global Variables:
    None

  P Fields:
    None

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define LIVE_GRAIN(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS_DEP($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'.25'1)

  connect "$INSTRUMENT_NAME.Grain", "OutL", "$INSTRUMENT_NAME.MixerChannel", "InL"
  connect "$INSTRUMENT_NAME.Grain", "OutR", "$INSTRUMENT_NAME.MixerChannel", "InR"

  gi$INSTRUMENT_NAME.TableL ftgen 0, 0, sr, 2, 0
  gi$INSTRUMENT_NAME.TableR ftgen 0, 0, sr, 2, 0
  gi$INSTRUMENT_NAME.HalfSine ftgen 0, 0, 1024, 9, .5, 1, 0
  gi$INSTRUMENT_NAME.Delay = 1

  instr $INSTRUMENT_NAME
    aInL inleta "InL"
    aInR inleta "InR"

    ga$INSTRUMENT_NAME.WritePointer = phasor(1)
    tablew(aInL, ga$INSTRUMENT_NAME.WritePointer, gi$INSTRUMENT_NAME.TableL, 1)
    tablew(aInR, ga$INSTRUMENT_NAME.WritePointer, gi$INSTRUMENT_NAME.TableR, 1)

    schedule("$INSTRUMENT_NAME.GrainController", gi$INSTRUMENT_NAME.Delay/1000, p3)
  endin

  instr $INSTRUMENT_NAME.GrainController
    kGrainDur = 30 ;milliseconds
    kTranspos = 0 ;oscil(300, .1) ;cent
    kDensity = 500 ;Hz (grains per second)
    kDistribution = 2 ;0-1
    kTrig = metro(kDensity)

    if kTrig==1 then
      kPointer = (k(ga$INSTRUMENT_NAME.WritePointer)-gi$INSTRUMENT_NAME.Delay/1000) * .5
      kOffset = random:k(0,kDistribution/kDensity)
      schedulek("$INSTRUMENT_NAME.Grain", kOffset, kGrainDur/1000, kPointer, cent(kTranspos))
    endif
  endin

  instr $INSTRUMENT_NAME.Grain
    iStart = p4
    iSpeed = p5

    aSignalOutL = poscil3:a(poscil3:a(.3, 1/p3, gi$INSTRUMENT_NAME.HalfSine), iSpeed, gi$INSTRUMENT_NAME.TableL, iStart)
    aSignalOutR = poscil3:a(poscil3:a(.3, 1/p3, gi$INSTRUMENT_NAME.HalfSine), iSpeed, gi$INSTRUMENT_NAME.TableR, iStart)

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
