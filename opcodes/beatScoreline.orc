;beatScoreline
; Scoreline statements in the orchestra don't respect any tempo statements which makes them pretty useless.
; This opcode formats a string for the scoreline opcode and adjusts the start time and duration with the global
; BPM value (gkBPM). It's arguments are an instrument name, a start time in beats, a duration in beats, and a string of
; any other pfields the triggered instrument will need. It is intended to be used in the orhcestra with the
; scoreline_i opcode.


; giNewArray[][][] init 99999999, 1000, 13
; opcode bigListOfNotes, 0, Siioooooooooo
;   SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin


;   bigListOfNotes[iStart][0][nstrnum(SName), iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10]

;   giNewArray
; endop

; alwayson "CentralDispatch"
; instr CentralDispatch

; endin


opcode beatScoreline, 0, Siioooooooooo
  SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin
  iStart = iStart * 60 / i(gkBPM)
  iDuration = iDuration * 60 / i(gkBPM)

  SscorelineString sprintfk {{i "%s" %f %f %f %f %f %f %f %f %f %f %f %f }}, SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10

  ;schedule
  schedule nstrnum(SName)+.001, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
  ;schedulewhen
  ;schedwhen 1, SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
  ;scoreline
  ;scoreline SscorelineString
  ;scoreline_i
  ;scoreline_i SscorelineString
  ;event
  ;event "i", SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
  ;event_is
  ;event_i "i", SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
endop

opcode beatScorelineMetro, 0, Siioooooooooo
  SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin
  kFrequencyForMetro = iStart * (gkBPM/60)
  kDuration = iDuration * 60 / gkBPM
  kTrigger metro kFrequencyForMetro, 0

  print iStart
  ; printk .2, kTrigger
  schedwhen kTrigger, SName, 0, kDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10

  schedkwhen kTrigger, 3600, 1, SName, 0, kDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10
endop

opcode beatScorelineS, 0, SiiS
  SName, iStart, iDuration, SParams xin

  iStart = iStart * 60 / i(gkBPM)
  iDuration = iDuration * 60 / i(gkBPM)

  SscorelineString sprintfk {{i "%s" %f %f }}, SName, iStart, iDuration

  SscorelineString strcat SscorelineString, SParams

  scoreline_i SscorelineString
endop

opcode beatScorelineA, 0, Siii[]
  SName, iStart, iDuration, iParams[] xin
  iStart = iStart * 60 / i(gkBPM)
  iDuration = iDuration * 60 / i(gkBPM)
  iIndex = 0

  SscorelineString sprintfk {{i "%s" %f %f }}, SName, iStart, iDuration

  until iIndex >= lenarray(iParams) do
    SscorelineString strcat SscorelineString, sprintfk("%i ", iParams[iIndex])
    iIndex += 1
  od

  scoreline_i SscorelineString
endop
