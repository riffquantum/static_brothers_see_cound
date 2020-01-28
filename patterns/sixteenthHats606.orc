instr sixteenthHats606
    itotalNotes = p3 * i(gkBPM)/60 * 4
    iHatVelocity = p4
    iPitchQuotient = p5
    iHatAccent = p6
    iHatSwing = p7

    iHatCount = 0

    print p3
    print itotalNotes

    until iHatCount >= itotalNotes do
        if iPitchQuotient == 0 then
            iHatPitch = 1
        else
            iHatPitch = 1 - iHatCount/iPitchQuotient
        endif

        iSaturated = 0

        if (iHatAccent == 0) then
            iAccented = 0
        elseif(iHatCount % iHatAccent == 0) then
            iAccented = 1
        else
            iAccented = 0
        endif

        SHatParams sprintfk {{ "ClosedHat" %f %f 0 %f %f }}, iHatPitch, iHatVelocity, iSaturated, iAccented

        if (iHatCount % 2 == 0) then
            beatScorelineS( "TR606", iHatCount*.25, .25, SHatParams )
        else
            beatScorelineS( "TR606", iHatCount*.25 + iHatSwing, .25 - iHatSwing, SHatParams )
        endif

        iHatCount += 1
    od
endin

