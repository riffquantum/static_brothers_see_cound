opcode midiNoteNumberToPitchClassValue, i, io
  iMidiNote, iDivisions xin

  iMidiNoteNumberOfC4 = 60
  iDivisions = iDivisions == 0 ?  giDivisionsInTuningSystem : iDivisions
  iMidiNoteNumnbrOfC0 = iMidiNoteNumberOfC4 - iDivisions * 4

  iNoteNumber = (iMidiNote - iMidiNoteNumnbrOfC0) % iDivisions
  iOctaveNumber = ((iMidiNote - iMidiNoteNumnbrOfC0 - iNoteNumber) / iDivisions)

  iPitch = iOctaveNumber + (iNoteNumber/100)

  xout iPitch
endop

opcode midiNoteNumberToPitchClassValueK, k, kk
  kMidiNote, kDivisions xin

  iMidiNoteNumberOfC4 = 60
  kDivisions = kDivisions == 0 ?  giDivisionsInTuningSystem : kDivisions
  kMidiNoteNumnbrOfC0 = iMidiNoteNumberOfC4 - kDivisions * 4

  kNoteNumber = (kMidiNote - kMidiNoteNumnbrOfC0) % kDivisions
  kOctaveNumber = ((kMidiNote - kMidiNoteNumnbrOfC0 - kNoteNumber) / kDivisions)

  kPitch = kOctaveNumber + (kNoteNumber/100)

  xout kPitch
endop
