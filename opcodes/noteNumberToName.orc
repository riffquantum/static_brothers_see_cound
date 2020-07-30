opcode noteNumberToName, S,i
  iNoteNumber xin
  SNoteNames[] fillarray "C",  "C#",  "D",  "D#",  "E",  "F",  "F#",  "G",  "G#",  "A",  "A#",  "B"

  SNoteName = SNoteNames[iNoteNumber]

  xout SNoteName
endop
