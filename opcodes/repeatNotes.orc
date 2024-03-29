opcode "repeatNotes", 0, Siiiiipoooooooo
  SInstrumentName, iStartTime, iTotalDuration, iNotesPerBeat, iNoteDuration, iVelocity, iPitch, iPitchQuotient, iAccent, iSwing, iP6, iP7, iP8, iP9, iP10 xin

  iTotalNotes = iTotalDuration * iNotesPerBeat
  iNoteCount = 0

  until iNoteCount >= iTotalNotes do
    iPitch = iPitch == 0 ? 1 : iPitch
    if iPitchQuotient != 0 then
      iPitch *= (1 - iNoteCount/iPitchQuotient)
    endif

    if (iAccent == 0) then
      iAccented = 0
    elseif(iNoteCount % iAccent == 0) then
      iAccented = 1
    else
      iAccented = 0
    endif

    iNoteVelocity = iAccented == 1 ?  iVelocity * 1.5 :  iVelocity
    iNotePitch = iAccented == 1 ? iPitch * 1.02 : iPitch

    SNoteParams sprintfk {{ %f %f %f %f %f %f %f}}, iNoteVelocity, iNotePitch, iP6, iP7, iP8, iP9, iP10

    if (iNoteCount % 2 == 0) then
      beatScorelineS( SInstrumentName, iStartTime + iNoteCount*(1/iNotesPerBeat), iNoteDuration, SNoteParams )
    else
      beatScorelineS( SInstrumentName, iStartTime + iNoteCount*(1/iNotesPerBeat) + iSwing, iNoteDuration - iSwing, SNoteParams )
    endif

    iNoteCount += 1
  od
endop
