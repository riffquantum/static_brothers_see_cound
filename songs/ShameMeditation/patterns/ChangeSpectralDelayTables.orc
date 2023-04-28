instr ChangeSpectralDelayTables
  giSpectralDelayInputNumberOfBands = 64
  giSpectralDelayInputAmountsL ftgen 0, 0, 64, -7, .1, 16, 1, 16, .8, 16, 1, 16, .1
  giSpectralDelayInputAmountsR = giSpectralDelayInputAmountsL
  giSpectralDelayDelayTimesL ftgen 0, 0, 64, -7, .1, 16, 1, 16, .8, 16, 1, 16, .1
  giSpectralDelayDelayTimesR = giSpectralDelayDelayTimesL
  giSpectralDelayFeedbackLevelsL ftgen 0, 0, 64, -7, 0.5, 16, 0.7, 16, 0.9, 16, 0.99, 16, 0
  giSpectralDelayFeedbackLevelsR = giSpectralDelayFeedbackLevelsL
endin
