opcode equalTempermentMidiTuning, i, iooo
  ;Helpful list of standard frequencies - https://www.inspiredacoustics.com/en/MIDI_note_numbers_and_center_frequencies
  iMidiNote, iDivisions, iFrequencyOfA4, iOctaveSize xin
  iMidiNoteNumberOfC4 = 60
  iDivisions = iDivisions == 0 ? 12 : iDivisions
  iMidiNoteNumnbrOfC0 = iMidiNoteNumberOfC4 - iDivisions * 4

  iNoteNumber = (iMidiNote - iMidiNoteNumnbrOfC0) % iDivisions
  iOctaveNumber = ((iMidiNote - iMidiNoteNumnbrOfC0 - iNoteNumber) / iDivisions)

  iFrequency equalTempermentFrequency iOctaveNumber, iNoteNumber, iDivisions, iFrequencyOfA4, iOctaveSize

  xout iFrequency
endop
