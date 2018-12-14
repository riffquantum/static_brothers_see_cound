instr drumPattern1
  iVariation = p4


  scoreline_i beatScoreline( "TR808", 0, 2, {{ "KickDrum5" 1.2 2 0 0 0 }})
  scoreline_i beatScoreline( "TR808", 1, 2, {{ "KickDrum5" 1.4 2 0 0 0 }})
  scoreline_i beatScoreline( "TR808", 2, 2, {{ "KickDrum5" 1.6 2 0 0 0 }})
  scoreline_i beatScoreline( "TR808", 3, 2, {{ "KickDrum5" 2 2 0 0 0 }})


  scoreline_i beatScoreline( "TR808", 1, 2, {{ "SnareDrum5" 1.2 1 0 0 0 }})
  scoreline_i beatScoreline( "TR808", 3, 2, {{ "SnareDrum5" 1.3 1 0 0 0 }})
  scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 1, .55, {{ .55 }} )
  scoreline_i beatScoreline( "funkyDrummerBreakDiskin", 3, .55, {{ .55 }} )

  if iVariation == 0 then
    scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  2 }})
  elseif iVariation == 1 then
    scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  9 }})
  elseif iVariation == 2 then
    scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  8 }})
  elseif iVariation == 3 then
    scoreline_i beatScoreline("loserInTheEndBreakDiskin", 0, 4, {{  6 }})
  endif
endin
