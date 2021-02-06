#define PATTERN_LOOP(PATTERN_LENGTH) #
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = $PATTERN_LENGTH
  iMeasureIndex = 0

  until iMeasureIndex * iBeatsPerMeasure >= iPatternLength do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    iMeasureCount = iMeasureIndex + 1

#

#define END_PATTERN_LOOP #
    iMeasureIndex += 1
  od
#
