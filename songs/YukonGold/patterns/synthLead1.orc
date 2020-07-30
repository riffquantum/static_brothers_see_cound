instr synthLead1
  iPatternLength = p3 * i(gkBPM)/60

  iBeatsPerMeasure = 16
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1
    beatScoreline "RingModForLeadSynth", iBaseTime, iBeatsPerMeasure

    beatScoreline "LeadSynth", iBaseTime, 7, 127, 8.09
    beatScoreline "LeadSynth", iBaseTime+7, .5, 127, 8.07
    beatScoreline "LeadSynth", iBaseTime+7.5, .5, 127, 8.05
    beatScoreline "LeadSynth", iBaseTime+8, 1.5, 100, 8.07
    beatScoreline "LeadSynth", iBaseTime+9.5, .5, 100, 8.04
    beatScoreline "LeadSynth", iBaseTime+10, 6, 100, 8.02

    iMeasureIndex += 1
  od
endin
