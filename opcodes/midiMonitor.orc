opcode midiMonitor, 0, 0
  kStatusCode, kChannel, kData1, kData2 midiin
  kTime times

  ktrigger  changed  kStatusCode, kChannel, kData1, kData2

  if ktrigger=1 && kStatusCode!=0 then

    midiout kStatusCode, kChannel, kData1, kData2

    printks "-- MIDI Input -- %n%t Time: %f %n", 0, kTime

    if kStatusCode == 144 then
      printks "%t Note On (%d)%n %t Channel: %d %n %t Note Number: %d (%f) %n %t Velocity: %d %n", 0, kStatusCode,  kChannel, kData1, pchoct(octcps(mtof(kData1))), kData2
    elseif kStatusCode == 128 then
      SStatusCodeString sprintfk "%s", "Note Off"

      printks "%t Note Off (%d) %n %t Channel: %d %n %t Note Number: %d (%f) %n %t Data 2: %d %n", 0, kStatusCode, kChannel, kData1, pchoct(octcps(mtof(kData1))), kData2
    elseif kStatusCode == 224 then
      printks "%t Pitch Bend (%d) %n %t Channel: %d %n %t Pitch Wheel MSB: %d %n %t Pitch Wheel LSB: %d %n", 0, kStatusCode, kChannel, kData1, kData2
    elseif kStatusCode == 176 then
      SStatusCodeString sprintfk "%s", "Control Change"

      printks "%t Control Change (%d) %n %t Channel: %d %n %t Control Number: %d %n %t Control Value: %d %n", 0, kStatusCode, kChannel, kData1, kData2
    elseif kStatusCode == 192 then
      SStatusCodeString sprintfk "%s", "Program Change"

      printks "%t Program Change (%d) %n %t Channel: %d %n %t Program Number: %d %n %t Data 2: %d %n", 0, kStatusCode, kChannel, kData1, kData2
    else
      SStatusCodeString sprintfk "%s", "Unkown Event Type"

      printks "%t Status Code: %d -- %s %n %t Channel: %d %n %t Data 1: %d %n %t Data 2: %d %n", 0, kStatusCode, SStatusCodeString, kChannel, kData1, kData2
    endif

    printks "%t Assigned Instrument: %s %n", 0, gSMidiChannelAssignments[kChannel]

    printks "---- %n%n", 0

  endif
endop
