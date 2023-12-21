instr VerseFadeIn
  ; beats per measure * number of measures + 1 because bass starts a note early
  iDrumStartTime = 48 * 4 + 1

  gkSnareDelayDryAmount = linseg(0, bts(65), 0, bts(33), i(gkSnareDelayDryAmount))
  gkSnareDelayWetAmount = linseg(0, bts(24), 0, bts(13), i(gkSnareDelayWetAmount))
  gkDL1_CHINAFader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_CHINAFader))
  gkDL1_HHFader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_HHFader))
  gkDL1_KICKFader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_KICKFader))
  gkDL1_RIDEFader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_RIDEFader))
  gkDL1_OHFader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_OHFader))
  gkDL1_ROOMSFader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_ROOMSFader))
  gkDL1_TOM1Fader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_TOM1Fader))
  gkDL1_TOM2Fader = linseg(0, bts(iDrumStartTime - .25), 0, bts(.25), i(gkDL1_TOM2Fader))
endin
