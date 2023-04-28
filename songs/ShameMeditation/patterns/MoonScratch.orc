instr MoonScratch
  if p4 == 0 then
    gaPunishScratchPointer = linseg:a( 0, \
      bts(1/2), .35, \
      bts(1/8), .35, \
      bts(1/8), .5, \
      bts(1/8), .5, \
      bts(3/8), .3, \
      bts(1/8), .3, \
      bts(3/8), .15, \
      bts(1/8), .15, \
      bts(1/4), 0, \
      bts(2.5), 1.4 \
    )
  elseif p4 == 1 then
    gaPunishScratchPointer = linseg:a( 0, \
      bts(1/2), .35, \
      bts(1/8), .35, \
      bts(0), .5, \
      bts(1/2), .5, \
      bts(3/8), .3, \
      bts(1/8), .3, \
      bts(3/8), .15, \
      bts(1/8), .15, \
      bts(1/4), 0, \
      bts(2.5), 1.4 \
    )
  elseif p4 == 2 then
    gaPunishScratchPointer = linseg:a( 0, \
      bts(1/2), .35, \
      bts(3/8), .155, \
      bts(0), .5, \
      bts(3/4), .5, \
      bts(1/4), .654, \
      bts(3/16), .67, \
      bts(0), .5, \
      bts(1/4), .65, \
      bts(3/16), .65, \
      bts(0), .5, \
      bts(1.4), 1.4 \
    )
  endif

  _ "PunishScratch", 0, stb(p3), 20
endin
