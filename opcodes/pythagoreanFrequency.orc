; Returns a frequency for a split pitch class value by calculating perfect
; fifths. https://en.wikipedia.org/wiki/Pythagorean_tuning

opcode pythagoreanFrequency, i, iio
  iOctaveNumber, iNoteNumber, iFrequencyOfRoot xin

  ; This should correspond to your C4, hence the default of 261.63
  iFrequencyOfRoot = iFrequencyOfRoot == 0 ? 261.63 : iFrequencyOfRoot

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/12)
  iNoteNumber = iNoteNumber % 12

  iNotePositionOnCircleOfFifths = (iNoteNumber * 7) % 12

  iFrequency = iFrequencyOfRoot *  1.5^iNotePositionOnCircleOfFifths
  iOctaveCorrection = floor(iNotePositionOnCircleOfFifths * 7 / 12) * -1
  iFrequencyInCorrectOctave = iFrequency * 2^iOctaveCorrection * 2^(iOctaveNumber - 4)

  ; Note: As this is written the wolf interval (1.4798101778) occurs from F to C.
  ; One possible improvement would be to add an argument for
  ; where to tune from so you could put that wolf interval somewhere out of the way.

  xout iFrequencyInCorrectOctave
endop
