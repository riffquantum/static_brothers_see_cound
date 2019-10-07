;beatScoreline
; Scoreline statements in the orchestra don't respect any tempo statements which makes them pretty useless.
; This opcode formats a string for the scoreline opcode and adjusts the start time and duration with the global
; BPM value (giBPM). It's arguments are an instrument name, a start time in beats, a duration in beats, and a string of
; any other pfields the triggered instrument will need. It is intended to be used in the orhcestra with the
; scoreline_i opcode.

opcode beatScoreline, 0, SiiS
    SName, iStart, iDuration, SParams xin

    iStart = iStart * 60 / giBPM
    iDuration = iDuration * 60 / giBPM

    SscorelineString sprintfk {{i "%s" %f %f }}, SName, iStart, iDuration

    SscorelineString strcat SscorelineString, SParams

    scoreline_i SscorelineString
endop
