instr synthLead1
  iPatternLength = secondsToBeats(p3)

  iBeatsPerMeasure = 16
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1
    beatScoreline "RingModForLeadSynth", iBaseTime, iBeatsPerMeasure

    beatScoreline "LeadSynth", iBaseTime, 7, 127, 4.09
    beatScoreline "LeadSynth", iBaseTime+7, .5, 127, 4.07
    beatScoreline "LeadSynth", iBaseTime+7.5, .5, 127, 4.05
    beatScoreline "LeadSynth", iBaseTime+8, 1.5, 100, 4.07
    beatScoreline "LeadSynth", iBaseTime+9.5, .5, 100, 4.04
    beatScoreline "LeadSynth", iBaseTime+10, 6, 100, 4.02

    iMeasureIndex += 1
  od
endin
