opcode customMidiTuning, i, iooo
  iMidiNote, iRatios, iBaseFrequency, iOctaveSize xin
  iRatios = iRatios == 0 ? giCustomTuningFrequencyDefaultRatios : iRatios
  iDivisions ftlen iRatios

  iMidiNoteNumnerOfRoot = 60
  iMidiNoteNumnbrOfLowestRoot = iMidiNoteNumnerOfRoot - iDivisions * 4


  iNoteNumber = (iMidiNote - iMidiNoteNumnbrOfLowestRoot) % iDivisions
  iOctaveNumber = ((iMidiNote - iMidiNoteNumnbrOfLowestRoot - iNoteNumber) / iDivisions)
  iFrequency customTuningFrequency iOctaveNumber, iNoteNumber, iRatios, iBaseFrequency, iOctaveSize

  xout iFrequency
endop
