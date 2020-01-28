opcode halfDiminishedSeventhChord, 0, Siioooooooooo
    SInstrumentName, iStartTime, iDuration, iAmplitude, iPitch, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin

    iRoot = (iPitch > 15 ? octcps(iPitch) : iPitch)

    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, iRoot, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, minorThird(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, flat(fifth(iRoot)), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, dominantSeventh(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
endop
