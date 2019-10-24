;This is an untested idea for a way to cut down on
; multiple midi events from drum triggers

gitriggerBuffers[] init 128
gktriggerBufferTimers[] init 128

opcode triggerBuffer, i, iii
  iVelocity, iNoteNumber, iDecayTime xin
  iTriggerNote = 0

  if iDecayTime == 0 then
    iTriggerNote = 1
    goto output
  endif

  ; If the velocity is higher than the recorded
  ; velocity for the note then trigger the note. Ignore the
  ; event if the velocity is lower.
  if iVelocity >= gitriggerBuffers[iNoteNumber] then
    iTriggerNote = 1

    ; Start a timer and trigger an instrument that will reset the velocity after the decay time for the drum.
    gktriggerBufferTimers[iNoteNumber] metro iDecayTime,  0.00000001
    scoreline_i sprintfk({{i "TriggerBufferReset" 0 %f  %f}}, (iDecayTime + 0.01), iNoteNumber)
  endif

  gitriggerBuffers[iNoteNumber] = iVelocity

  output:
  xout iTriggerNote
endop

instr TriggerBufferReset
  iNoteNumber = p4

  if gktriggerBufferTimers[iNoteNumber] == 1 then
    gitriggerBuffers[iNoteNumber] = 0
  endif
endin
