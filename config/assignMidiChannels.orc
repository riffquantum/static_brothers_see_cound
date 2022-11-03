
giMidiChannelIndex init 1
giMidiChannelCount init lenarray(gSMidiChannelAssignments) - 1

while giMidiChannelIndex < giMidiChannelCount && giMidiChannelIndex <= 16 do
  massign  giMidiChannelIndex, gSMidiChannelAssignments[giMidiChannelIndex]
  giMidiChannelIndex += 1
od
