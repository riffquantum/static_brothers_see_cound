opcode equalTempermentFrequency, i, iiooo
  iOctaveNumber, iNoteNumber, iDivisions, iFrequencyOfA4, iOctaveSize xin
  iDivisions = iDivisions == 0 ? 12 : iDivisions
  iFrequencyOfA4 = iFrequencyOfA4 == 0 ? 440 : iFrequencyOfA4
  iOctaveSize = iOctaveSize == 0 ? 2 : iOctaveSize

  ; Normalize note numbers that exceed number of divisions
  iOctaveNumber += floor(iNoteNumber/iDivisions)
  iNoteNumber = iNoteNumber % iDivisions

  iDivisionRatio = iOctaveSize^(1/iDivisions)
  iNoteNumberofA4 = round(iDivisions * 9/12)
  iFrequencyOfC4 = iFrequencyOfA4 * iOctaveSize^(1/iDivisions * -iNoteNumberofA4)

  iOctaveFrequency = iFrequencyOfC4 * iOctaveSize^(iOctaveNumber - 4)
  iFrequency = iOctaveFrequency * iDivisionRatio^iNoteNumber

  xout iFrequency
endop
