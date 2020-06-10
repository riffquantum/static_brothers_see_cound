opcode "repeatNotes", 0, Siiiiiooo
  SInstrumentName, iStartTime, iTotalDuration, iNotesPerBeat, iNoteDuration, iVelocity, iPitchQuotient, iAccent, iSwing xin

  iTotalNotes = iTotalDuration * iNotesPerBeat
  iNoteCount = 0

  until iNoteCount >= iTotalNotes do
    if iPitchQuotient == 0 then
      iPitch = 1
    else
      iPitch = 1 - iNoteCount/iPitchQuotient
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

    SNoteParams sprintfk {{ %f %f }}, iNoteVelocity, iNotePitch

    if (iNoteCount % 2 == 0) then
      beatScorelineS( SInstrumentName, iStartTime + iNoteCount*(1/iNotesPerBeat), iNoteDuration, SNoteParams )
    else
      beatScorelineS( SInstrumentName, iStartTime + iNoteCount*(1/iNotesPerBeat) + iSwing, iNoteDuration - iSwing, SNoteParams )
    endif

    iNoteCount += 1
  od
endop
