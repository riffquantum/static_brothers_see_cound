opcode equalTempermentFrequency, i, iiooo
  iOctaveNumber, iNoteNumber, iDivisions, iFrequencyOfA4, iOctaveRatio xin
  iDivisions = iDivisions == 0 ? 12 : iDivisions
  iFrequencyOfA4 = iFrequencyOfA4 == 0 ? 440 : iFrequencyOfA4
  iOctaveRatio = iOctaveRatio == 0 ? 2 : iOctaveRatio

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/iDivisions)
  iNoteNumber = iNoteNumber % iDivisions

  iDivisionRatio = iOctaveRatio^(1/iDivisions)
  iNoteNumberofA4 = round(iDivisions * 9/12)
  iFrequencyOfC4 = iFrequencyOfA4 * iOctaveRatio^(1/iDivisions * -iNoteNumberofA4)

  iOctaveFrequency = iFrequencyOfC4 * iOctaveRatio^(iOctaveNumber - 4)
  iFrequency = iOctaveFrequency * iDivisionRatio^iNoteNumber

  xout iFrequency
endop
