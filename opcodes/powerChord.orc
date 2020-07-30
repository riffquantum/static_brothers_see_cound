opcode powerChord, 0, Siioooooooooo
    SInstrumentName, iStartTime, iDuration, iAmplitude, iPitch, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin

    iRoot = iPitch

    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, iRoot, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, fifth(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
    beatScoreline SInstrumentName, iStartTime, iDuration, iAmplitude, octaveUp(iRoot), iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
endop
