opcode minorThirteenthChord, 0, Siioooooooooo
    SInstrumentName, iStartTime, iDuration, iAmplitude, iPitch, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin

    iRoot = iPitch

    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, iRoot, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, minorThird(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, fifth(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, dominantSeventh(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, ninth(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, eleventh(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, thirteenth(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
endop
