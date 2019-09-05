instr MetronomeTone

  ilen init .01
  iamp init 1

  kcutfreq  expon     10000, 0.1, 2500
  aamp      expon     iamp,  0.1,  .1
  arand     rand      aamp
  alp1      butterlp  arand,kcutfreq
  alp2      butterlp  alp1,kcutfreq
  ahp1      butterhp  alp2,3500
  asigpre   butterhp  ahp1,3500
  asig      linen    (asigpre+arand/2),0,ilen, .05

  out asig, asig
endin

instr Metronome
    kTrigger  metro  giBPM/60

    schedkwhen    kTrigger, 0, 0, "MetronomeTone", 0, giBPM/60
endin
