opcode pythagoreanMidiTuning, i, io
  iMidiNote, iBaseFrequency xin
  iBaseFrequency = iBaseFrequency == 0 ? 261.626 : iBaseFrequency
  iMidiNoteNumnerOfRoot = 60
  iMidiNoteNumnbrOfLowestRoot = iMidiNoteNumnerOfRoot - 12 * 4

  iNoteNumber = (iMidiNote - iMidiNoteNumnbrOfLowestRoot) % 12
  iOctaveNumber = ((iMidiNote - iMidiNoteNumnbrOfLowestRoot - iNoteNumber) / 12)

  iFrequency pythagoreanFrequency iOctaveNumber, iNoteNumber, iBaseFrequency

  xout iFrequency
endop
