instr ChangeSpectralDelayTables2
  giSpectralDelayInputNumberOfBands = 4
  giSpectralDelayInputAmountsL = $TABLE(4'1, .25, .1, .4)
  giSpectralDelayInputAmountsR = $TABLE(4'.1, 1, .4, .8)
  giSpectralDelayDelayTimesL = $TABLE(4'beatsToSeconds(2), beatsToSeconds(.5), beatsToSeconds(2), beatsToSeconds(.5))
  giSpectralDelayDelayTimesR = $TABLE(4'beatsToSeconds(.5), beatsToSeconds(2), beatsToSeconds(.5), beatsToSeconds(2))
  giSpectralDelayFeedbackLevelsL ftgen 0, 0, 4, -2, 0.999, 0.9, 0.9, 0.999
  giSpectralDelayFeedbackLevelsR = giSpectralDelayFeedbackLevelsL
endin
