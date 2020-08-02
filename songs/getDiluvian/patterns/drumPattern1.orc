instr drumPattern1
  iVariation = p4

  beatScorelineS( "TR808", 0, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})
  beatScorelineS( "TR808", 1, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})
  beatScorelineS( "TR808", 2, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})
  beatScorelineS( "TR808", 3, 2, {{ "KickDrum5" 2 2 0 0 0 }})

  beatScorelineS( "TR808", 1, 2, {{ "SnareDrum5" 1.2 1 0 0 0 }})
  beatScorelineS( "TR808", 3, 2, {{ "SnareDrum5" 1.3 1 0 0 0 }})
  beatScoreline( "FunkyDrummerBreak", 1, .55,  127, 1, 3 )
  beatScoreline( "FunkyDrummerBreak", 3, .55,  127, 1, 3 )

  if iVariation == 0 then
    beatScoreline("LoserInTheEndBreak", 0, 4, 127, 1, 2)
  elseif iVariation == 1 then
    beatScoreline("LoserInTheEndBreak", 0, 4,  127, 1, 9 )
  elseif iVariation == 2 then
    beatScoreline("LoserInTheEndBreak", 0, 4,  127, 1, 8 )
  elseif iVariation == 3 then
    beatScoreline("LoserInTheEndBreak", 0, 4,  127, 1, 6 )
  endif
endin
