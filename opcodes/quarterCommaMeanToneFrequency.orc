opcode quarterCommaMeanToneFrequency, i, iio
  iOctaveNumber, iNoteNumber, iFrequencyOfRoot xin
  iFrequencyOfRoot = iFrequencyOfRoot == 0 ? 261.63 : iFrequencyOfRoot

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/12)
  iNoteNumber = iNoteNumber % 12

  iNotePositionOnCircleOfFifths = (iNoteNumber * 7) % 12

  iFrequency = iFrequencyOfRoot *  1.5^iNotePositionOnCircleOfFifths * (80/81)^(1/4)
  iFrequency = iFrequencyOfRoot *  (5^(1/4))^iNotePositionOnCircleOfFifths
  iOctaveCorrection = floor(iNotePositionOnCircleOfFifths * 7 / 12) * -1
  iFrequencyInCorrectOctave = iFrequency * 2^iOctaveCorrection * 2^(iOctaveNumber - 4)

  xout iFrequencyInCorrectOctave
endop
