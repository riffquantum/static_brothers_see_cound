/*
  PATTERN_LOOP, END_PATTERN_LOOP
  Two macros that should surround beatScoreline (or _) statements within pattern
  instruments.

  Loop Variables:
    iPatternLength - The total duration for the instance of the
      pattern in beats.
    iBeatsPerMeasure - Length in beats of pattern to be looped in
      beats
    iMeasureIndex - The current index of the loop.
    iMeasureCount - The index of the loop plus 1.
    iBasetime - The starting time of the measure per loop instance.
      All events in the loop should modify this value for their
      p2 value.
    i0 - Alias of iBasetime

  Macro Arguments:
    $PATTERN_LENGTH - Length in beats of pattern to be looped
      in beats. Must be an integer.
*/
#define PATTERN_LOOP(PATTERN_LENGTH) #
  iPatternLength = secondsToBeats(p3)
  iBeatsPerMeasure = $PATTERN_LENGTH
  iPatternLengthInMeasures = p3/iBeatsPerMeasure
  iMeasureIndex = 0

  until floor(iMeasureIndex * iBeatsPerMeasure) >= floor(iPatternLength) do
    iBaseTime = iMeasureIndex * iBeatsPerMeasure
    i0 = iBaseTime
    iMeasureCount = iMeasureIndex + 1

#

#define END_PATTERN_LOOP #
    iMeasureIndex += 1
  od
#
