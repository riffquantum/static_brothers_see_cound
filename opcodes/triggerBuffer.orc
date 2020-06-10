giTiggerBufferLastVelocityForNote[] init 128
gitriggerBufferLastTimeForNote[] init 128

opcode triggerBuffer, i, iii
  iNoteNumber, iVelocity, iDecayTime xin
  iTriggerNote = 0
  iCurrentTime times
  iTimeSinceLastNote = iCurrentTime - gitriggerBufferLastTimeForNote[iNoteNumber]

  if iDecayTime == 0 || iTimeSinceLastNote == 0 || giTiggerBufferLastVelocityForNote[iNoteNumber] == 0 then
    iTriggerNote = 1
  endif

  if iTimeSinceLastNote > iDecayTime then
    iTriggerNote = 1
  endif

  if iVelocity > giTiggerBufferLastVelocityForNote[iNoteNumber] then
    iTriggerNote = 1
  endif

  giTiggerBufferLastVelocityForNote[iNoteNumber] = iVelocity
  gitriggerBufferLastTimeForNote[iNoteNumber] = iCurrentTime

  prints sprintf(" [V: %i T: %f ], ", iVelocity, iTimeSinceLastNote)

  xout iTriggerNote
endop

