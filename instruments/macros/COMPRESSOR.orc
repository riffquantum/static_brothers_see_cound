#define COMPRESSOR(INSTRUMENT_NAME'DRY_ROUTE'WET_ROUTE) #
  $EFFECT_BYPASS($INSTRUMENT_NAME'$DRY_ROUTE'$WET_ROUTE'0'1)

  gi$INSTRUMENT_NAME.Mode init 0
  gk$INSTRUMENT_NAME.Threshold init 0
  gk$INSTRUMENT_NAME.LowKnee init 40
  gk$INSTRUMENT_NAME.HighKnee init 60
  gk$INSTRUMENT_NAME.Ratio init .5
  gk$INSTRUMENT_NAME.Attack init .1
  gk$INSTRUMENT_NAME.Release init .5
  gi$INSTRUMENT_NAME.Lookahead init .02

  instr $INSTRUMENT_NAME
    aSignalInL inleta "InL"
    aSignalInR inleta "InR"

    aSignalOutL = aSignalInL
    aSignalOutR = aSignalInR

      if gi$INSTRUMENT_NAME.Mode == 0 then
          aSignalOutL compress aSignalInL, aSignalInL, gk$INSTRUMENT_NAME.Threshold, gk$INSTRUMENT_NAME.LowKnee, gk$INSTRUMENT_NAME.HighKnee, gk$INSTRUMENT_NAME.Ratio, gk$INSTRUMENT_NAME.Attack, gk$INSTRUMENT_NAME.Release, gi$INSTRUMENT_NAME.Lookahead
          aSignalOutR compress aSignalInR, aSignalInR, gk$INSTRUMENT_NAME.Threshold, gk$INSTRUMENT_NAME.LowKnee, gk$INSTRUMENT_NAME.HighKnee, gk$INSTRUMENT_NAME.Ratio, gk$INSTRUMENT_NAME.Attack, gk$INSTRUMENT_NAME.Release, gi$INSTRUMENT_NAME.Lookahead
      else
          aSignalOutL compress2 aSignalInL, aSignalInL, gk$INSTRUMENT_NAME.Threshold, gk$INSTRUMENT_NAME.LowKnee, gk$INSTRUMENT_NAME.HighKnee, gk$INSTRUMENT_NAME.Ratio, gk$INSTRUMENT_NAME.Attack, gk$INSTRUMENT_NAME.Release, gi$INSTRUMENT_NAME.Lookahead
          aSignalOutR compress2 aSignalInR, aSignalInR, gk$INSTRUMENT_NAME.Threshold, gk$INSTRUMENT_NAME.LowKnee, gk$INSTRUMENT_NAME.HighKnee, gk$INSTRUMENT_NAME.Ratio, gk$INSTRUMENT_NAME.Attack, gk$INSTRUMENT_NAME.Release, gi$INSTRUMENT_NAME.Lookahead
      endif

    aSignalOutL *= gk$INSTRUMENT_NAME.Ratio^2
    aSignalOutR *= gk$INSTRUMENT_NAME.Ratio^2

    outleta "OutL", aSignalOutL
    outleta "OutR", aSignalOutR
  endin

  $MIXER_CHANNEL($INSTRUMENT_NAME)
#
