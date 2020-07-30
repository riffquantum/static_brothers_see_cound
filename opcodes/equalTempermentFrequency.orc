opcode equalTempermentFrequency, i, iioo
  iOctaveNumber, iNoteNumber, iDivisions, iFrequencyOfA4 xin
  iDivisions = iDivisions == 0 ? 12 : iDivisions
  iFrequencyOfA4 = iFrequencyOfA4 == 0 ? 440 : iFrequencyOfA4

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/iDivisions)
  iNoteNumber = iNoteNumber % iDivisions

  iDivisionRatio = 2^(1/iDivisions)
  iNoteNumberofA4 = iDivisions * 9/12
  iFrequencyOfC4 = iFrequencyOfA4 * 2^(1/iDivisions * -iNoteNumberofA4)

  iDivisions = iDivisions == 0 ? 12 : iDivisions

  iOctaveFrequency = iFrequencyOfC4 * 2^(iOctaveNumber - 4)
  iFrequency = iOctaveFrequency * iDivisionRatio^iNoteNumber

  xout iFrequency
endop
