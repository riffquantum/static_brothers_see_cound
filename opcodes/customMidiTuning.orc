opcode customMidiTuning, i, ioo
  iMidiNote, iRatios, iBaseFrequency xin
  iRatios = iRatios == 0 ? giCustomTuningFrequencyDefaultRatios : iRatios
  iBaseFrequency = iBaseFrequency == 0 ? 261.626 : iBaseFrequency
  iDivisions ftlen iRatios

  iMidiNoteNumnerOfRoot = 60
  iMidiNoteNumnbrOfLowestRoot = iMidiNoteNumnerOfRoot - iDivisions * 4


  iNoteNumber = (iMidiNote - iMidiNoteNumnbrOfLowestRoot) % iDivisions
  iOctaveNumber = ((iMidiNote - iMidiNoteNumnbrOfLowestRoot - iNoteNumber) / iDivisions)
  iFrequency customTuningFrequency iOctaveNumber, iNoteNumber, iRatios, iBaseFrequency

  xout iFrequency
endop
