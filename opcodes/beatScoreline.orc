/*
  beatScoreline, _
  This opcode faciliates i events called from the orchestra instead of the score by wrapping
  schedule statements and calculating start times and durations based on the value of gkBPM.

  Global Variables:
    gkBPM - k - This opcode has no global variables scoped to it but it is heavily coupled
      with gkBPM which it uses to calculate timeing for events. Aliased to _ for convenience
      in sequencing.

  Input Arugments:
    SName -Instrument name for event to be called.
    iStart - Start time in beats for event to be called.
    iDuration - Duration in beats for event to be called.
    iP4 - Corresponds to p4 for the instrument to be called
    iP5 - Corresponds to p5 for the instrument to be called
    iP6 - Corresponds to p6 for the instrument to be called
    iP7 - Corresponds to p7 for the instrument to be called
    iP8 - Corresponds to p8 for the instrument to be called
    iP9 - Corresponds to p9 for the instrument to be called
    iP10 - Corresponds to p10 for the instrument to be called
    iP11 - Corresponds to p11 for the instrument to be called
    iP12 - Corresponds to p12 for the instrument to be called
    iP13 - Corresponds to p13 for the instrument to be called

  Outputs:
    none
*/


opcode beatScoreline, 0, Siioooooooooo
  SName, iStart, iDuration, iP4, iP5, iP6, iP7, iP8, iP9, iP10, iP11, iP12, iP13 xin
  iStart = beatsToSeconds(iStart)
  iDuration = beatsToSeconds(iDuration)

  schedule nstrnum(SName), iStart, iDuration, iP4, iP5, iP6, iP7, iP8, iP9, iP10, iP11, iP12, iP13
endop

/* An attempt at a version of this opcode that would work with fluid tempo changes

giNewArray[][][] init 99999999, 1000, 13
opcode bigListOfNotes, 0, Siioooooooooo
  SName, iStart, iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10 xin


  bigListOfNotes[iStart][0][nstrnum(SName), iDuration, iP1, iP2, iP3, iP4, iP5, iP6, iP7, iP8, iP9, iP10]

  giNewArray
endop

alwayson "CentralDispatch"
instr CentralDispatch

endin

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

*/

; Older versions still in use in some older songs

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
