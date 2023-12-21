instr config
  gkVoxPitch1DryAmount init 1
  ; gkVoxBusFader init .25

  gkPreClipMixerFader = .75

  gkLowVox1Fader init .18
  gkLowVox2Fader init .25
  gkLowVox3Fader init .15
  gkLowVox4Fader init .15
  gkLowVox5Fader init .2
  gkLowVox6Fader init .25
  gkLowVox7Fader init .25
  gkLowVox8Fader init .25
  gkMidVox1Fader init .33
  gkMidVox2Fader init .333
  gkMidVox3Fader init .333
  gkHiVox1Fader init .25
  gkHiVox2Fader init .25
  gkHiVox3Fader init .25
  gkHiVox4Fader init .25
  gkHiVox5Fader init .25
  gkHiVox6Fader init .25


  gkLowVox1Pan init 25
  gkLowVox2Pan init 75
  gkLowVox3Pan init 0
  gkLowVox4Pan init 100
  gkLowVox5Pan init 50
  gkLowVox6Pan init 33
  gkLowVox7Pan init 66
  gkLowVox8Pan init 50
  gkHiVox1Pan init 25
  gkHiVox2Pan init 0
  gkHiVox3Pan init 100
  gkHiVox4Pan init 25
  gkHiVox5Pan init 75
  gkHiVox6Pan init 50

  gkSnareDelayDryAmount init 1
  gkSnareDelayWetAmount init .75
  gkDL1_CHINAFader init .333
  gkDL1_HHFader init .333
  gkDL1_RIDEFader init .333
  gkDL1_KICKFader init 1
  gkDL1_OHFader init .25
  gkDL1_ROOMSFader init .25
  gkDL1_TOM1Fader init .25
  gkDL1_TOM2Fader init .25
  gkDL1_SNAREBOTTOMFader init .333
  gkDL1_SNARETOPFader init .333
  gkDrumBusFader init 1.2


  gkCloserKickFader init 0.75
  gkCloserKickEqBass init 1.5
  gkCloserSnareFader init 0.5
  gkFalseHatFader init 0.25

  gkDist808Fader init .75
  gkBassBusFader init .25

  gkNoInputFader init .333

  gkDL1_RIDEPan = 0
  gkDL1_CHINAPan = 100

  gkKickHelixFader = 0.25
  gkKickHelix2Fader = 0.25
  gkKickHelixPan = oscil(50, 1/bts(32)) + 50
  gkKickHelix2Pan = oscil(50, 1/bts(32), -1, .5) + 50

  gkGuitar1GrainFader init .5

  gkGuitar1GrainPan init 0.75

  gkAmenBreakFader init 2.5


  ; gkBassBusFader = .75
  gkBassBusEqBass = 1.25

  gkCloserVerbWetAmount = .75

  gkDist808PreGain = 20
  gkDist808PostGain = 1
  gkDist808DutyOffset = .001
  gkDist808SlopeShift = .001
  giDist808Stage2ClipLevel = 0dbfs/2
  giDist808FinalGainAmount = .25

  gkBassSubDiPan = 100
  gkBassSubPan = 0

  giBassDelayInputNumberOfBands = 4
  giBassDelayInputAmountsL = $TABLE(4'1, .5, .3, .8)
  giBassDelayInputAmountsR = $TABLE(4'.3, 1, .4, .8)
  giBassDelayDelayTimesL = $TABLE(4'beatsToSeconds(2), beatsToSeconds(.5), beatsToSeconds(2), beatsToSeconds(.5))
  giBassDelayDelayTimesR = $TABLE(4'beatsToSeconds(4.5), beatsToSeconds(2), beatsToSeconds(3.5), beatsToSeconds(2))
  giBassDelayFeedbackLevelsL ftgen 0, 0, 4, -2, 0.999, 0.9, 0.9, 0.999
  giBassDelayFeedbackLevelsR = giBassDelayFeedbackLevelsL

  ; giBassDelayInputNumberOfBands = 64
  ; giBassDelayInputAmountsL ftgen 0, 0, 64, -7, .1, 16, 1, 16, .8, 16, 1, 16, .1
  ; giBassDelayInputAmountsR = giBassDelayInputAmountsL
  ; giBassDelayDelayTimesL ftgen 0, 0, 64, -7, .1, 16, 1, 16, .8, 16, 1, 16, .1
  ; giBassDelayDelayTimesR = giBassDelayDelayTimesL
  ; giBassDelayFeedbackLevelsL ftgen 0, 0, 64, -7, 0.5, 16, 0.7, 16, 0.9, 16, 0.99, 16, 0
  ; giBassDelayFeedbackLevelsR = giBassDelayFeedbackLevelsL

  gkGuitar1_B52Pan init 0
  gkGuitar2_B52Pan init 100
  gkGuitar1_B52Fader init .25
  gkGuitar2_B52Fader init .25
  ; gkGuitar1_SOL_57Pan = 0
  ; gkGuitar1_SOL_451Pan = 0
  ; gkGuitar2_SOL_57Pan = 100
  ; gkGuitar2_SOL_451Pan = 100

  gkGuitarBusFader = 0.5

  gkDL2_CHINAFader init .333
  gkDL2_HHFader init .333
  gkDL2_RIDEFader init .333
  gkDL2_KICKFader init 1
  gkDL2_OHFader init .25
  gkDL2_ROOMSFader init .25
  gkDL2_TOM1Fader init .25
  gkDL2_TOM2Fader init .25
  gkDL2_SNAREBOTTOMFader init .333
  gkDL2_SNARETOPFader init .333
  gkDL2_RIDEPan = 0
  gkDL2_CHINAPan = 100

  gkDL2G_CHINAFader init .333 * .25
  gkDL2G_HHFader init .333 * .25
  gkDL2G_RIDEFader init .333 * .25
  gkDL2G_KICKFader init 1 * .25
  gkDL2G_OHFader init .25 * .25
  gkDL2G_ROOMSFader init .25 * .25
  gkDL2G_TOM1Fader init .25 * .25
  gkDL2G_TOM2Fader init .25 * .25
  gkDL2G_SNAREBOTTOMFader init .333 * .25
  gkDL2G_SNARETOPFader init .333 * .25
  gkDL2G_RIDEPan = 0
  gkDL2G_CHINAPan = 100

  gkDL2Alt_CHINAFader init .333
  gkDL2Alt_HHFader init .333
  gkDL2Alt_RIDEFader init .333
  gkDL2Alt_KICKFader init 1
  gkDL2Alt_OHFader init .25
  gkDL2Alt_ROOMSFader init .25
  gkDL2Alt_TOM1Fader init .25
  gkDL2Alt_TOM2Fader init .25
  gkDL2Alt_SNAREBOTTOMFader init .333
  gkDL2Alt_SNARETOPFader init .333
  gkDL2Alt_RIDEPan = 0
  gkDL2Alt_CHINAPan = 100

  gkDL3_CHINAFader init .333
  gkDL3_HHFader init .333
  gkDL3_RIDEFader init .333
  gkDL3_KICKFader init 1
  gkDL3_OHFader init .25
  gkDL3_ROOMSFader init .25
  gkDL3_TOM1Fader init .25
  gkDL3_TOM2Fader init .25
  gkDL3_SNAREBOTTOMFader init .333
  gkDL3_SNARETOPFader init .333
  gkDL3_RIDEPan = 0
  gkDL3_CHINAPan = 100

endin
