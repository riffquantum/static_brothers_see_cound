/*
  TO_MONO
  Creates an effect instrument that recieves a stereo signal, combines the two
  channels (optionally favoring one or the other), and outputs two identical
  signals on the left and right channels.

  Global Variables:
    Balance - k - A Panning value between -50 and 50 that will modify the instance
      balance (see p4) by simple addition.

  P Fields:
    p4 - Balance - Number - A Panning value between -50 and 50 corresponding
      to left and right respectively. This panning will occur during the combination
      operation so a value of -50 will result in the inputs left side being routed
      to both channels with the right side eliminated. A value of 0 will combine
      them evenly.

  Macro Arguments:
    $INSTRUMENT_NAME - String - Name for the instrument to be generated
    $WET_ROUTE - String - The route for the instrument's Wet output
    $DRY_ROUTE - String - The route for the instrument's Dry output
*/

#define TO_MONO(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gk$INSTRUMENT_NAME.Balance init 0

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    iBalance = p4
    kBalance = limit(iBalance + gk$INSTRUMENT_NAME.Balance, -50, 50)

    ; TO DO: Improve the equation for more even volume across the stereo
    ; image. As it is, the amplitude is halved when centered, making it quieter
    ; than full pan left or right.
    kLeftAmount = (kBalance - 50)/-100
    kRightAmount = (kBalance + 50)/100

    aSignalOut = (aSignalInL * kLeftAmount) + (aSignalInR * kRightAmount)

    outleta "OutL", aSignalOut
    outleta "OutR", aSignalOut
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
