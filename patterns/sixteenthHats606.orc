instr sixteenthHats606
    iHatVelocity = p4
    iPitchQuotient = p5
    iHatAccent = p6
    iHatSwing = p7

    iHatCount = 0
    until iHatCount == 16 do
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
            scoreline_i beatScoreline( "TR606", iHatCount*.25, .25, SHatParams )
        else
            scoreline_i beatScoreline( "TR606", iHatCount*.25 + iHatSwing, .25 - iHatSwing, SHatParams )
        endif

        iHatCount += 1
    od
endin